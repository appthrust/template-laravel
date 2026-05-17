FROM composer:2 AS vendor
WORKDIR /app
COPY composer.json ./
RUN composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev
FROM php:8.4-cli-alpine
WORKDIR /app
RUN apk add --no-cache libpq-dev && docker-php-ext-install pdo_pgsql
COPY --from=vendor /app/vendor ./vendor
COPY . .
ENV APP_ENV=production APP_KEY=base64:AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA= SESSION_DRIVER=array
EXPOSE 8080
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
