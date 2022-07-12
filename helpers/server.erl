-module(server).
-import (database_logic,[initDB/0, storeDB/2]).
-export([start/1]).

start(Port) ->
    spawn(fun() -> 
        ets:new(table_phones, [bag, public, named_table]),
        srv_init(Port)
        
    end).

%set_phones(N) ->
%    Numeros = [].

srv_init(Port) ->
    
    Opts = [{reuseaddr, true}, {active, false}],
    {ok, Socket} = gen_tcp:listen(Port, Opts),
    srv_loop(Socket).

srv_loop(Socket) ->
    
    {ok, SockCli} = gen_tcp:accept(Socket),
    Pid = spawn(fun() -> worker_loop(SockCli) end),
    %io:format("Socket:~w",[Socket]),
    %io:format("SockCli:~w",[SockCli]),
    io:format("~p",[self()]),
    gen_tcp:controlling_process(SockCli, Pid),
    inet:setopts(SockCli, [{active, true}]),
    srv_loop(Socket).

worker_loop(Socket) ->
    receive
        {tcp, Socket, Msg} ->
            io:format("Recibido ~p: ~p~n", [self(), Msg]),
            if 
                Msg == "registrar" ->
                    %Salida = io_lib:format("Ingrese numero: ~s", [Msg]);
                    Salida = io_lib:format("~s",["Ingrese numero:"]);
                true ->
                    
                    Salida = io_lib:format("Numero registrado: ~s", [Msg]),
                    ets:insert(table_phones, {Msg, Socket}),
                    Out = ets:match(table_phones,'$1'),
                    io:format("Guardado: ~p", [Out])
                end,
                gen_tcp:send(Socket, Salida),
                worker_loop(Socket);
            %timer:sleep(5000), %% 5 segundos de espera
            
        {tcp_closed, Socket} ->
            io:format("Finalizado.~n");
            Any ->
            io:format("Mensaje no reconocido: ~p~n", [Any])
        end.

%store_data(table, data, socket) ->
    