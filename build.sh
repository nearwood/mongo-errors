#!/bin/bash

# Get sed executeable
if which -s gsed; then
	SED=gsed;
elif which -s sed; then
	SED=sed;
else
	echo 'Error, could not find sed'
	exit 1
fi

# Download error codes from github and convert to JS code
curl https://raw.githubusercontent.com/mongodb/mongo/master/src/mongo/base/error_codes.err |
grep -v 'mode: python' |
$SED 's/#/\/\//' |
$SED '1i exports.class = {};' |
$SED 's/error_code("\(\w*\)", \([0-9]*\) *)/exports.\1 = \2;/' |
$SED 's/;;$/;/' |
$SED 's/"\(\w*\)"/exports.\1/g' |
$SED 's/error_class(exports\.\(\w*\),/exports.class.\1 =/' |
$SED 's/])$/];/g' > index.js
