# Installing a Production/Staging Server 

If you are deploying Islandora on a server that is publicly accessible, there's extra precautions you should take for
performance and security reasons. If you follow these steps, you'll see how we can use our `codebase` folder to build
a custom Drupal container, and bake code into the container instead of bind-mounting it in. We'll also cover how to
store passwords as secrets and set up TLS.
 
## Getting Started

If you haven't already [made a local environment](../docker-local), you'll want to do that first.  These instructions build off of having
a codebase folder.

## Using your Domain

At this point, we're assuming that you've purchased a domain to use for your repository.  By default, `islandora.traefik.me` is used, which
is fine for `make demo` and `make local`.  But for your production site, you'll need to set the domain you own in your .env file.

```
DOMAIN=example.org
```

## Secrets

Sensitive information, such as passwords, should never be built into a container.  It also shouldn't ever be bind-mounted in like we
do with our codebase folder.  If you use secrets, it's like bind-mounting in a file, except that file is provided from the host machine
to the container using an encrypted channel.

To use secrets, set the following in your .env file

```
USE_SECRETS=true
```

The secrets themselves are stored in the `secrets` folder of `isle-dc`.  If you navigate to that directory, you'll see several small
files, where each file represents a different password.  By default, they are all set to `password` and you can change them to set your
passwords for the system.

## TLS

All public facing sites need to use HTTPS, and it's definitely a stumbling block for the uninitiated.  Fortunately, `isle-dc` is
set up to  use HTTPS by default.  Even when running `make demo`, your site runs over HTTPS at `https://islandora.traefik.me`. The
default certificates are stored in the `certs` folder of `isle-dc`, and you can simply overwrite them with certificates from your
certificate authority.  As long as the certificates match the `DOMAIN` variable in your `.env` file, that is.

| File                 | Purpose                                                                                                                                                                                                                                                                     |
| :------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `privkey.pem`               | A PEM encoded private key used to sign your certificate |
| `cert.pem` | A PEM encoded certificate that also contains the issuer's certificate as well. Most certificate authorities offer "Full Chain" or "With Issuer" certificates that contain everything you need.  Occassionally, you may find yourself needing to manually concatenate your certificate with the issuer certificate by hand. In that case, the certificate for your site goes first, and the issuer's certificate is appended afterwards. |

### Using Let's Encrypt instead of Certificate Files

Full support for Let's Encrypt is not available yet with ISLE, but will be soon.  It can be done by hand though.  Just understand that it takes editing your `docker-compose.yml` file, and those changes will be destroyed if you regenerate your `docker-compose.yml` file for any reason.  Be sure to back up your `docker-compose.yml` file once you have things in place.

#### The acme.json file
Create an empty `acme` folder in `isle-dc` and bind mount it into Traefik.  When Traefik start up, it will write `acme.json` to this folder. Your `volumes` section for
`traefik` in your `docker-compose.yml` file should look like

```
    volumes:
    - ./certs:/etc/ssl/traefik:rw
    - ./tls.yml:/etc/traefik/tls.yml:rw
    - ./acme:/acme:rw
```

#### Creating the certificate resolver

Add the following to the `commands` section for `traefik` to tell it to use Let's Encrypt.

```
      --certificatesresolvers.myresolver.acme.httpchallenge=true
      --certificatesresolvers.myresolver.acme.httpchallenge.entrypoint=http
      --certificatesresolvers.myresolver.acme.email=your-mail@example.org
      --certificatesresolvers.myresolver.acme.storage=/acme/acme.json
      --certificatesResolvers.myresolver.acme.caServer=https://acme-v02.api.letsencrypt.org/directory
```

Be sure to replace `your-mail@example.org` with the email address you've associated with Let's Encrypt.

#### Adding the certificate resolver to routes

For the Drupal, Matomo, and Cantaloupe services, you'll need to add labels to instruct Traefik to use the `myresolver` certificate resolver you just created.

For example, for Drupal

```
traefik.http.routers.isle-dc-drupal_https.tls.certresolver: myresolver
```

#### Troubleshooting

If you are still getting security exceptions, check what certificate is being used through your browser.  Setting `--log.level=DEBUG` in the `commands` section
for `traefik` will help out greatly when debugging.  You can tail the logs with `docker-compose logs -tf traefik`

If you aren't careful, you can hit Let's Encrypt's rate limit, and you'll be locked out for up to a week!  If you want to use their staging server instead
while testing things out, use 

```
      --certificatesResolvers.myresolver.acme.caServer=https://acme-staging-v02.api.letsencrypt.org/directory
```

You'll still get security exceptions when it's working, but you should be able to check the certificate from the browser and confirm you are
getting it from the staging server.

## Building and Deploying Your Custom Container

First, set your `ENVIRONMENT` variable to `custom` in  your .env file in addition to the changes outlined above

```
ENVIRONMENT=custom
USE_SECREST=true
DOMAIN=your-domain.org
```

Then rebuild your dockerfile to have your changes take effect

```
make -B docker-compose.yml
```

After this, you can build your custom container with

```
make build
```

You then deploy the container with

```
docker-compose up -d
```
