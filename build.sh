# Download error codes from github
curl https://raw.githubusercontent.com/mongodb/mongo/master/src/mongo/base/error_codes.err |
grep -v 'mode: python' |
gsed 's/#/\/\//' |
gsed '1i exports.code = {};' |
gsed '2i exports.class = {};' |
gsed 's/error_code("\(\w*\)", \([0-9]*\) *)/exports.code.\1 = \2;/' |
gsed 's/;;$/;/' |
gsed 's/"\(\w*\)"/exports.code.\1/g' |
gsed 's/error_class(exports\.code\.\(\w*\),/exports.class.\1 =/' |
gsed 's/])$/];/g' > index.js
