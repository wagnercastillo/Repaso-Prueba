% En un servicio web se requiere enviar un arreglo de mínimo 20 datos 
% y que mediante el uso del método shell se pueda ordenar, le resultado 
% debe mostrarse en el navegador

-module(primero).
-export([start/0, clienteJson/3, ordenar/1]).
-import(string,[concat/2]).
-import(lists, [sublist/2]).

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
		{port,8070},
		{server_name,"shell"},
		{server_root, "C://serverPrueba"},
        {document_root, "C://serverPrueba/htdocs"},
        {erl_script_alias, {"/api", [primero]}},
        {error_log, "error.log"},
        {security_log, "security.log"},
        {transfer_log, "transfer.log"},
        {mime_types, [
        	{"html", "text/html"},
        	{"css", "text/css"},
        	{"js", "application/x-javascript"},
            {"json", "application/json"}
        ]}
	]).

clienteJson(SessionID, _Env, _Input) -> 

	Ar = [list_to_integer(X)|| X<-string:tokens(_Input,",")],
	A = ordenar(Ar),
	io:format("arreglo: ~p~n",[A]),
    io:format("Data: ~p~n", [_Input]),

	B = "["++lists:concat(lists:join(",",A))++"]",
    Str1 = "{\"Respuesta\":\"",
    Str2 = concat(B,"\"}"),
    mod_esi:deliver(SessionID,
    ["Content-Type: application/json\r\n\r\n", concat(Str1, Str2)]
	%Arreglo = 
	%io:format("arreglo: ~w~n",[Arreglo])
).


separa(L) ->
    lists:split(length(L) div 2, L).

 mezcla([], L) ->
    L;
 mezcla(L, []) ->
    L;
 mezcla([H1|T1] = L1, [H2|T2] = L2) ->
    if
       H1 =< H2 -> [H1|mezcla(T1,L2)];
       true-> [H2|mezcla(L1, T2)]
    end.
 ordenar([])->[];
 ordenar([H])-> [H];
 ordenar(L)->
    {L1, L2} = separa(L),
    mezcla(ordenar(L1), ordenar(L2)).


%http://localhost:8000/api/server:clienteJson/1,2,7,9,3,45,87,23,455,8987,23,1,54,766,45,23232,46,8786,54,34,23,23,54,877,54,2323,4,54,231,53,656