-module(server).
-export([start/0]).
-define(tcp_opts, [binary, {active, true}, {packet, 0}, {reuseaddr, true}]).

-define(errorlog, io:format("errorlog point ~n")).


start() ->
    start(8093).

start(Port) ->
    {ok, ListenSocket} = gen_tcp:listen(Port, ?tcp_opts),
    register(server, spawn(fun()-> server_conn(ListenSocket) end)),
    server_conn(ListenSocket).

server_conn(ListenSocket) ->
    case gen_tcp:accept(ListenSocket) of
        {ok, Socket} ->
            io:format("conecct success: ~p~n", [Socket]),
            server_route();
        {error, Reason} ->
            io:format("Socket closed : ~p~n", [Reason])
    end.


server_route() ->
    receive
        {tcp, Socket, Data} ->
            gen_tcp:send(Socket, Data);
        {tcp_closed, Socket} ->
            ?errorlog,
            gen_tcp:close(Socket)
    end.