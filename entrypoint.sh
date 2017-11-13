#!/bin/sh
VIDEO_SIZE=${VIDEO_SIZE:-"1920x1080"}
DISPLAY=${DISPLAY:-"99"}
FILE_NAME=${FILE_NAME:-"video.mp4"}
exec ffmpeg -y -f x11grab -video_size "$VIDEO_SIZE" -r 12 -i "browser:$DISPLAY" -codec:v libx264 "/data/$FILE_NAME"
