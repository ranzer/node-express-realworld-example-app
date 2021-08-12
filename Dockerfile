#Build stage for the app
FROM node:lts-alpine3.14 AS dependencies
WORKDIR /root/build
COPY app.js package*.json project-logo.png ./
COPY config ./config
COPY models ./models
COPY public ./public
COPY routes ./routes
RUN npm install --only=production

FROM dependencies AS release
COPY --from=dependencies /root/build/ /opt/app/
WORKDIR /opt/app
EXPOSE 3000
CMD npm run start
