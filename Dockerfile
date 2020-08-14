FROM golang:alpine

# Set necessary environmet variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Move to working directory /build
WORKDIR /build

# Copy the code into the container
COPY . .

# Download dependency using go mod
# RUN go mod download
# RUN go mod init


# Build the application
# RUN go get .
RUN go mod vendor
RUN go build -o main .

# Move to /dist directory as the place for resulting binary folder
WORKDIR /dist

# Copy binary from build to main folder
RUN cp /build/main .

# Export necessary port
EXPOSE 8000
EXPOSE 6060

# Command to run when starting the container
CMD ["/dist/main"]