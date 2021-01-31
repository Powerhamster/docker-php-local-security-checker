FROM golang:1.15 AS go

WORKDIR /go/src

RUN git clone https://github.com/fabpot/local-php-security-checker.git /go/src
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o local-php-security-checker .

FROM alpine:3.13
COPY --from=go /go/src/local-php-security-checker /usr/local/bin/local-php-security-checker
WORKDIR /app
ENTRYPOINT [ "/usr/local/bin/local-php-security-checker" ]