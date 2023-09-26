#!/bin/bash

set -e -o pipefail

# jdk-17

docker build --pull -t maven-allure-chrome-stable:jdk-17 jdk-17
TAG=jdk-17 bats test
