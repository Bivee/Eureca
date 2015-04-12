#!/bin/sh

dbicdump -o dump_directory=./lib -o components="[qw{InflateColumn::DateTime}]" Eureca::Schema 'dbi:mysql:dbname=eureca' root  bivee@258
