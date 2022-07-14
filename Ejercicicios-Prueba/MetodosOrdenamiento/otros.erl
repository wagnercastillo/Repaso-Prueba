-module(otros).
-export([burbuja/1, leer/1, cortarLista/2, insercion/1, seleccion/2, qsort/1, quick_sort/1]).
-import(lists, [sublist/2, max/1, delete/2]).

burbuja([H | T]) ->
    compareHeads(H, T, [], [H | T]).

compareHeads(H, [NextHead | T], [], OriginalList) ->
    if
        H < NextHead ->
            compareHeads(NextHead, T, [H], OriginalList);
        true ->
            compareHeads(H, T, [NextHead], OriginalList)
    end;
compareHeads(H, [NextHead | T], OriginalOutputList, OriginalList) ->
    if
        H < NextHead ->
            OutputList = OriginalOutputList ++ [H],
            compareHeads(NextHead, T, OutputList, OriginalList);
        true ->
            OutputList = OriginalOutputList ++ [NextHead],
            compareHeads(H, T, OutputList, OriginalList)
    end;
compareHeads(H, [], OriginalOutputList, OriginalList) ->
    OutputList = OriginalOutputList ++ [H],
    if
        OriginalList == OutputList ->
            io:format("Lista ordenada: ~w~n", [OutputList]);
        true ->
            burbuja(OutputList)
    end.

leer(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    [
        begin
            {Int, _} = string:to_integer(Token),
            Int
        end
     || Token <- string:tokens(erlang:binary_to_list(Binary), "\n")
    ].

cortarLista(Lista, N) -> sublist(Lista, N).

insercion(L) -> lists:foldl(fun insert/2, [], L).
insert(X, []) -> [X];
insert(X, L = [H | _]) when X =< H -> [X | L];
insert(X, [H | T]) -> [H | insert(X, T)].

seleccion([], Sort) ->
    Sort;
seleccion(Ar, Sort) ->
    M = max(Ar),
    Ad = delete(M, Ar),
    seleccion(Ad, [M | Sort]).

qsort([]) -> [];
qsort([X | Xs]) -> qsort([Y || Y <- Xs, Y < X]) ++ [X] ++ qsort([Y || Y <- Xs, Y >= X]).

quick_sort(L) -> qs(L, trunc(math:log2(erlang:system_info(schedulers)))).

qs([], _) ->
    [];
qs([H | T], N) when N > 0 ->
    {Parent, Ref} = {self(), make_ref()},
    spawn(fun() -> Parent ! {l1, Ref, qs([E || E <- T, E < H], N - 1)} end),
    spawn(fun() -> Parent ! {l2, Ref, qs([E || E <- T, H =< E], N - 1)} end),
    {L1, L2} = receive_results(Ref, undefined, undefined),
    L1 ++ [H] ++ L2;
qs([H | T], _) ->
    qs([E || E <- T, E < H], 0) ++ [H] ++ qs([E || E <- T, H =< E], 0).

receive_results(Ref, L1, L2) ->
    receive
        {l1, Ref, L1R} when L2 == undefined -> receive_results(Ref, L1R, L2);
        {l2, Ref, L2R} when L1 == undefined -> receive_results(Ref, L1, L2R);
        {l1, Ref, L1R} -> {L1R, L2};
        {l2, Ref, L2R} -> {L1, L2R}
    after 5000 -> receive_results(Ref, L1, L2)
    end.
