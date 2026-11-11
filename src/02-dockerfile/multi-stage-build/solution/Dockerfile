# ---------- Stage 1: build ----------
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod ./
COPY . .
RUN CGO_ENABLED=0 go build -o myapp

# ---------- Stage 2: minimal runtime ----------
FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/myapp .
EXPOSE 8080
ENTRYPOINT ["./myapp"]
