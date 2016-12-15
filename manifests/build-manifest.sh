#!/bin/sh
cd "$(dirname "$0")"
spruce merge manifest-bosh-lite.yml boilerplate/*
