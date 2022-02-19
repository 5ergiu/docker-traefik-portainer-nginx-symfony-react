#!/bin/bash

toast() {
  BLUE='\033[1;36m';
  NC='\033[0m'; # No Color
  echo -e "${BLUE}\r\n>>> $1 ${NC}";
}

error() {
  RED='\033[0;31m';
  NC='\033[0m'; # No Color
  echo -e "${RED}\r\n>>> $1 ${NC}";
  exit 1;
}

configurations() {
  if [[ ! -f .env ]]; then
    toast ".env file wasn't found, copying .env.default";
    cp .env.default .env;
  fi

  toast "Installing project for '$1'";
  toast "Setting APP_ENV to '$1'";
  sed -i "s/APP_ENV=.*$/APP_ENV=$1/" .env;

  toast 'Generating new APP_SECRET';
  sed -i "s/^APP_SECRET=.*$/APP_SECRET=$(openssl rand -hex 16)/" .env;
  toast 'Successfully generated new APP_SECRET'; echo '';

  read -p 'Enter the name for the app (ex: my-site): ' APP_NAME && sed -i "s/APP_NAME=.*$/APP_NAME=$APP_NAME/" .env;
  read -p 'Enter the domain for the app (ex: my-site.local): ' DOMAIN && sed -i "s/DOMAIN=.*$/DOMAIN=$DOMAIN/" .env;

  read -p "Do you wish to setup a database connection? (Y/N): " CONFIRM;
  if [[ $CONFIRM == [yY] || $CONFIRM == [yY][eE][sS] ]]; then
    read -p 'Enter DB user: ' DB_USER && sed -i "s/DB_USER=.*$/DB_USER=$DB_USER/" .env;
    read -p 'Enter DB pass: ' DB_PASS && sed -i "s/DB_PASS=.*$/DB_PASS=$DB_PASS/" .env;
    read -p 'Enter DB name: ' DB_NAME && sed -i "s/DB_NAME=.*$/DB_NAME=$DB_NAME/" .env;
  else
    toast 'Skipping database connection, default values are applied';
  fi
}

clear;

toast "Let's setup the project!";

OPTIONS=('dev(development use)' 'prod(production ready)');
PS3='Pick an environment first: ';
select opt in "${OPTIONS[@]}" 'Quit'; do
  case "$REPLY" in
  1)
    configurations dev;

    {
      docker-compose -f docker-compose.dev.yml up -d && \
      toast "$APP_NAME can be accessed on http://$DOMAIN" && \
      toast "Traefik can be accessed on http://traefik.$DOMAIN" && \
      toast "Portainer can be accessed on http://portainer.$DOMAIN" && \
      toast "API available on http://api.$DOMAIN" && \
      toast 'Installation completed successfully!';
    } || {
      error 'Installation failed!';
    }

    break;
    ;;

  2)
    configurations prod;

    toast "!!! Traefik basic auth is already setup with user 'admin' and pass 'admin', update if necessary !!!";
    toast 'The project also has default configurations for Digital Ocean DNS Challenge';
    toast '!!! Update the configurations and this file should you need a different provider or TLS Challenge !!!'; echo '';

    read -p "Configure Digital Ocean DNS Challenge now? (Y/N): " CONFIRM;
    if [[ $CONFIRM == [yY] || $CONFIRM == [yY][eE][sS] ]]; then
      if [[ ! -f .docker/acme.json ]]; then
        toast "acme.json file wasn't found. Creating it at /.docker/acme.json"; echo '';
        touch .docker/acme.json && chmod 600 .docker/acme.json;
      fi
      read -p "DO_AUTH_EMAIL: " DO_AUTH_TOKEN && sed -i "s/DO_AUTH_EMAIL=.*$/DO_AUTH_EMAIL=$DO_AUTH_EMAIL/" .env;
      read -p "DO_AUTH_TOKEN: " DO_AUTH_TOKEN && sed -i "s/DO_AUTH_TOKEN=.*$/DO_AUTH_TOKEN=$DO_AUTH_TOKEN/" .env;
      toast 'Successfully added DO_AUTH_TOKEN'; echo '';
    else
      error 'Installation failed! Check DNS Challenge configurations';
    fi

    {
      docker-compose up -d  && \
      toast "$APP_NAME can be accessed on https://$DOMAIN" && \
      toast "Traefik can be accessed on https://traefik.$DOMAIN" && \
      toast "Portainer can be accessed on https://portainer.$DOMAIN" && \
      toast "API available on https://api.$DOMAIN" && \
      toast 'Installation completed successfully!';
    } || {
      error 'Installation failed!';
    }

    break;
    ;;
  $((${#OPTIONS[@]}+1)))
    toast 'Goodbye!';
    break;
    ;;
  *)
    toast "$REPLY is an invalid option. Choose 1 (for development), 2 (for production)";
    continue;
    ;;
  esac
done
