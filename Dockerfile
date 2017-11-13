FROM alpine:3.6

RUN apk update
RUN apk add alpine-sdk
RUN echo -e 'kixiro\nkixiro\n' | adduser kixiro
RUN addgroup kixiro abuild
RUN chmod a+w /var/cache/distfiles
RUN su kixiro -c "cd ~ && git clone git://git.alpinelinux.org/aports"
ADD APKBUILD /home/kixiro/aports/main/ffmpeg/
RUN su kixiro -c "cd ~/aports/main/ffmpeg/ && abuild checksum && abuild unpack && abuild deps"
RUN su kixiro -c "cd ~/aports/main/ffmpeg/ && abuild build"


FROM alpine:3.6

RUN apk update \
	&& apk add \
                x264-libs \
                sdl2 \
                libxcb \
                libbz2 \
		netcat-openbsd \
	&& rm -rf /var/cache/apk/*
ADD entrypoint.sh /
COPY --from=0 /home/kixiro/aports/main/ffmpeg/src/ffmpeg-3.4/ffmpeg /usr/bin/ffmpeg

ENTRYPOINT ["/entrypoint.sh"]
