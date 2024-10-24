#!/bin/bash

set -e -o pipefail

# jdk-17

docker build --pull -t maven-allure-chrome-stable:jdk-17 jdk-17
TAG=jdk-17 bats test


# jdk-21

docker build --pull -t maven-allure-chrome-stable:jdk-21 jdk-21
TAG=jdk-21 bats test
