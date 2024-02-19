open Towerfmt

let () =
  let input = In_channel.(input_lines stdin) in
  let i = List.hd input in
  let res = Parse_tower.parse i in
  match res with
  | Ok res -> Print_pl.pp (Format.get_std_formatter ()) res
  | Error e -> print_endline e
