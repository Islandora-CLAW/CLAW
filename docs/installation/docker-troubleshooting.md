# Troubleshooting

### Docker Versions

If you get an error such as: `ERROR: Version in "./docker-compose.activemq.yml" is unsupported.`, then you need to upgrade Docker. Enter the command `make clean` before re-attempting to `make demo`.

### Re-attempting `make demo`

If `make` fails for any reason, enter `make clean` before attempting to `make` again. If not, you may see an error such as: `ERROR: Top level object in './docker-compose.yml' needs to be an object not '<class 'NoneType'>'.`

### Docker containers exit without warning

If you notice some Docker containers drop (exited(0)), and (in Docker Desktop) the isle-dc app icon is yellow instead of green, try increasing the resources allocated to Docker (see note above).

### Connection timed out (Mac).

If you are using Docker Desktop for Mac, and get timeout errors when spinning up the containers (during `docker-compose up -d` or during `make local`) such as this:

```
ERROR: for isle-dc_mariadb_1  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=480)
```

you can try quitting Docker completely (make sure there is no whale icon in your top toolbar - may need to select "Quit" from the whale icon itself) and then restart Docker. 
### 504 Bad Gateway
If you get a white screen with a 504 Bad Gateway error, this means your containers haven't finished initializing themselves yet.  If you've waiting an appropriate amount of time (2-5 minutes), then there is most likely an error in a container's startup script.  Use `docker ps -a` to see which services have `Exited` status, and then tail their logs with `docker-compose logs service_name`.
