# Requirements:
# - Port 8080 - Multi-stage build
# - Lightweight final image
# - Non root user
# - Project structure:
#    my-app/
#          ├── main.go
#          ├── go.mod
#          └── go.sum

#First stage:
FROM golang:1.21 AS build

WORKDIR /my-app/

COPY go.mod go.sum /my-app/

RUN  go mod download && \
#    go sum download

# Why in RUN we have go mod and not go.mod? If you tell Docker RUN go.mod download, it looks for a program named go.mod. Since that's just a text file you copied in, Docker will say "Permission denied" or "Command not found."
# go.mod lists the names of your dependencies. go.sum lists the specific security hashes (fingerprints) of those dependencies to make sure they haven't been tampered with.
# When you run go mod download, Go automatically looks for go.sum in the same folder to verify the files. You don't need a second command.

COPY . .

RUN CGO_ENABLED=0 go build -o app-binary

#Setting CGO_ENABLED=0 tells Go: Pack everything you need into this one binary file. This makes the file Static.
# app-binary is the name we are locking our compiled binaries and use this name in stage 2 to get the binaries.

# When you run go build -o /app-binary, the Go compiler takes:
# All your source code (main.go, etc.)
# All your libraries (from go mod download)
# The Go Runtime itself
# It mashes them all together into one single binary file named /app-binary.
# Why we only grab that one file
# In Stage 2, you don't need the source code, the go.mod file, or even the Go compiler anymore.
# The Binary is independent: Once that /app-binary file is created, it can run all by itself (especially with CGO_ENABLED=0).
# Efficiency: If you copied the source code and libraries into Stage 2, your image would be hundreds of megabytes larger for no reason.
# Security: If a hacker gets into your container, they won't find your source code—only the compiled binary.


#CGO stands for C Go. It is the bridge that allows Go packages to call C code. By setting CGO_ENABLED=0, you tell the compiler to use only pure Go code, 
#which makes your binary completely portable and static.


#stage-2:

FROM alpine:latest

COPY --from=build /my-app/app-binary

EXPOSE 8080

CMD ["./app-binary"]
