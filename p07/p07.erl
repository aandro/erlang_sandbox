-module(p07).
-export([flatten/1]).

flatten(L) ->
	flatten(L, []).

flatten([H|T], Tail) ->
    flatten(H, flatten(T, Tail));	
flatten([], Tail) -> 
	Tail;
flatten(E, Tail) -> 
	[E|Tail].
