open Aoc2023.Day1
open Aoc2023.Day2

let day1 =
  print_endline "# Day 1 #";
  print_endline "## Sample (should be 142) ##";
  sum_of_numbers_in_string "./data/day1-partial.txt"
  |> string_of_int |> print_endline;
  print_endline "## Full ##";
  sum_of_numbers_in_string "./data/day1.txt" |> string_of_int |> print_endline;
  print_endline "## Sample2 (should be 281) ##";
  sum_of_numbers_in_string' "./data/day1-partial2.txt"
  |> string_of_int |> print_endline;
  print_endline "## Full2 ##";
  sum_of_numbers_in_string' "./data/day1.txt" |> string_of_int |> print_endline

let day2 =
  print_endline "# Day 2 #";
  print_endline "## Sample (should be 8) ##";
  sum_of_ids_that_meet_requirement "./data/day2-partial.txt"
  |> string_of_int |> print_endline;
  print_endline "## Full ##";
  sum_of_ids_that_meet_requirement "./data/day2.txt"
  |> string_of_int |> print_endline;
  print_endline "## Sample (should be 2286) ##";
  sum_of_ids_that_meet_requirement' "./data/day2-partial.txt"
  |> string_of_int |> print_endline;
  print_endline "## Full ##";
  sum_of_ids_that_meet_requirement' "./data/day2.txt"
  |> string_of_int |> print_endline

let () =
  day1;
  day2
