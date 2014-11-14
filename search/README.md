# Creating and Registering Extractors for Riak Search

## Configure Riak

`advanced.config`

```
[{vm_args, [{"-pa /opt/beams",""}]}].
```

## Compile the Extractor

```
erlc yz_httpheader_extractor.erl
```

Move the resulting beam file to your beams directory

```
mv yz_httpheader_extractor.beam /opt/beams/
```

## Register the Extractor in Riak

```
riak start
riak attach
```

This should log you into the running riak node

```
(riak@127.0.0.1)1> yz_extractor:register("application/httpheader", yz_httpheader_extractor).
```

The register call should return the updated list of mimetype -> extractor mappings. It should look something like this:

```
[{default,yz_noop_extractor},
 {"application/httpheader",yz_httpheader_extractor},
 {"application/json",yz_json_extractor},
 {"application/riak_counter",yz_dt_extractor},
 {"application/riak_map",yz_dt_extractor},
 {"application/riak_set",yz_dt_extractor},
 {"application/xml",yz_xml_extractor},
 {"text/plain",yz_text_extractor},
 {"text/xml",yz_xml_extractor}]
```

The new extractor can be verified using the yokozuna `extract` endpoint:

```
curl -XPUT -H 'content-type: application/httpheader' 'http://localhost:8098/search/extract' --data-binary "@testdata.bin"
```

The new extractor can also be verified in the Riak console:

```
(riak@127.0.0.1)1> yz_extractor:run(<<"GET http://www.google.com HTTP/1.1\n">>, yz_httpheader_extractor).
```