-module(p04).
-export([len/1]).

len(L)->
	len(L,0).

len([_|T], L)->
	len(T, L+1);
len([], L)->
	L.
