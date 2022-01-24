FROM php:8.1.1-fpm-bullseye

# Arguments defined in docker-compose.yml
ARG UID

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends zip unzip git nano

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql opcache

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/

# Create system user to run Composer and Symfony Commands
RUN useradd -G www-data,root -u $UID -d /home/www www
RUN mkdir -p /home/www/.composer && \
    chown -R www:www /home/www

# Set working directory
WORKDIR /var/api

USER www
