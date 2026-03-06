#!/bin/sh
set -e
cd "$(dirname "$0")"
python3 -c "
import zipfile
with zipfile.ZipFile('../../../../_output/lambda-function.zip', 'w') as z:
    z.write('index.py', 'index.py')
"
