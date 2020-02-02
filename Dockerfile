FROM node:alpine AS builder

WORKDIR '/app'

COPY package.json ./
RUN npm install

COPY . .

#CMD [ "npm", "run", "build" ]
RUN npm run build
#our build output is now in /app/build

FROM nginx AS run
EXPOSE 80

COPY --from=builder /app/build/ /usr/share/nginx/html

#default command starts nginx, so we don't have to have a CMD option
