#!/bin/bash

if [ -e HxSet.zip ]; then
    rm HxSet.zip
fi

zip HxSet.zip haxelib.json LICENSE README *.hx test.hxml
