FROM busybox:latest

ARG GEM_VERSION_NAIS_LOG_PARSER

COPY nais-log-parser-$GEM_VERSION_NAIS_LOG_PARSER.gem /tmp/

CMD [ "echo", "hei" ]
