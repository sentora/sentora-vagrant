#!/usr/bin/env bash

echo "Basic default setup of sentora-cora and sentora-installer/preconf"

cd ./Core && git clone git@github.com:sentora/sentora-core.git && git clone git@github.com:sentora/sentora-installers.git && cd ../ &&  vagrant up
