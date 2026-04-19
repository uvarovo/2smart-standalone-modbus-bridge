FROM node:14-alpine

# Modern Alpine dropped the python2 "python" alias. Newer node images ship
# python3 via the `python3` package and npm/node-gyp here (node-gyp 5+)
# understand python3 natively.
ENV PYTHON=/usr/bin/python3

RUN apk update \
    && apk add --no-cache bash git make gcc g++ python3 linux-headers udev tzdata \
    && npm install serialport@^8.0.5 --build-from-source

COPY .bin .bin
COPY etc etc
COPY lib lib
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY app.js app.js

RUN npm i --production

CMD npm start
