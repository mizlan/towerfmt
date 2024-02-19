open CCFormat

let pp_row f row =
  fprintf f "@[[%a]@]" (CCList.pp ~pp_sep:(return ", ") Plterm.pp) row

let pp_board f board = fprintf f "@[<v1>[%a]@]" (CCList.pp pp_row) board
let pp_count f xs = fprintf f "[@[<h1>%a]@]" (CCList.pp Plterm.pp) xs

let pp f (n, board, t, b, l, r) =
  fprintf f "T =@\n          @[<v>%a,@]@,C = counts(@[<v0>%a@]),@,ntower(%a, T, C).@\n"
    pp_board board (CCList.pp pp_count) [ t; b; l; r ] int n
