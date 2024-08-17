ARG MONGODB_VERSION=3
FROM mongo:${MONGODB_VERSION}

ARG NODEJS_VERSION=16
ARG NVM_VERSION=0.39.2

RUN apt-get update  -qq && \
    apt-get install -qq --assume-yes --no-install-recommends --no-install-suggests \
        curl \
      > /dev/null # silence stdout && \
    apt-get clean

RUN curl --silent --show-error --output - \
      https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | \
    bash > /dev/null

RUN export NVM_DIR="$HOME/.nvm"  && \
    \. "$NVM_DIR/nvm.sh"         && \
    nvm install ${NODEJS_VERSION} && \
    nvm install-latest-npm

WORKDIR /opt/variety

COPY package-lock.json /opt/variety/package-lock.json
COPY package.json /opt/variety/package.json

COPY spec /opt/variety/spec
COPY variety.js /opt/variety/variety.js
COPY .babelrc /opt/variety/.babelrc
COPY entrypoint /opt/variety/docker/entrypoint.sh

ENTRYPOINT ["/opt/variety/docker/entrypoint.sh"]
