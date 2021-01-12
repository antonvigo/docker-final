#!/bin/bash

set -e
set -x

# Set environment variables
export $(grep -v '^#' /speedtest/.env | xargs)

# Cleanup
rm -rf /var/www/html/*

# Copy frontend files
cp /speedtest/*.js /var/www/html/

# Copy favicon
cp /speedtest/favicon.ico /var/www/html/

# Set up backend side for standlone modes
if [ "$MODE" == "standalone" ]; then
  cp -r /speedtest/backend/ /var/www/html/backend
  if [ ! -z "$IPINFO_APIKEY" ]; then
    sed -i s/\$IPINFO_APIKEY=\"\"/\$IPINFO_APIKEY=\"$IPINFO_APIKEY\"/g /var/www/html/backend/getIP_ipInfo_apikey.php
  fi
fi

if [ "$MODE" == "backend" ]; then
  cp -r /speedtest/backend/* /var/www/html
  if [ ! -z "$IPINFO_APIKEY" ]; then
    sed -i s/\$IPINFO_APIKEY=\"\"/\$IPINFO_APIKEY=\"$IPINFO_APIKEY\"/g /var/www/html/getIP_ipInfo_apikey.php
  fi
fi

# Set up index.php for frontend-only or standalone modes
if [ "$MODE" == "frontend" ]; then
  cp /speedtest/frontend.php /var/www/html/index.php
elif [ "$MODE" == "standalone" ]; then
  cp /speedtest/standalone.php /var/www/html/index.php
fi

# Apply Telemetry settings when running in standalone or frontend mode and telemetry is enabled
if [[ "$TELEMETRY" == "true" && ( "$MODE" == "frontend" || "$MODE" == "standalone" ) ]]; then
  cp -r /speedtest/results /var/www/html/results

  sed -i s/\$stats_password=\".*\"/\$stats_password=\"$STATS_PASSWORD\"/g /var/www/html/results/telemetry_settings.php
  sed -i s/\$MySql_username=\".*\"/\$MySql_username=\"$MYSQL_USER\"/g /var/www/html/results/telemetry_settings.php
  sed -i s/\$MySql_password=\".*\"/\$MySql_password=\"$MYSQL_PASSWORD\"/g /var/www/html/results/telemetry_settings.php
  sed -i s/\$MySql_hostname=\".*\"/\$MySql_hostname=\"$MYSQL_HOSTNAME\"/g /var/www/html/results/telemetry_settings.php
  sed -i s/\$MySql_databasename=\".*\"/\$MySql_databasename=\"$MYSQL_DATABASE\"/g /var/www/html/results/telemetry_settings.php

  if [ "$ENABLE_ID_OBFUSCATION" == "true" ]; then
    sed -i s/\$enable_id_obfuscation=.*\;/\$enable_id_obfuscation=true\;/g /var/www/html/results/telemetry_settings.php
  fi

  if [ "$REDACT_IP_ADDRESSES" == "true" ]; then
    sed -i s/\$redact_ip_addresses=.*\;/\$redact_ip_addresses=true\;/g /var/www/html/results/telemetry_settings.php
  fi

fi

chown -R www-data /var/www/html/*
