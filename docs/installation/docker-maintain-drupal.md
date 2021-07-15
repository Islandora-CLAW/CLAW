# Maintaining Your Drupal Site

Drupal has a dedicated security team, and regularly produces updates to address security issues
that are discovered.  You should always keep your Drupal site up to date so that you are
protected against known vulnerabilities. Updating Drupal can be intimidating, but we have
step-by-step instructions to help you do it safely.

## Running commands

Once you have a `codebase` folder, how do you maintain it and keep it up to date?  The quick answer is
"the same way you maintain any Drupal site with Composer and Drush"... with one small caveat. You most
likely do not have PHP or Composer on your machine, and even if you do, you want to make sure you're
using the exact same version that Islandora is using.  So to ensure all the versions of things line
up, we use Docker to execute Drush and Composer from the Drupal container.  The general template for
running a command looks like this:

```
docker-compose exec -T drupal with-contenv bash -lc 'YOUR COMMAND'
```

You can also just shell into the drupal container and run commands as well,
just be aware that if you cycle your container for any reason, you'll lose your
bash history.  If you want to shell in to run commands, drop the `-lc 'YOUR COMMAND'`
bit.

```
docker-compose exec -T drupal with-contenv bash
``` 

## Updating your Drupal Site

Use composer to update your site's modules and their dependencies. The working directory
of the drupal container is the Drupal root (a.k.a. `codebase`), so you don't need to `cd`
into any other directory before running the command.  The following command will update
all modules and their dependencies that are not pinned to specific versions.

```
docker-compose exec -T drupal with-contenv bash -lc 'composer update -W'
```

After getting the newest code, you'll want to use Drush to update the Drupal database
and run any other update hooks that have been introduced.  However, _YOU SHOULD BACK UP
YOUR DATABASE BEFORE GOING ANY FURTHER_. You never know when something will go wrong and
you don't want to be stuck with an unusable database and no plan B.

```
make drupal-database-dump DEST=/path/to/dump.sql
```

Now you can safely update the Drupal database with Drush via

```
docker-compose exec -T drupal with-contenv bash -lc 'drush updb'
```

If for any reason, something goes wrong, you can Restore the Drupal database at any time by running

```
make drupal-database-import SRC=/path/to/dump.sql
```

