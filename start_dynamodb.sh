#!/bin/sh

set -e

exec java -Djava.library.path=. -jar DynamoDBLocal.jar "$@"

