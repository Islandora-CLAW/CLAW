# Prerequisites

## Requirements for using ISLE with Docker Compose

- Docker 19.x+
- Docker Compose version 1.25.x+
- GNU Make 4.0+
- Git 2.0+
- [ISLE Docker Compose](https://github.com/islandora-devops/isle-dc)
- At least 8GB of RAM (ideally 16GB)
- An administrator account your machine (a.k.a. the host machine)
- (Mac OS) Apple Developer Tools
- (Windows) The following setup has been tested:
    - Windows 10
    - [Windows Subsystem for Linux v. 2 (WSL 2)](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
    - Ubuntu 20.04 running on WSL 2
    - GNU make, run `sudo apt update` and `sudo apt install make` to install
    - Docker Desktop for Windows, using the WSL 2 based engine (Settings > General) and with the WSL integration active for Ubuntu (Settings > Resources > WSL integration) 

!!! Note "What are we missing?"
    Are you, or your computer, new to spinning up development sandboxes? Do you have wisdom about installing make on Windows? We suspect these requirements may be incomplete and your experience would be appreciated at [Issue #1640](https://github.com/Islandora/documentation/issues/1640).

## Installing Docker

To see if you have Docker installed, type `docker --version` in a terminal.

If you need to install Docker, we recommend using the application [Docker Desktop](https://www.docker.com/products/docker-desktop). It provides a GUI for managing Docker container in Windows and MacOS, along with the Docker engine and suite of command-line tools. Linux users don't get a desktop client, but can install the Engine and command-line tools the instructions [here](https://docs.docker.com/engine/install/).

!!! Warning "Memory, Processors, and Swap Requirements"
    To run ISLE on Docker Desktop, you must increase the resources allocated to the software. See Docker docs on [setting resources on Windows](https://docs.docker.com/docker-for-windows/#resources) (see note on how to allocate/restrict memory when using WSL 2) or [setting resources on Mac](https://docs.docker.com/docker-for-mac/#resources).

    **CPUs (processors)**: The CPUs allowed to Docker Desktop are still shared with the host machine, so increasing this to the maximum value should allow both the Docker containers and your host machine to run simultaneously.

    **Memory (RAM)**: This memory is completely dedicated to Docker while Docker Desktop is running, so do not allocate more than you can spare and still run your host machine. Windows users may not require as much memory for Docker as Mac users. Current suggestions for memory allocated to Docker Desktop are below, but please edit this document if you have new information.

    - Sandbox or development environment: 8GB
    - Production or production-like development: 16GB

    **Swap**: Swap space is space borrowed from your hard disk drive to serve as makeshift RAM as needed. If you cannot provide as much RAM as you would like, increase this as is reasonable given your free disk space.

## Installing ISLE Docker Compose

Use Git to install the ISLE Docker Compose tool:

`git clone https://github.com/islandora-devops/isle-dc` 

Tagged versions are available [here](https://github.com/Islandora-Devops/isle-dc/tags).
