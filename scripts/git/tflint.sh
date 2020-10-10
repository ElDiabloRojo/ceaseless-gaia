#!/bin/sh

if ! $(which tflint); then
  printf 'Error: tflint not found!'
  exit 1
fi

for m in $(ls $(pwd)/modules/); do
  printf 'linting module: %s\n' "$m"
  tflint --deep --module $(pwd)/modules/${m}
  
  if [ $? -eq 0 ]; then
    printf 'SUCCESS\n'
  else
    printf 'FAILED\n'
    exit 1
  fi
done
