FROM alpine:3.19

ARG VERSION=dev
ENV GREETING=hello
ENV APP_VERSION=$VERSION

WORKDIR /app
COPY app.sh .
RUN chmod +x app.sh

CMD ["./app.sh"]
