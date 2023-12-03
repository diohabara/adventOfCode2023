open Helper
open! Stdio
open! Base

let update_hashmap (number_color_strs : string list) =
  let map = Hashtbl.create (module String) in
  let update_map (str : string) =
    let str = String.strip str in
    match Str.split (Str.regexp " ") str with
    | [ count; color ] ->
        let count = Int.of_string count in
        Hashtbl.update map color ~f:(fun o ->
            match o with
            | None -> count
            | Some current_value -> max count current_value)
    | _ -> ()
  in
  List.iter number_color_strs ~f:update_map;
  map

let turn_line_into_number line =
  let regexp = Str.regexp "Game \\([0-9]+\\):" in
  let game_id =
    if Str.string_match regexp line 0 then Some (Str.matched_group 1 line)
    else None
  in
  let extract_number_color_pairs line =
    let number_color_regexp =
      Str.regexp "\\([0-9]+\\) \\(red\\|green\\|blue\\)"
    in
    let rec get_all_matches i =
      if i >= String.length line then []
      else
        match Str.search_forward number_color_regexp line i with
        | _ ->
            let number = Str.matched_group 1 line in
            let color = Str.matched_group 2 line in
            (number ^ " " ^ color) :: get_all_matches (Str.match_end ())
        | exception _ -> []
    in
    get_all_matches 0
  in
  let number_color_list = extract_number_color_pairs line in
  let color_number = update_hashmap number_color_list in
  let red_meets_requirement =
    (match Hashtbl.find color_number "red" with Some v -> v | None -> 0) <= 12
  in
  let green_meets_requirement =
    (match Hashtbl.find color_number "green" with Some v -> v | None -> 0)
    <= 13
  in
  let blue_meets_requirement =
    (match Hashtbl.find color_number "blue" with Some v -> v | None -> 0)
    <= 14
  in
  ( (match game_id with Some v -> Int.of_string v | None -> 0),
    red_meets_requirement && green_meets_requirement && blue_meets_requirement
  )

let sum_of_ids_that_meet_requirement filename =
  let lines = read_lines filename in
  let values = List.map ~f:turn_line_into_number lines in
  List.fold_left values ~init:0 ~f:(fun acc (game_id, meets) ->
      if meets then acc + game_id else acc)

(* Part 2 *)
let create_max_map (number_color_strs : string list) =
  let map = Hashtbl.create (module String) in
  let update_map (str : string) =
    let str = String.strip str in
    match Str.split (Str.regexp " ") str with
    | [ count; color ] ->
        let count = Int.of_string count in
        Hashtbl.update map color ~f:(fun o ->
            match o with
            | None -> count
            | Some current_value -> max count current_value)
    | _ -> ()
  in
  List.iter number_color_strs ~f:update_map;
  map

let turn_line_into_number' line =
  let extract_number_color_pairs line =
    let number_color_regexp =
      Str.regexp "\\([0-9]+\\) \\(red\\|green\\|blue\\)"
    in
    let rec get_all_matches i =
      if i >= String.length line then []
      else
        match Str.search_forward number_color_regexp line i with
        | _ ->
            let number = Str.matched_group 1 line in
            let color = Str.matched_group 2 line in
            (number ^ " " ^ color) :: get_all_matches (Str.match_end ())
        | exception _ -> []
    in
    get_all_matches 0
  in
  let number_color_list = extract_number_color_pairs line in
  let color_number = create_max_map number_color_list in
  let red_min =
    match Hashtbl.find color_number "red" with Some v -> v | None -> 0
  in
  let green_min =
    match Hashtbl.find color_number "green" with Some v -> v | None -> 0
  in
  let blue_min =
    match Hashtbl.find color_number "blue" with Some v -> v | None -> 0
  in
  red_min * green_min * blue_min

let sum_of_ids_that_meet_requirement' filename =
  let lines = read_lines filename in
  let values = List.map ~f:turn_line_into_number' lines in
  List.fold_left values ~init:0 ~f:( + )
