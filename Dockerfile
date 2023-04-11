FROM node:lts-alpine

# Installs piece of software that lets you stop this container without having to terminate it
RUN apk add dumb-init --no-cache

WORKDIR /home/node/app

COPY --chown=node package.json yarn.lock /home/node/app/
RUN yarn install --prod --frozen-lockfile && yarn cache clean
COPY --chown=node . .

USER node

EXPOSE 3000
VOLUME [ "/home/node/app/images" ]
ENTRYPOINT [ "dumb-init", "--" ]
CMD [ "node", "server.js" ]
