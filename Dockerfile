FROM aditirvan/phusion-passenger-nginx:2.7.4-alpine

COPY . .
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]