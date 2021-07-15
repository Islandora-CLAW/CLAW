# Basic Usage

After you've finished installing Islandora using ISLE, here's some useful information to keep close at hand
about running your site.

## Important Files

The `make` commands that you used to install Islandora will leave you with two very important files.

| File                 | Purpose                                                                                                                                                                                                                                                                     |
| :------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `.env`               | A configuration file that is yours to customize. This file controls how the docker-compose.yml file gets generated to meet your use case.</br>It also allows you to set variables that make their way into the final `docker-compose.yml` file, such as your site's domain. |
| `docker-compose.yml` | A ready to run `docker-compose.yml` file based on your `.env` file.  This file is considered disposable. When you change your `.env` file, you will generate a new one.                                                                                                     |

## Available Services

Here's a list of all the available services.  Note that there are some services over `http` and not `https`.
Those aren't meant to be exposed to the public, but internally people from your organization will want to
access them.  In practice, you can restrict access to these services using firewall rules to just those who
you trust.

| Service     | Url                                                                                            |
| :---------- | :--------------------------------------------------------------------------------------------- |
| Drupal      | [https://islandora.traefik.me](https://islandora.traefik.me)                                   |
| Traefik     | [http://islandora.traefik.me:8080](https://islandora.traefik.me:8080)                          |
| Fedora      | [http://islandora.traefik.me:8081/fcrepo/rest](https://islandora.traefik.me:8081/fcrepo/rest)  |
| Blazegraph  | [http://islandora.traefik.me:8082/bigdata](https://islandora.traefik.me:8082/bigdata)          |
| Activemq    | [http://islandora.traefik.me:8161](https://islandora.traefik.me:8161)                          |
| Solr        | [http://islandora.traefik.me:8983](https://islandora.traefik.me:8983)                          |
| Cantaloupe  | [https://islandora.traefik.me/cantaloupe](https://islandora.traefik.me/cantaloupe)             |
| Matomo      | [https://islandora.traefik.me/matomo/](https://islandora.traefik.me/matomo/)                   |
| Code Server | [http://islandora.traefik.me:8443/](https://islandora.traefik.me:8443/)                        |

## Basic Commands

### Stopping Islandora

If you want to stop Islandora, you can bring down all the containers with

```
docker-compose down
``` 

### Restarting Islandora

If you want to start Islandora back up after stopping it, use

```
docker-compose up -d
```

### Deleting Islandora

If you want to stop Islandora and delete all of its content, use

```
docker-compose down -v
```

### Regenerating docker-compose.yml

If you make changes to configuration in the .env file, you may need to regnerate your `docker-compose.yml` file so that
those changes take effect.

```
make -B docker-compose.yml
```

Once you have a new `docker-compose.yml` file, you'll need to restart your containers that have had configuration change.
You can do this easily with

```
docker-compose up -d
```

Even if the site is up and running, that commnad will only retart the containers it needs to.

### Listing services

You can see a list of all the containers that you have running and their statuses by running

```
docker ps -a
```

### Tailing Logs

You can tail logs using

`docker-compose logs service_name`

For example, to tail nginx logs for Drupal, use `docker-compose logs drupal`.

If you don't know what you're looking for exactly, you can turn on the fire hose and look through all logs by dropping
the service name and simply using

`docker-compose logs`
