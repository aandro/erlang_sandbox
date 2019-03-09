-module(p06).
-export([is_palindrome/1]).

is_palindrome(L) -> 
	is_palindrome(L,L,[]).
	
is_palindrome(Init,[H|T], Acc) ->
	is_palindrome(Init, T, [H|Acc]);
is_palindrome(Init, [], Result = Init) ->
	true;
is_palindrome(Init, [], Result) ->
	false.