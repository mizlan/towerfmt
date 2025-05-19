open Towerfmt

let () =
  let input = In_channel.(input_lines stdin) in
  List.iter
    (fun i ->
      match Parse_tower.parse i with
      | Ok res -> Print_pl.pp (Format.get_std_formatter ()) res
      | Error e -> print_endline e)
    input
