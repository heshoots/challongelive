FROM nginx:1.13.8
COPY dist /usr/share/nginx/html
EXPOSE 8080
