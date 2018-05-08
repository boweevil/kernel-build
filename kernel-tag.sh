#!/bin/bash

# Let the first agurement be the tag version we want.
VERSION=$1

# substatue the tagged version in this neat one liner.
git archive --format=tar --prefix=linux-${VERSION}-$(git rev-parse --short v${VERSION})/ v${VERSION} | (cd /home/ryan/kernels/ && tar -x)
