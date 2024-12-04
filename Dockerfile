FROM golang:1.23.1-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o ./binary

FROM alpine:edge AS final 

WORKDIR /app 

RUN addgroup -g 1313 --system stream \
    && adduser -G stream --system -D -s /bin/sh -u 1313 starburst \
    && chown -R starburst:stream /app

USER starburst

COPY --chown=starburst:stream --from=builder /app/binary .

EXPOSE 8080

CMD ["/app/binary"]