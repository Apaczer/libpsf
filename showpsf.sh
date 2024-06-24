#!/bin/sh
cd "$(dirname "$0")" || exit
SDL_NOMOUSE=1 LD_LIBRARY_PATH=$(pwd)/libs/ ./showpsf "$1"
