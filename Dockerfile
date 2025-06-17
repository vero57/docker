# pake php 8.2
FROM php:8.2-fpm

# Set working directory di dalam container
WORKDIR /var/www/html

# Instalasi dependensi yang dibutuhin
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libzip-dev \
    libpq-dev \
    libonig-dev \
    libxml2-dev

# Bersihkan cache apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instal ekstensi PHP yang dibutuhin sama Laravel
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Instal Composer (dependency manager untuk PHP)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy file aplikasi yang sudah ada dari host ke working directory di container
COPY . .

# Salin script entrypoint ke dalam image
COPY docker/app/entrypoint.sh /usr/local/bin/entrypoint.sh

# Jadikan entrypoint sebagai skrip yang akan dijalankan
ENTRYPOINT ["entrypoint.sh"] 
# ini penting ya jangan lupa

# Expose port 9000 untuk komunikasi dengan Nginx melalui PHP-FPM
EXPOSE 9000

# Perintah default untuk dijalankan oleh entrypoint
CMD ["php-fpm"]
