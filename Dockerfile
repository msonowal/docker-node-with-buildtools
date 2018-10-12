FROM node:8-alpine
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

# --no-cache: download package index on-the-fly, no need to cleanup afterwards
# --virtual: bundle packages, remove whole bundle at once, when done
RUN apk --no-cache --virtual build-dependencies add \
    python \
    make \
    g++ \
    && npm install \
    && apk del build-dependencies
        
RUN echo "Install NPM AND YARN and some essentials deps"
RUN apk --no-cache add \
    nodejs-npm \
    curl \
    yarn \
    tar \
    gzip \
    bash \
    git \
    unzip \
    wget \
    openssh-client \
    openssh \
    sudo

RUN node -v
RUN npm -v
RUN yarn -v

EXPOSE 3000
CMD [ "npm", "start" ]
