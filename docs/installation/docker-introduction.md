# Introduction to ISLE 

## What is ISLE?

ISLE, short for ISLandora Enterprise, is a community initiative to ease the installation and maintenance of Islandora by using Docker. It was originally started by the Islandora Collaboration Group for Islandora 7.x.  When transitioning to Islandora 8, the project came under the purview of the Islandora Foundation.  All documentation on this site assumes you're trying to install Islandora 8. [See here](https://islandora-collaboration-group.github.io/ISLE/) if you are looking for ISLE for Islandora 7.

## Why use ISLE?

ISLE's architecture using [Docker](https://www.docker.com/) separates out the "state" of your site (i.e. all the content, files, and configurations that you've entered) from the underlying software that runs it (e.g. webserver, database, microservices, etc). This allows for easier upgrades, faster development, and more flexible deployment. It is hands down the easiest way to install, run, and maintain and Islandora instance.

## Where is ISLE?

ISLE is a suite of Docker containers that run the various components of Islandora: drupal, fedora, solr, alpaca, crayfish, matomo, etc. The individual containers are created (and automatically pushed to [Docker Hub](https://hub.docker.com/u/islandora)) by [ISLE BuildKit](https://github.com/Islandora-Devops/isle-buildkit).

In order to deploy the containers, however, you need to use a container orchestration tool.  The ISLE project provides tools for running and maintaining the containers using docker-compose with [ISLE Docker Compose](https://github.com/Islandora-Devops/isle-dc).
