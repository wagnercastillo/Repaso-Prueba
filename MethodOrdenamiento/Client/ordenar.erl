-module(ordenar).
-export([ordenar/1]).

separa(L) ->
    lists:split(length(L) div 2, L).

mezcla([], L) ->
    L;
mezcla(L, []) ->
    L;
mezcla([H1 | T1] = L1, [H2 | T2] = L2) ->
    if H1 =< H2 ->
           [H1 | mezcla(T1, L2)];
       true ->
           [H2 | mezcla(L1, T2)]
    end.

ordenar([]) ->
    [];
ordenar([H]) ->
    [H];
ordenar(L) ->
    {L1, L2} = separa(L),
    mezcla(ordenar(L1), ordenar(L2)).
