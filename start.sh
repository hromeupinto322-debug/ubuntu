#!/usr/bin/env bash
set -e

export DISPLAY=:1
export PORT="${PORT:-8080}"
export VNC_PASSWORD="${VNC_PASSWORD:-changeme}"

Xvfb :1 -screen 0 1280x720x24 &
sleep 2

fluxbox &
xterm &

x11vnc \
  -display :1 \
  -forever \
  -shared \
  -rfbport 5900 \
  -listen 127.0.0.1 \
  -passwd "$VNC_PASSWORD" &

websockify \
  --web=/usr/share/novnc/ \
  0.0.0.0:$PORT \
  127.0.0.1:5900
