FROM nginx
COPY src/main/java/net/wiam/webapp/WEB-INF/index.html /usr/share/nginx/html
EXPOSE 80