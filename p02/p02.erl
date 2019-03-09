-module(p02).
-export([but_last/1]).

but_last([A, B])->
	L = [A, B],
	L;
but_last([_|T])->
	but_last(T).