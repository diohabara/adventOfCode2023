let read_lines (filename : string) : string list =
  let rec helper (channel : in_channel) : string list =
    try
      let line = input_line channel in
      line :: helper channel
    with End_of_file -> []
  in
  let channel = open_in filename in
  let lines = helper channel in
  close_in channel;
  lines

let turn_line_into_number (line : string) : int =
  let is_digit = function '0' .. '9' -> true | _ -> false in
  let rec helper (line : string) (first : int option) (last : int option)
      (index : int) : int =
    if index == String.length line then
      match (first, last) with
      | Some f, Some l -> (f * 10) + l
      | Some f, None -> (f * 10) + f
      | None, Some _ -> 0
      | None, None -> 0
    else if is_digit line.[index] then
      let digit = int_of_string (String.make 1 line.[index]) in
      match first with
      | None -> helper line (Some digit) last (index + 1)
      | Some _ -> helper line first (Some digit) (index + 1)
    else helper line first last (index + 1)
  in
  helper line None None 0

let sum_of_numbers_in_string (filename : string) : int =
  let lines = read_lines filename in
  let rec helper (lines : string list) (acc : int) : int =
    match lines with
    | [] -> acc
    | h :: t ->
        let number = turn_line_into_number h in
        helper t (acc + number)
  in
  helper lines 0

(* Part 2 *)

let word_to_digit = function
  | "zero" -> 0
  | "one" -> 1
  | "two" -> 2
  | "three" -> 3
  | "four" -> 4
  | "five" -> 5
  | "six" -> 6
  | "seven" -> 7
  | "eight" -> 8
  | "nine" -> 9
  | _ -> -1

let turn_line_into_number' line =
  let is_digit = function '0' .. '9' -> true | _ -> false in
  let regexp =
    Str.regexp
      "\\(one\\|two\\|three\\|four\\|five\\|six\\|seven\\|eight\\|nine\\|[0-9]\\)"
  in
  let first =
    try
      if Str.search_forward regexp line 0 >= 0 then Str.matched_string line
      else ""
    with Not_found -> ""
  in
  let last =
    try
      if Str.search_backward regexp line (String.length line) >= 0 then
        Str.matched_string line
      else ""
    with Not_found -> ""
  in
  let first_digit =
    if first <> "" && is_digit first.[0] then int_of_string first
    else word_to_digit first
  in
  let last_digit =
    if last <> "" && is_digit last.[0] then int_of_string last
    else word_to_digit last
  in
  (first_digit, last_digit)

let sum_of_numbers_in_string' (filename : string) : int =
  let lines = read_lines filename in
  let values = List.map turn_line_into_number' lines in
  List.fold_left (fun acc (f, l) -> acc + ((f * 10) + l)) 0 values
