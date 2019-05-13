# Build Phase

FROM node:alpine as builder

WORKDIR /app

COPY package.json .
COPY package-lock.json .

RUN npm install

COPY . .

RUN npm run build

# Deploy Phase

FROM nginx:alpine as deployment

COPY --from=builder /app/build /usr/share/nginx/html

#nginx start is the default command for the image.
