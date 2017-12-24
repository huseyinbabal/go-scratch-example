FROM instrumentisto/glide as builder
WORKDIR /go/src/github.com/go-scratch-example
COPY . .
RUN glide install
RUN CGO_ENABLED=0 GOOS=linux go build -a -tags sctratch-exampl -o build/go-scratch-example -ldflags ‘-w’ .

FROM scratch
COPY --from=builder /go/src/github.com/go-scratch-example/build/go-scratch-example app
ENV PORT 3000
EXPOSE 3000
ENTRYPOINT ["/app"]
