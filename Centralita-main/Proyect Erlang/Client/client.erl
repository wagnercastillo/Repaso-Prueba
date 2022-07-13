-module(client).
-export([start/0, service/3, clienteJson/3]).
-define(tcp_opts, [binary, {packet, 0}, {active, true}]).
-import(string,[concat/2]).
-import(inicio, [insertarOpcion/1, obtenerDatos/0]).

start() ->
    inets:start(httpd, [
        {modules, [
            mod_alias,
            mod_auth,
            mod_esi,
            mod_actions,
            mod_cgi,
            mod_dir,
            mod_get,
            mod_head,
            mod_log,
            mod_disk_log
        ]},
        {port, 8090},
        {server_name, "cuarto"},
        {server_root, "/home/usercluster/erlangserver"},
        {document_root, "/home/usercluster/erlangserver/htdocs"},
        {erl_script_alias, {"/api", [client]}},
        {error_log, "error.log"},
        {security_log, "security.log"},
        {transfer_log, "transfer.log"},
        {mime_types, [
            {"html", "text/html"},
            {"css", "text/css"},
            {"js", "application/x-javascript"},
            {"json", "application/json"}
        ]}
    ]),
    start("localhost", 8093).

start(IP, Port) ->
    %ets:new(table_opcion, [bag, public, named_table]),
    register(client, spawn(fun() -> conn_client(IP, Port) end)).

service(SessionID, _Env, _Input) -> 
    io:format("Data: ~p~n", [_Input]),
    io:format("Data1: ~p~n", [_Env]),
    mod_esi:deliver(SessionID,
    ["Content-Type: text/html\r\n\r\n","<html><body>Hola a todos!</body></html>"]
).

clienteJson(SessionID, _Env, _Input) -> 
    io:format("Data: ~p~n", [_Input]),
    io:format("Data1: ~p~n", [_Env]),
    Str1 = "{\"alumno\":\"Centralita\",  \"Opcion\":\"",
    Str2 = concat(_Input,"\"}"),
    insertarOpcion(_Input),
    %ets:insert(table_opcion,{1, _Input}),
    mod_esi:deliver(SessionID,
    ["Content-Type: application/json\r\n\r\n", concat(Str1, Str2)]).
   
  
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
    %Este valor necesita ser reemplazado por el controlador 
    % Esperar una consulta
    %Msg = ets:match(table_opcion, '$1'),
    % Enviar la respuesta una vez 
    Msg= obtenerDatos(),
    R= optTelefono(Msg),
    io:format("Opcion seleccionada: ~p ~n", [Msg]),
    io:format("Respuesta: ~p~n", [R]),
    Pack = term_to_binary(Msg),
    gen_tcp:send(Socket, Pack).
    %send_msg(Socket).

optTelefono(Msg) ->
    case Msg of
        "1" ->
            " Se genera un sonido de colgado, el telefono a central, Msg: Ha colgado";
        "2" ->
            "Se genera un sonido de llamada, la centralita a telefono, Msg: Hay una llamada entrante, sonido de llamada";
        "3" ->
            "La centralita a telefono, Msg: Hay señal, sonido de tono";
        "4" ->
            "Telefono a centralita, Msg: A marcado un numero y a colgado";
        "5" ->
            "Hay sonido de tono de llamada(pii-pii), La centralita debe comunicar al telefono, Msg: Sonido de tono de llamada propio";
        "6" ->
            "Esta hablando con la persona X, La centralita a Telefono, Msg, Conectado al otro extremo, sonido de hablar (Hablando)";
        _ ->
            "0pción no valida"
    end.


