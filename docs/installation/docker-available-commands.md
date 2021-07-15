# Available Commands

There's a lot of useful commands available to you from within the `isle-dc` folder.

## Rebuild docker-compose.yml

`make -B docker-compose.yml` will rebuild your `docker-compose.yml` file based on configuration in your `.env` file.  `make demo` and `make local` will automatically do this for you, but if you change configuration at a later point in time, you'll need to run this command to see your changes reflected.

## Config Export

`make config-export` will export your site's configuration to your site's config sync directory (usually `config/sync` inside your Drupal root folder).

## Config Import

`make config-import` will import site's configuration from your site's config sync directory (usually `config/sync` inside your Drupal root folder).

## Database Dump

`make drupal-database-dump DEST=/your/path/dump.sql` will dump your Drupal database and place the file at `DEST`.

## Database Import

`make drupal-database-import SRC=/your/path/dump.sql` will import your Drupal database from the file at `SRC`.

## Export Public Files

`make drupal-public-files-dump DEST=/your/path/public_files.tgz` will export your public filesystem and place it as a single zipped tarball at `DEST`. 

## Import Public Files

`make drupal-public-files-import SRC=/your/path/public_files.tgz` will import your public filesystem from a single zipped tarball at `SRC`. 

## Fcrepo Export

`make fcrepo-export DEST=/your/path/fcrepo-export.tgz` will export your Fedora repository and place it as a single zipped tarball at `DEST`

## Fcrepo Import

`make fcrepo-import SRC=/your/path/fcrepo-export.tgz` will import your Fedora repository from a single zipped tarball at `SRC`

## Reindex Fedora Metadata
  
`make reindex-fcrepo-metadata` will reindex RDF metadata from Drupal into Fedora.

## Reindex Solr
`make reindex-solr` will rebuild rebuild Solr search index for your repository. 

## Reindex the Triplestore

`make reindex-triplestore` will reindex RDF metadata from Drupal into Blazegraph. 

