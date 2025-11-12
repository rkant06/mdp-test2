#!/bin/bash
set -e

cd "$(dirname "$0")"

rm -rf package lambda.zip
mkdir package

# install dependencies into ./package
pip install -r requirements.txt --target ./package

# copy function code
cp app.py package/

# create deployment zip
cd package
zip -r9 ../lambda_function.zip .
cd ..

echo "✅ Lambda package created at $(pwd)/lambda_function.zip"