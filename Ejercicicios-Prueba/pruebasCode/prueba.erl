-module(prueba).
-export([pruebaList/1]).


pruebaList(E) ->
    List = [1,2,3,4,5,6,7,8,9,10],
  
    % A= [X ||X <- List, X =:= E],
    %A=lists:member(E, List),
    C.