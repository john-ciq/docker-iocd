# FROM nginx:1.15.12
FROM nginx:latest

## Copy the config file
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
## Copy the index.html file
COPY html/index.html /usr/share/nginx/html/index.html
