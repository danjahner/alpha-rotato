#!/bin/bash

set -x -e

bosh manifest -d $BOSH_DEPLOYMENT > manifest.yml
bosh deploy -n -d $BOSH_DEPLOYMENT manifest.yml

