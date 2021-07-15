# Available Configuration

ISLE Docker Compose has a single configuration file, `.env`. Within it, here
is all the values you can set and their effects. This list is subjectively sorted
in order of importance and usefulness.

### ENVIRONMENT

Setting the `ENVIRONMENT` changes how your `docker-compose.yml` file gets constructed. When you
switch from a demo to development to production environment, this is the variable to change.

Available values for this setting are

- `demo` - For demo environments where you do not need access to the codebase
- `local` - For development environments where you need edit the codebase
- `custom` - For production environments where your codebase gets baked into a custom container

By default, this is set to `demo`.

If you change this setting, you need to `make -B docker-compose.yml` to generate a new `docker-compose.yml`
file that contains the changes you've made.

### DOMAIN

What domain your Islandora site will be available at. If you are deploying anywhere other than 
your personal machine, you'll probably want to change this.

By default, this is set to `islandora.traefik.me`. 

If you change this setting, you need to `make -B docker-compose.yml` to generate a new `docker-compose.yml`
file that contains the changes you've made.

!!! Warning "Changing this after installation has consequences"
    If you are indexing RDF metadata in Fedora and/or a triplestore, please be aware of the implications of changing this once you have installed.  By changing your domain, all of the subjects of your triples will be incorrect and you will have to reindex.  There are `make` commands to streamline this proccess, but if you have lots of data it can potentially be costly in terms of time and effort.

### REPOSITORY

Repository to use for pulling isle-buildkit images.

By default, this is set to `islandora`.  Change to `local` to use images you have built locally with isle-buildkit,
or use your custom docker registry if you have set up one.

If you change this setting, you need to `make -B docker-compose.yml` to generate a new `docker-compose.yml`
file that contains the changes you've made.

### TAG

The version of the `isle-buildkit` images to use. Non `isle-buildkit` images have their versions specified explicitly
in their respective docker-compose files.

By default, this is set to the latest stable release of `isle-buildkit`.

If you change this setting, you need to `make -B docker-compose.yml` to generate a new `docker-compose.yml`
file that contains the changes you've made.

### USE_SECRETS

Whether or not you want to use secrets.  For demo and development environments, secrets are
not required.  They are essential if you are running a production environment, though.

Secrets are contained in the `secrets` folder withiin your `isle-dc` installation.  Each file represents
an individual secret, and its contents are the value you're trying to protect.

Available values for this setting are
- `true`
- `false`

If you change this setting, you need to `make -B docker-compose.yml` to generate a new `docker-compose.yml`
file that contains the changes you've made.

### DRUPAL_INSTALL_PROFILE

Which install profile to use when making an initial installation.  Valid values for this setting are the machine
names of any Drupal profile.

By default, this is set to `standard`.

### INSTALL_EXISTING_CONFIG

Set this to `true` if you want to install an existing Drupal site whose configuration was exported with 
`drush config:export` 

Available values for this setting are
- `true`
- `false`

By default, this is set to `false`.

If you set this to `true`, be sure to set `DRUPAL_INSTALL_PROFILE` to `minimal`.

### INCLUDE_WATCHTOWER_SERVICE

Whether or not to include Watchtower as a service.  When developing `isle-buildkit`, this is extremely useful and
will auto-deploy new containers as you make changes.  You should _not_ use watchtower on prodution environments, though.

Available values for this setting are
- `true`
- `false`

By default, this is set to `true`.

If you change this setting, you need to `make -B docker-compose.yml` to generate a new `docker-compose.yml`
file that contains the changes you've made.

### INCLUDE_ETCD_SERVICE

Whether or not to include `etcd` as a service.

Available values for this setting are
- `true`
- `false`

By default, this is set to `false`. If you don't know what `etcd` is, then leave this be.

If you change this setting, you need to `make -B docker-compose.yml` to generate a new `docker-compose.yml`
file that contains the changes you've made.

### INCLUDE_CODE_SERVER_SERVICE

Whether or not to include the `coder` IDE as a service. If you're developing on Islandora, this can
be pretty useful when developing. You should _not_ deploy this service on production environments. 

Available values for this setting are
- `true`
- `false`

By default, this is set to `false`.

If you change this setting, you need to `make -B docker-compose.yml` to generate a new `docker-compose.yml`
file that contains the changes you've made.

### DRUPAL_DATABASE_SERVICE

Which database engine to use for Drupal.

Available values are
- mariadb
- postgres

By default, this value is set to `mariadb`.

If you change this setting, you need to `make -B docker-compose.yml` to generate a new `docker-compose.yml`
file that contains the changes you've made.

!!! Warning "Changing this after installation has consequences"
    If you are changing from mariadb to potsrgres or vice versa, you _MUST_ migrate your data yourself.  ISLE will not convert your database from one to the other, and it's generally not advised to change this once you've installed.

### FCREPO_DATABASE_SERVICE

Which database engine to use for Fedora.

Available values are
- mariadb
- postgres

By default, this value is set to `mariadb`.

If you change this setting, you need to `make -B docker-compose.yml` to generate a new `docker-compose.yml`
file that contains the changes you've made.

!!! Warning "Changing this after installation has consequences"
    If you are changing from mariadb to potsrgres or vice versa, you _MUST_ migrate your data yourself.  ISLE will not convert your database from one to the other, and it's generally not advised to change this once you've installed.

### COMPOSE_HTTP_TIMEOUT

Sometimes when bringing up containers, you can encounter timeouts with an error like this:

```
ERROR: An HTTP request took too long to complete. Retry with --verbose to obtain debug information.
If you encounter this issue regularly because of slow network conditions, consider setting COMPOSE_HTTP_TIMEOUT to a higher value (current value: XXX).
```

By default, this value is set to 480, but if you have slow network conditions and encounter this error, consider bumping it higher.

### COMPOSE_PROJECT_NAME

Used for naming services in traefik as well as defining network alias and urls. For example the `drupal` service will be found at
`${COMPOSE_PROJECT_NAME}_drupal_1`. This is useful to change if you are running mulitple ISLE instances on one machine.

By default, this value is set to `isle-dc`.

If you change this setting, you need to `make -B docker-compose.yml` to generate a new `docker-compose.yml`
file that contains the changes you've made.

### COMPOSE_DOCKER_CLI_BUILD

Allows building your custom image when setting `ENVIRONMENT=custom`

By default, this is set to 1.

You most likely will never have a need to change this.

### DOCKER_BUILDKIT

Instructs Docker to use buildkit when building your custom image.

By default, this is set to 1.

You most likely will never have a need to change this. Trust us, you want buildkit.

### PROJECT_DRUPAL_DOCKERFILE

The name of the Dockerfile to use after setting `ENVIRONMENT=custom`.

By default, this is set to `Dockerfile`.

You most likely will never have a need to change this.

If you change this setting, you need to `make -B docker-compose.yml` to generate a new `docker-compose.yml`
file that contains the changes you've made.

### DISABLE_SYN

Set this to `true` to disable JWT authentication for Fedora.  This is neccessary
when performing a Fedora import using their import/export tools.

By default, this is set to `false`.

### FEDORA_6

Whether or not to use Fedora 6.  If you set this to `false`, you will be given Fedora 5.
In general, unless you already have an existing site on Fedora 5, you'll want Fedora 6.

By default, this is set to `true`.

If you change this setting, you need to `make -B docker-compose.yml` to generate a new `docker-compose.yml`
file that contains the changes you've made.

