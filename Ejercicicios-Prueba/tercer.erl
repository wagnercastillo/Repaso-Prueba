-module(tercer).
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