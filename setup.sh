#!/bin/bash
set -e

echo "## Setting up docker .env ..."
cp -v -n .env.sample .env
cp -v -n .env.sample api/.env

echo "## Setting up database ..."
cp -v -n api/config/database.sample.yml api/config/database.yml
