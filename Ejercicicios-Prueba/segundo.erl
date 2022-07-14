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

%tercer:presentar([]). 

-module(nrandom).
-export([presentar/1]).
-import(lists, [sublist/2, max/1, delete/2]).

presentar(Arreglo) ->
    Aleatorio = rand:uniform(1000),
    io:format("numero aleatorio: ~w~n", [Aleatorio]),
    timer:sleep(500),
    if
        length(Arreglo) == 240 ->
            %io:format("~w~n",[Arreglo]),
            seleccion(Arreglo,1);
    true ->
        presentar(Arreglo++[Aleatorio])
    end.

seleccion([], Sort) ->
    Sort;
seleccion(Ar, Sort) ->
    M = max(Ar),
    Ad = delete(M, Ar),
    seleccion(Ad, [M | Sort]).