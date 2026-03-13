FROM golang:1.24 AS buildtools

RUN go install github.com/bazelbuild/buildtools/buildozer@latest \
    github.com/bazelbuild/buildtools/buildifier@latest

FROM eclipse-temurin:21-jre-jammy

ARG COPYBARA_VERSION=v20260309
ARG COPYBARA_SHA256=aea3881ecb039dd2dd8f20a312322704805e6199b452f9277bfa954531e12418

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        ca-certificates \
        curl \
        git \
        mercurial \
        openssh-client \
        quilt && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o /tmp/copybara_deploy.jar "https://github.com/google/copybara/releases/download/${COPYBARA_VERSION}/copybara_deploy.jar" && \
    echo "${COPYBARA_SHA256}  /tmp/copybara_deploy.jar" | sha256sum -c - && \
    install -d /opt/copybara && \
    install -m 0644 /tmp/copybara_deploy.jar /opt/copybara/copybara_deploy.jar && \
    rm -f /tmp/copybara_deploy.jar

COPY --from=buildtools /go/bin/buildozer /go/bin/buildifier /usr/local/bin/
COPY copybara /usr/local/bin/copybara

RUN chmod +x /usr/local/bin/copybara

ENTRYPOINT ["/usr/local/bin/copybara"]
CMD ["migrate", "copy.bara.sky"]
WORKDIR /usr/src/app
