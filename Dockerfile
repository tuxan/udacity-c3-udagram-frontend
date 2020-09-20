# Use NodeJS base image
FROM node:13-alpine as build

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies by copying
# package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy app source
COPY . .

# Build ionic application as production
RUN npm run build -- --prod


## Use ngnix to serve ionic application build
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build  /usr/src/app/www /usr/share/nginx/html