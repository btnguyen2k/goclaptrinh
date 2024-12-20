## Dockerfile to build and package website content as a Docker image.
# Sample build command:
# docker build --rm -t btnguyen2k/goclaptrinh -f Dockerfile .

FROM golang:1.19-alpine AS builder_docs
RUN mkdir -p /build/dosrc
COPY ./dosrc /build/dosrc
RUN cd /build \
    && go install github.com/btnguyen2k/docms/docli@cli-v0.3.1.3 \
    && docli build --purge --src dosrc --out dodata

FROM btnguyen2k/docmsruntime:stable as docmsruntime
LABEL maintainer="Thanh Nguyen"
COPY --from=builder_docs /build/dodata /app/dodata
WORKDIR /app
EXPOSE 8000
ENV FRONTEND_TEMPLATE=blogy
CMD ["/app/main"]
