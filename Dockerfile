FROM nginx/unit:1.21.0-php7.3

RUN apt-get update && apt-get install -y \
    php7.3-mysql \
    php7.3-gd

COPY docker/config.json /docker-entrypoint.d/config.json

RUN mkdir -p /var/www/html && mkdir -p /speedtest/

COPY backend/ /speedtest/backend
COPY ["results/*.php", "results/*.ttf", "/speedtest/results/"]
COPY ["favicon.ico", "*.js", "docker/*.php", "docker/entrypoint.sh", "deploy/.env", "/speedtest/"]

# Constant values
ENV TITLE="= AVG LibreSpeed ="
#ENV MODE=frontend
ENV TELEMETRY=true
#ENV ENABLE_ID_OBFUSCATION=true
#ENV REDACT_IP_ADDRESSES=false

EXPOSE 80

RUN /bin/bash /speedtest/entrypoint.sh
