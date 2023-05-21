set.seed(4)

sim_survey <- fabricatr::fabricate(
  province = fabricatr::add_level(N = 2),
  year = fabricatr::add_level(N = 2, nest = FALSE),
  id = fabricatr::link_levels(
    N = 5000,
    by = fabricatr::join_using(province, year),
    housing = sample(c(0, 1), size = 5000, replace = TRUE, prob = c(0.4, 0.6)),
    debt = sample(c(0, 1), size = 5000, replace = TRUE, prob = c(0.3, 0.7)),
    weight = runif(N, min = 0.5, max = 2.5)
    )
  ) |>
dplyr::mutate(
  housing = factor(housing,
    levels = c(0, 1),
    labels = c("renter", "owner")),
  debt = factor(debt,
    levels = c(0, 1),
    labels = c("yes", "no")),
  province = factor(province,
    levels = c(1, 2),
    labels = c("ascington", "braeq")),
  year = factor(year,
    levels = c(1, 2),
    labels = c("2019", "2021"))
    )

sim_survey_srvy <- sim_survey |>
  srvyr::as_survey(weights = weight)


freq_perc <-
    function(survey, var_name, ...) {
      survey |>
        dplyr::group_by(..., .data[[var_name]]) |>
        dplyr::summarize(perc = srvyr::survey_mean(),
                         freq = dplyr::n()) |>
        dplyr::select(-perc_se)
    }

cookie_cutter <- function(srvyr_obj, var_list, ...) {
  summary_list <- purrr::map(
    var_list,
    function(var) {
      freq_perc(srvyr_obj, var, ...)
    }
    )
    summary_list <- purrr::set_names(summary_list,
      nm = purrr::map(.x = var_list,
        ~ glue::glue(.x, "_summary")))
    return(summary_list)
}

formula_factory <- function(var1, var2) {
  reformulate(termlabels = c(var1, var2))
}

annotations <- function(survey_df, var1, var2, ...) {
  formula = formula_factory(var1, var2)
    annotation_df <- survey_df |>
    dplyr::group_by(...) |>
    tidyr::nest() |>
    dplyr::mutate(model = purrr::map(
        data,
      function(data = data) {
        srvyr::as_survey(.data = data, weights = weight) |>
        srvyr::svychisq(formula = formula)
      }),
    tidy = purrr::map(model, broom::tidy)
    ) |>
    tidyr::unnest(tidy)
    return(annotation_df)
}

# var_list = c("debt", "housing")
var_list = c("housing")

# It's important to not quote additional grouping variables!!
ownership <- cookie_cutter(srvyr_obj = sim_survey_srvy, var_list = var_list, year, province) |>
purrr::pluck("housing_summary")


housing_chisq <- annotations(sim_survey, var1 = "housing", var2 = "province", year)


## gg function factory
survey_name <- ggplot2::as_labeller(c(
      "2019" = "2019 survey",
      "2021" = "2021 survey")
  )

# prov_name <- ggplot2::as_labeller(c(
#       "ascington" = "Ascington",
#       "braeq" = "Braeq")
#   )


gg_factory <- function(data, x, wrap, annotation_df) 
  ggplot2::ggplot(data, ggplot2::aes({{ x }}, y = perc)) +
  # <https://ggplot2.tidyverse.org/reference/as_labeller.html>
  ggplot2::geom_col() +
  ggplot2::facet_wrap(dplyr::enquo(wrap), labeller = survey_name) +
  ggplot2::scale_x_discrete(
      # use a function that capitalizes the first word
      labels = stringr::str_to_sentence
    ) +
  ggplot2::scale_y_continuous(
  labels = scales::percent_format(accuracy = 1),
  limits = c(0, 1),
  expand = c(0, 0)
  ) +
  ggplot2::labs(x = "", y = "Percentage") +
  ggplot2::geom_text(
    ggplot2::aes(label = scales::percent(perc, accuracy = 0.1)),
    position=ggplot2::position_dodge(width=0.9), vjust=-0.25) +
    ggsignif::geom_signif(
    data = annotation_df,
    xmin = "ascington", # xmin
    xmax = "braeq", #xmax
    y_position = 0.9,
    vjust = -0.2,
    textsize = 3,
    ggplot2::aes(annotations = p_star(p.value)),
    # annotations = p_star(p.value),
    manual = TRUE
    )

p_star <- function(p) {
  symbol = dplyr::case_when(
    # p <= 0.001 ~ "***",
    # p <= 0.01 ~ "**",
    p <= 0.05 ~ "*",
    TRUE ~ "NS")
  return(symbol)
}

gg_factory(
  data = ownership |> dplyr::filter(housing == "owner"),
  x = province, 
  wrap = year,
  annotation_df = housing_chisq)

# test formulate factory ===
# df_demo <- purrr::map(1:4, ~ rnorm(100)) |>
#   purrr::set_names(nm = c(paste0("x", 1:3), "y")) |>
#   as.data.frame() |>
#   dplyr::mutate(group = factor(rep(c("f", "m"), each = 50)))
#
# # head(df_demo)
#
# # this does not work; how can I get the model as an output?
# # model_factory <- function(var) {
# #   model <- lm(y ~ var, data = data)
# #   return(model)
# # }
#
# # func <- function(var) {
# # func <- function(formula) {
# func <- function(formula, by) {
#   # model <- model_factory(var = var)
#   output <- df_demo |>
#     # dplyr::group_by(group) |>
#     dplyr::group_by(.data[[by]]) |>
#     tidyr::nest() |>
#     dplyr::mutate(model = purrr::map(data,
#         function(data, ...) {
#           # lm(y ~ var, data = data)
#           lm(formula, data = data)
#         }),
#       tidy = purrr::map(model, broom::tidy)
#       ) |>
#     tidyr::unnest(tidy)
#   return(output)
# }
# # tmp <- func(var = "x1")
# # tmp <- func(formula = y ~ x1)
# tmp <- func(formula = y ~ x1, by = "group")
#
# tmp
#
# # reformulate
# model_factory <- function(var) {
#   model <- reformulate(termlabels = var, response = "y")
#   return(model)
# }
#
# func <- function(var, by) {
# # func <- function(formula) {
# # func <- function(formula, by) {
#   formula <- model_factory(var = var)
#   output <- df_demo |>
#     # dplyr::group_by(group) |>
#     dplyr::group_by(.data[[by]]) |>
#     tidyr::nest() |>
#     dplyr::mutate(model = purrr::map(data,
#         function(data, ...) {
#           # lm(y ~ var, data = data)
#           lm(formula, data = data)
#         }),
#       tidy = purrr::map(model, broom::tidy)
#       ) |>
#     tidyr::unnest(tidy)
#   return(output)
# }
# # tmp <- func(var = "x1")
# # tmp <- func(formula = y ~ x1)
# # tmp <- func(formula = y ~ x1, by = "group")
# tmp <- func(var = "x1", by = "group")
#
# tmp
#
#

# test gg function factory ====
# gg_template_factory <- function(data, x, wrap) {
#     ggplot2::ggplot(data, ggplot2::aes({{ x }}, perc)) + # x = province
#       ggplot2::geom_col() +
#       ggplot2::facet_wrap(dplyr::enquo(wrap)) +
#       ggplot2::scale_y_continuous(
#         labels = scales::percent_format(accuracy = 1),
#         limits = c(0, 1),
#         expand = c(0, 0)
#         )
# }
# gg_template_factory(ownership |> dplyr::filter(housing == "owner"), province, year)
#
