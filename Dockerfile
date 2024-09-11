FROM node:20.11-alpine3.18 AS builder

# install simple http server for serving static content
RUN npm install -g http-server

# make the 'workspace' folder the current working directory
WORKDIR /workspace

# TODO: add env vars
ARG API_URL

# copy both 'package.json' and 'package-lock.json' (if available)
COPY package*.json ./

# install project dependencies
RUN npm install

# copy project files and folders to the current working directory (i.e. 'workspace' folder)
COPY . .

# TODO: echo env vars to .env file
RUN touch .env
RUN echo -e "$API_URL" >> .env;

# build app for production with minification
RUN npm run build

RUN rm -rf ./node_modules

RUN ls -a
RUN cat .env

EXPOSE 8080
CMD [ "http-server", "./dist/spa" ]
