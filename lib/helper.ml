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
