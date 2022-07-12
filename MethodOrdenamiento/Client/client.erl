-module(client).
-export([start/0]).

-define(tcp_opts, [binary, {packet, 0}, {active, true}]).

start() ->
    start("localhost", 8093).

start(IP, Port) ->
    register(client, spawn(fun() -> conn_client(IP, Port) end)).

conn_client(IP, Port) ->
    case gen_tcp:connect(IP, Port, ?tcp_opts) of
        {ok, Socket} ->
            send_msg(Socket),
            do_handle_client(Socket),
            io:format("connection successed! ~w~n", [Socket]),
            conn_client(IP, Port);
        {error, Reason} ->
            io:format("connection failed!~n"),
            exit(Reason)
    end.

do_handle_client(Socket) ->
    receive
        {tcp, Socket, Packet} ->
            recv_msg(Packet),
            do_handle_client(Socket);
        {tcp_closed, Socket} ->
            gen_tcp:close(Socket)
    end.


recv_msg(Packet) ->
    Msg = binary_to_term(Packet),
    io:format("Reveived Msg: ~p", [Msg]).

send_msg(Socket) ->
    Msg = io:get_line('[Ingresa el vector a ordenar:]'),
    
    L= ordenar(Msg),
    io:format("Tu vector: ~p ~n", [Msg]),
    io:format("Vector arreglado: ~p~n", [L]),

    Pack = term_to_binary(Msg),
    gen_tcp:send(Socket, Pack),
    send_msg(Socket).

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

