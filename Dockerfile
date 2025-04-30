FROM golang:1.24 as builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY . .

RUN go build -o main .

FROM gcr.io/distroless/static-debian12

COPY --from=builder /app/main /app/main

EXPOSE 8080

CMD ["./main"]
