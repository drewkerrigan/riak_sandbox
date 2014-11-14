
-module(yz_httpheader_extractor).
-compile(export_all).

extract(Value) ->
    extract(Value, []).

extract(Value, _Opts) ->
    {ok,{http_request,Method,
            {absoluteURI,http,Host,undefined,Uri},
            _Version},
        _Rest} = erlang:decode_packet(http,Value,[]),

    [{method, Method}, {host, list_to_binary(Host)}, {uri, list_to_binary(Uri)}].