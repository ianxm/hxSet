#!/bin/bash

if [ -e HxSet.zip ]; then
    rm HxSet.zip
fi

zip HxSet.zip haxelib.xml LICENSE README *.hx test.hxml
