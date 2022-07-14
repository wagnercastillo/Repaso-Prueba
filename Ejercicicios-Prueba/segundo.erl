-module(segundo).
-export([revertirCadena/1, vocales/1, consonantes/1]).

revertirCadena(Cadena) ->
    T = lists:reverse(Cadena),
    T.

vocales(T) ->
    A = [[C] || C <- T, lists:member(C, [$A, $a, $E, $e, $I, $i, $O, $o, $U, $u])],
    Tam = length(A),
    {A, Tam}.

consonantes(T) -> 
    A = [[C] || C <- T, lists:member(C, [$b, $B, $d, $D, $f, $F, $g, $G, $h, $H, $j, $J, $k ,$K, $l, $L, $m, $M, $n, $N, $ñ, $Ñ, $p, $P, $q, $r, $s ,$S, $t, $T, $v, $Y, $x, $X, $y, $Y, $z, $Z])],
    Tam = length(A),
    {A, Tam}.

