FROM golang:1.14.0-alpine3.11
MAINTAINER Kubesure <edakghar@gmail.com>
LABEL PROJECT_REPO_URL         = "git@github.com:kubesure/docker-debug.git" \
      PROJECT_REPO_BROWSER_URL = "https://github.com/kubesure/docker-debug" \
      DESCRIPTION              = "docker container to debug go programs in Docker and k8s" \
      VENDOR                   = "kubeusre" \
      VENDOR_URL               = "https://kubesure.io/"

ENV GOSU_VERSION=1.10
ENV KUBECTL_VERSION=v1.8.10

RUN apk --no-cache add ca-certificates \
  && apk --no-cache add --virtual build-dependencies curl git \
  && curl -O --location --silent --show-error https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 \
  && mv gosu-amd64 /usr/local/bin/gosu \
  && chmod +x /usr/local/bin/gosu \
  && go get -u github.com/fullstorydev/grpcurl \
  && go install github.com/fullstorydev/grpcurl/... \
  && grpcurl --help \
  && apk del --purge build-dependencies

WORKDIR /grpcurl
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]

