FROM golang:1.22.5 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN GOOS=linux go build -C="cmd/ordersystem" -ldflags="-w -s" -o ordersystem .

FROM alpine:3.18

ARG DB_DRIVER
ARG DB_HOST
ARG DB_PORT
ARG DB_USER
ARG DB_PASSWORD
ARG DB_NAME
ARG WEB_SERVER_PORT
ARG GRPC_SERVER_PORT
ARG GRAPHQL_SERVER_PORT

ENV DB_DRIVER ${DB_DRIVER}
ENV DB_HOST ${DB_HOST}
ENV DB_PORT ${DB_PORT}
ENV DB_USER ${DB_USER}
ENV DB_PASSWORD ${DB_PASSWORD}
ENV DB_NAME ${DB_NAME}
ENV WEB_SERVER_PORT ${WEB_SERVER_PORT}
ENV GRPC_SERVER_PORT ${GRPC_SERVER_PORT}
ENV GRAPHQL_SERVER_PORT ${GRAPHQL_SERVER_PORT}



RUN apk add --no-cache bash curl ca-certificates \
    && apk add --no-cache libc6-compat \
    && curl -L https://github.com/golang-migrate/migrate/releases/download/v4.15.2/migrate.linux-amd64.tar.gz | tar xvz \
    && mv migrate /usr/local/bin/

WORKDIR /app

COPY --from=builder /app/cmd/ordersystem/ordersystem .
COPY --from=builder /app/internal/infra/database/migrations ./migrations
COPY --from=builder /app/.env .

EXPOSE $WEB_SERVER_PORT $GRPC_SERVER_PORT $GRAPHQL_SERVER_PORT

CMD ["/bin/sh", "-c", "migrate -path=./migrations -database \"$DB_DRIVER://$DB_USER:$DB_PASSWORD@tcp($DB_HOST:$DB_PORT)/$DB_NAME\" up && ./ordersystem"]
