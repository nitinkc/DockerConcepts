# Build stage — static binary only
FROM golang:1.22-alpine AS build
WORKDIR /src
COPY go.mod main.go ./
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /app main.go

# Runtime stage — distroless: no shell, no package manager, non-root by tag
FROM gcr.io/distroless/static:nonroot
COPY --from=build /app /app
USER nonroot
EXPOSE 8080
ENTRYPOINT ["/app"]
