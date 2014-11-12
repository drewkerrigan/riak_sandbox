#!/bin/bash

for num in 1 2 3 4 5 6 7 8 9 10; do curl -XPUT -H "Content-Type: text/plain" -d "mytest" "http://localhost:8098/buckets/mybucket/keys/$num" ; echo "" ; done