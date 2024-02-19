open Angstrom

let is_alpha = function 'a' .. 'z' -> true | _ -> false
let is_digit = function '1' .. '9' -> true | _ -> false
let digit = satisfy is_digit >>| fun x -> Char.code x - Char.code '0'
