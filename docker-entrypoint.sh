#! /usr/bin/env bash

NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
VARIETY_DOCKER_DIR=/opt/variety

cd $VARIETY_DOCKER_DIR || exit

npm install

npm run test:mocha
