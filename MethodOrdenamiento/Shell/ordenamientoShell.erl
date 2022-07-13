-module(ordenamientoShell).
-export([ordenar/1, for/3]).


ordenar(L) ->

    io:format("Hola este un mensaje de prueba: ~w \n", [L]).


for(N, N, F) ->
    F(N);

for(I, N, F) ->
    [F(I) | for(I+1, N, F)].


%ordenamientoShell:for(1, 10, fun(I) -> io:format("Linea: ~w\n", [I]) end).