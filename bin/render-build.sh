#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Verifica se o banco de dados está pronto
echo "Waiting for PostgreSQL to be ready..."
while ! pg_isready -h $POSTGRES_HOST -p 5432 -q -U $POSTGRES_USER; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

# Prepara o banco de dados
echo "Setting up database..."
bundle exec rails db:migrate
