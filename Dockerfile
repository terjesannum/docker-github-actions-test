FROM busybox:latest

COPY nais-log-parser-0.39.4.gem /tmp/

CMD [ "echo", "hei" ]
