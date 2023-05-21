freq_perc <-
  function(srvyr_obj, var_name, ...) {
    srvyr_obj |>
      dplyr::filter(!is.na(.data[[var_name]])) |>
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

# It's important to not quote additional grouping variables!!
annotations <- function(survey_df, var1, var2, ...) {
  formula = formula_factory(var1, var2)
  annotation_df <- survey_df |>
    dplyr::group_by(...) |>
    tidyr::nest() |>
    dplyr::mutate(
      model = purrr::map(
        data,
        function(data = data) {
          srvyr::as_survey(.data = data, weights = weight) |>
            srvyr::svychisq(formula = formula)
        }
      ),
      tidy = purrr::map(model, broom::tidy)
    ) |>
    tidyr::unnest(tidy)
  return(annotation_df)
}
# <https://bookdown.org/Maxine/r4ds/nesting.html>

p_star <- function(p) {
  symbol = dplyr::case_when(
    # p <= 0.001 ~ "***",
    # p <= 0.01 ~ "**",
    p <= 0.05 ~ "*",
    TRUE ~ "NS")
  return(symbol)
}


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
    manual = TRUE
    )
# can safely ignore the warning about the missing aesthetics
# <https://github.com/const-ae/ggsignif#example>


