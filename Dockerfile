FROM node:12.5-alpine

# python → python3 in current Alpine; expose PYTHON for node-gyp (used by native builds).
ENV PYTHON=/usr/bin/python3

RUN apk update \
    && apk add bash git make gcc g++ python3 linux-headers udev tzdata \
    && npm install -g node-gyp@9 \
    && npm install serialport@^8.0.5 --build-from-source

COPY .bin .bin
COPY etc etc
COPY lib lib
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY app.js app.js

RUN npm i --production

CMD npm start
