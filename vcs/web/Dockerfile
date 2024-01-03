FROM nginx:stable-bullseye

RUN apt-get update && apt-get install cgit fcgiwrap -y
COPY nginx.conf /etc/nginx/nginx.conf
COPY cgitrc /etc/cgitrc

RUN chown nginx:nginx -R /usr/share/cgit
COPY spawn_fcgi.sh /docker-entrypoint.d
RUN chmod +x /docker-entrypoint.d/spawn_fcgi.sh
