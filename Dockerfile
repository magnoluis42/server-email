# Imagem base com PHP 8.2 FPM
FROM php:8.2-fpm

# Define o diretório de trabalho
WORKDIR /var/www

# Instala dependências do sistema
# (git, zip, libs para extensões de imagem, etc.)
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype-dev \
    libonig-dev \
    libxml2-dev \
    default-mysql-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala extensões PHP comuns do Laravel
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

# Instala Redis (via PECL)
# RUN pecl install redis && docker-php-ext-enable redis

# Instala o Composer (globalmente)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Instala Node.js e NPM (usando o setup oficial do NodeSource)
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
# RUN apt-get install -y nodejs

# Limpa o cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Expõe a porta 9000 para o PHP-FPM
EXPOSE 9000

# Comando padrão para iniciar o PHP-FPM
CMD ["php-fpm"]