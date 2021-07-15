# Installing a Demo Server

Using ISLE, you can spin up a repository that is exactly like future.islandora.ca, including the sample content. If you want to kick the tires and see what Islandora can do with the minimal amount of setup, this is for you.

!!! Warning "Demonstration Purposes Only!"
    Please be advised, the environment you are about to create is meant to be temporary. The drupal codebase is baked into a container and is ephemeral.  If you [install new modules](../docker-maintain-drupal/), they will be gone if your drupal container goes down for any reason.

## Getting Started

To get started with a **demo** environment, run the following command from your `isle-dc` directory:

```bash
make demo
```

## Kicking the Tires

Your new Islandora instance will be available at [https://islandora.traefik.me](https://islandora.traefik.me). Don't let the
funny url fool you, it's a dummy domain that resolves to `127.0.0.1`.

You can log into Drupal as `admin` using the default password, `password`. 

Enjoy your Islandora instance!  Check out the [basic usage documentation](../docker-basic-usage) to see
all the endpoints that are available and how to do things like start and stop Islandora. 
