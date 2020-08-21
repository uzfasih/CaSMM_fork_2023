FROM strapi/base

WORKDIR /usr/src/app/client
COPY ./client/package.json .
COPY ./client/yarn.lock .
RUN yarn install
COPY ./client .
RUN PUBLIC_URL=/client yarn build

WORKDIR /usr/src/app
COPY ./server/package.json .
COPY ./server/yarn.lock .
RUN yarn install
COPY ./server .
ENV NODE_ENV production
RUN yarn build
RUN mv ./client/build/* ./public/client \
    && rm -rf ./client
CMD yarn start