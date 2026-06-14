#!/bin/sh

exec footclient "$@" 2>/dev/null || exec foot "$@"
