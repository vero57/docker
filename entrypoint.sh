#!/bin/sh

# Ubah kepemilikan file agar sesuai dengan user www-data
# Ini penting karena file dari host (Windows/macOS) mungkin memiliki owner yang berbeda
chown -R www-data:www-data /var/www/html/storage
chown -R www-data:www-data /var/www/html/bootstrap/cache

# Jalankan composer install
# --no-interaction: jangan menanyakan apapun
# --optimize-autoloader: buat performa biar lebih baik
composer install --no-interaction --optimize-autoloader

# Generate kunci aplikasi jika belum ada
# Ini akan memeriksa file .env dan menambahkan APP_KEY jika kosong
php artisan key:generate

# biar ngebuat storage
php artisan storage:link


# Perintah ini adalah bagian paling penting.
# "exec "$@"" akan menjalankan perintah default dari Dockerfile (yaitu php-fpm).
# Tanpa ini, skrip akan selesai dan kontainer akan berhenti.
exec "$@"
