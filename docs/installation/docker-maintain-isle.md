# Maintaining Your ISLE Infrastructure 

You will regularly be updating your Drupal site as security patches and module updates are released.
Less often, you will also need to update the rest of your Islandora installation.  ISLE makes this easy.
In fact, it was specifically designed to streamline this process.

Since Islandora is not a single piece of software, but instead many pieces of software working together
in concert, maintaining all of it is a daunting task.  There's nginx, tomcat, karaf, etc... Then there's
everything needed for the authentication layer and JWT keys.  Plus there's all the microservices.  You can
see that all this adds up to a significant maintenance burden.

Now imagine if all that time and effort spent on security updates and getting the newest versions could
be boiled down to a handful of simple commands.  That's exactly what ISLE does!

## Updating ISLE

Updating ISLE is easy.  When a new release is made available, you update the `TAG` variable in your
`.env` file to the latest version. Suppose you are on ISLE 1.0.0, and ISLE 1.1.0 has been released.
Then we would set

```
TAG=1.1.0
```

We'll then generate a new `docker-compose.yml` file that includes the new tag with

```
make -B docker-compose.yml
```

After that, we pull the new containers with

```
make pull
```

And finally we deploy the updated containers by running

```
docker-compose up -d
```

You can check that everything is running at the version you've specified with 

```
docker ps -a
```

The version that's running can be confirmed by looking at the `IMAGE` column in the output. 
