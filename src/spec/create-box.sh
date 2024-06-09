#!/bin/sh

dagger -m github.com/by-nelson/daggerverse/vagrant@v0.0.1 call create-box --username-arg=bynelson --boxname-arg=${BUILD_NAME} --token-arg ${CLOUD_TOKEN} debug
