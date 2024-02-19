open CCFormat

type plterm = PVar | PInt of int

let pp f = function PVar -> char f '_' | PInt i -> int f i
