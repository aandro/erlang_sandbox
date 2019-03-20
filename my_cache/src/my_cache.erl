-module(my_cache).

%% API exports
-export([create/0, insert/3, lookup/1, delete_obsolete/0]).

%%====================================================================
%% API functions
%%====================================================================

create() ->
	ets:new(cache_table, [named_table]).
	
insert(Key, Value, TtlInSeconds) when is_integer(TtlInSeconds) ->	
	ets:insert(cache_table, {Key, {Value, create_ttl(TtlInSeconds)}}),
	ok.
	
lookup([Object]) ->
	{_, {_, {_,_} = DateTime}} = Object,
	case is_alive(DateTime) of
		true -> {ok, Object};
		false -> dead
	end;
lookup([]) ->
	notfound;
lookup(Key) ->
	lookup(ets:lookup(cache_table, Key)).
	
delete_obsolete() ->
	ets:foldl(fun({Key, {_, {_,_} = DateTime}}, Ignore) ->
		case is_alive(DateTime) of
		true -> ok;
		false -> ets:delete(cache_table, Key)
		end,
		Ignore		
    end, ok, cache_table).

%%====================================================================
%% Internal functions
%%====================================================================

create_ttl(Seconds) ->
	Date = calendar:universal_time(),
	DateInSeconds = calendar:datetime_to_gregorian_seconds(Date),
	NewDateInSeconds = DateInSeconds + Seconds,
	calendar:gregorian_seconds_to_datetime(NewDateInSeconds).

is_alive({Date, Time}) ->
	calendar:universal_time() < {Date, Time}.
