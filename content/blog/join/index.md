---
slug: "join"
title: "Join two data sets"
date: 2021-12-24T13:26:57-05:00 
publishdate: 2021-12-24
lastmod: 2021-12-24
tags: ["rtlas"]
draft: false
autonumbering: true
output:
  html_document:
    keep_md: true
---







## Problem

`marks.xlsx` has the following columns:




```
# A tibble: 30 × 6
      id midterm final  lab1  lab2  lab3
   <int>   <int> <int> <int> <int> <int>
 1     2      33    15    NA    NA    NA
 2     3      16     5    NA    NA    NA
 3     7      13    27    NA    NA    NA
 4    10      22    11    NA    NA    NA
 5    13      33    17    NA    NA    NA
 6    14      28    50    NA    NA    NA
 7    18      25    35    NA    NA    NA
 8    20      18    43    NA    NA    NA
 9    22       8    35    NA    NA    NA
10    23      39    23    NA    NA    NA
# … with 20 more rows
```


Columns `lab1`, `lab2`, `lab3` are currently empty.
Their values are stored in another file `labs.xlsx`,


```
# A tibble: 100 × 4
      id  lab1  lab2  lab3
   <int> <int> <int> <int>
 1     1     3     9     1
 2     2     9    10     7
 3     3     1     5     7
 4     4     7     6     7
 5     5     4     7     1
 6     6     9     6    10
 7     7     2     2     0
 8     8     1     4     1
 9     9     9     0     4
10    10    10     6     4
# … with 90 more rows
```

## Solution

The students included in `marks.xlsx` is a subset of `labs.xlsx`,
evidenced by their different number of rows.
To grab the `lab1` - `lab3` data from `labs.xlsx` and fill them in `marks.xlsx`,
I can use `dplyr::left_join()`.

```r 
marks <- dplyr::left_join(marks[, 1:3], labs, by = "id")
marks
```

```
# A tibble: 30 × 6
      id midterm final  lab1  lab2  lab3
   <int>   <int> <int> <int> <int> <int>
 1     2      33    15     9    10     7
 2     3      16     5     1     5     7
 3     7      13    27     2     2     0
 4    10      22    11    10     6     4
 5    13      33    17     2    10     0
 6    14      28    50     0     6     6
 7    18      25    35     8     3     7
 8    20      18    43     8     1    10
 9    22       8    35     5     6     8
10    23      39    23     3    10     1
# … with 20 more rows
```

I can then export `marks`

```r 
readr::write_csv(tmp, file = "path/to/marks_new.csv")
```

## Epilogue

When I implemented this solution,
there was one more complication:
the `labs.xlsx` was originally not a single file,
but separated into 9 files.
I imported and concatenated them in one go with `purrr`.


```r 
# assuming the the 9 files are names "lab#.xlsx"
labs_file <- list.files(path = "./marks", pattern = "^lab", full.names = TRUE)
labs_data <- purrr::map_dfr(labs_file, ~readxl::read_excel(.x))
```

