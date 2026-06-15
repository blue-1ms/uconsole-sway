#!/bin/sh

export CODEX_TUI_DISABLE_KEYBOARD_ENHANCEMENT=1
exec foot --term=foot "$@"
