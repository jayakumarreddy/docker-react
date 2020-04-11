# Stage 0 is build stage
FROM node:alpine as build-stage

WORKDIR /app

# COPY package.json prior to copying all the code files
# This way docker will not run npm install if there is any change in the code. 
# Only runs if there is change in package.json
COPY package.json /app/

RUN npm install

# Copying all the code files to /app/.
# This code files will stay along with node_modules in /app
COPY ./ /app/

# this will run npm build and place the build folder 
# in /app/ in the container, as WORKDIR is /app
RUN npm run build

# Stage 1 is for serving builded static files with nginx
FROM nginx

COPY --from=build-stage /app/build/ /usr/share/nginx/html

#copy nginx config here



