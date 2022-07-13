-module(inicio).
-include ("server.record.hrl").
-export([init/0, insertarOpcion/1, obtenerDato/1, obtenerDatos/0]).

init() -> 
    application:set_env(mnesia,dir,"../db"),
	mnesia:create_schema([node()]),
	mnesia:start(),
    io:format("number table = ~p~n",[mnesia:create_table(tableOpcion,[{attributes,record_info(fields,tableOpcion)},{disc_copies,[node()]}])]),
    mnesia:info().  


insertarOpcion(Number) ->
	DataOpcion = #tableOpcion{ opcion = Number},
	Fun = fun() ->
				mnesia:write(DataOpcion)
		  end,
	Trans_result = mnesia:transaction(Fun),
    io:format("result: ~p~n", [Trans_result]),
	case Trans_result of
		{aborted, Reason} ->
			unable_to_insert;
		{atomic, Result} ->
			done;
		_ ->
			unable_to_insert
	end.


obtenerDato(Opcion) -> 
    Fun = fun() -> 
        mnesia:read(tableOpcion, Opcion)
    end,
    Lookup = mnesia:transaction(Fun),
    io:format("validity : ~p~n",[Lookup]),
    case Lookup of
        {atomic, Cell} ->
	io:format("validity : ~p~n",[Cell]);
        _ -> 
            io:format("Nothing"),
            Cell = []
    end,
    Cell.

obtenerDatos() ->
	Fun = fun() ->
				mnesia:all_keys(opcion)
		  end,
	Lookup = mnesia:transaction(Fun),
    io:format("validity : ~p~n",[Lookup]),
    case Lookup of
        {atomic, Cell} ->
	io:format("validity : ~p~n",[Cell]);
        _ -> 
            io:format("Nothing"),
            Cell = []
    end,
    Cell.