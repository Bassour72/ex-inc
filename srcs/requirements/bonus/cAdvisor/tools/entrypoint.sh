#!/bin/sh


set -e

echo "Starting cAdvisor..."

exec /usr/bin/cadvisor --logtostderr --docker_only=true 
