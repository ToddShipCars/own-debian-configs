#!/bin/sh

rpm2cpio "$1" | cpio -idmv --no-absolute-filenames

