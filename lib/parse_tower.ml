open CCList
open Angstrom
open Parse_util
open Plterm

let prefix =
  "https://www.chiark.greenend.org.uk/~sgtatham/puzzles/js/towers.html#"

let urlcount =
  let* cs = sep_by1 (char '/') (option PVar (digit >>| fun x -> PInt x)) in
  let l = List.length cs in
  let n = l / 4 in
  match chunks n cs with
  | [ t; b; l; r ] -> return (t, b, l, r)
  | _ -> fail "incorrect number of /'s"

type boardsym = Skip of int | Height of int
type board = Empty | Locs of boardsym list

let urlboard =
  let e =
    let s =
      let* c = satisfy is_alpha in
      return (Skip (Char.code c - Char.code 'a' + 1))
    in
    let h =
      let* c = satisfy is_digit in
      let* () = skip_while (fun c -> c = '_') in
      return (Height (Char.code c - Char.code '0'))
    in
    let* syms = many1 (s <|> h) in
    return (Locs syms)
  in
  char ',' *> e <|> return Empty

let populate n = function
  | Empty -> List.init n (fun _ -> List.init n (fun _ -> PVar))
  | Locs ls ->
      let expand = function
        | Height h -> [ PInt h ]
        | Skip s -> List.init s (fun _ -> PVar)
      in
      chunks n (List.concat_map expand ls)

let url =
  (string prefix <?> "initial part of the URL")
  *>
  let* n = digit <?> "N" in
  char ':'
  *>
  let* t, b, l, r = urlcount <?> "counts" in
  let* board = urlboard <?> "board state" in
  return (n, populate n board, t, b, l, r)

let parse = parse_string ~consume:Consume.All url
