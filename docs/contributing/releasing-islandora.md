# Releasing Islandora

Follow these steps to release all of the Islandora ecosystem. Due to dependencies, this must be done in a particular order. While this may seem like a daunting task, remember that at any point in time you can delete/update/re-do a release in Github. If something gets botched simply

1. Delete the release in Github through their UI
2. Delete the tag in Git both locally and remotely: `git tag -d TAG_NAME; git push --delete origin TAG_NAME`
3. Try again.

The only exception is when publishing to Sonatype with Alpaca, but by the time you've gotten there, everything should be fine already.  And remember, you can always just bump the version number again and slice a second release if you have to.  No big deal!

We'll start with the Java stuff because it's the most complicated.

## Releasing Java Code

You need Java 8 on your system to release java code.  All the rest is handled by Gradle, which is included in the Git repos. If you cannot get Java 8, for whatever reason, you can still release Syn using Docker and the `openjdk:8-jdk` image.  For Alpaca, however, because we use keys and sign the code, etc... It really requires Java 8 to be on your system.

### Release Syn

To release Syn

1. Drop the `-SNAPSHOT` from `projectVersion` in `build.gradle`
2. Build Syn
    1. If you have Java 8, this can be done with `$ ./gradlew build shadowJar`
    2. If you don't have Java 8, you can do this with Docker `$ docker run --rm -v /path/to/Syn:/opt/Syn openjdk:8-jdk bash -lc 'cd /opt/Syn && ./gradlew build shadowJar'`
3. Push this to Github and slice a new version
    1. Note that this repository prepends a `v` to the release tag (i.e. use `vX.X.X` instead of just `X.X.X`)
5. Upload both artifacts to the release in Github.  These are located in `/path/to/Syn/build/libs`.  You want both `islandora-syn-X.X.X.jar` and `islandora-syn-X.X.X-all.jar`.
6. Bump the `projectVersion` in `build.gradle` and add `-SNAPSHOT` to the end again.
7. Push this to Github with a commit message of "Preparing for next development iteration"

### Release Alpaca

To make sure the release goes smoothly, you should ensure that:
  * You have an account with commit access for Alpaca on GitHub. As a committer, you should already have this level of access.
  * You have an oss.sonatype.org account and have requested to be given permission to publish to the ca.islandora groupId by adding a comment to the [Islandora Sonatype Hosting Ticket](https://issues.sonatype.org/browse/OSSRH-18137)
  * Ensure you have a trusted code signing key; [create](https://wiki.duraspace.org/display/FCREPO/Creating+a+Code+Signing+Key) if you haven't before and add it to the [contributor keys](https://github.com/Islandora-CLAW/Alpaca/wiki/Alpaca-Release-Process#contributor-keys) list below
  * Your gradle settings file (`~/.gradle/gradle.properties`) exists and includes the following:
```properties
ossrhUsername = jiraname
ossrhPassword = jirapass
signing.keyId = pubkeyid
signing.password = keypassphrase
signing.secretKeyRingFile = /your/home/.gnupg/secring.gpg 
```
  * Your `git` is configured (locally or globally) to [cache github credentials for https](https://help.github.com/articles/caching-your-github-password-in-git/) or [use ssh](https://help.github.com/articles/generating-an-ssh-key/)

**Note**: As of GPG 2.1 `secring.gpg` [has been removed](https://www.gnupg.org/faq/whats-new-in-2.1.html#nosecring) so you need to export secret keys to create the secret key ring.
```
gpg --export-secret-keys -o secring.gpg
```

#### Steps:
The following assumes you are using ssh (e.g. git@github.com for authentication).

It will also work for https if you properly cache your github credentials. The credentials must be cached and valid because Gradle will not prompt you for them!

##### Release artifacts to Sonatype and Github

You need to merge the latest code into the master branch and use Gradle to release. You can do this by running

* `git clone git@github.com:Islandora-CLAW/Alpaca.git`
* `cd Alpaca`
* `git checkout master`
* `git pull origin dev`
* `./gradlew release`

The script will start but then will ask you to confirm the version to release as.
```
??> This release version: [0.3.1]  (WAITING FOR INPUT BELOW)
<-------------> 0% EXECUTING [13s]
> :release
> :alpaca-release:confirmReleaseVersion
```
You then type in the version (ie. `0.4.0`) or nothing to use the suggested version (`0.3.1` in this example) and hit `ENTER`.

The gradle release task will take care of dropping -SNAPSHOT from the version, uploading artifacts to Maven central for staging, tagging and pushing a release to github, and bumping `master` of the Alpaca repository up by a point release for the next development iteration.

##### Documentation.
The release process will also generate documentation at `./docs/<new-version>`. This will need to be added to the git repository and pushed to the master branch:

* `git add docs/<new-version>`
* `git commit -m "Add documentation for <new-version>"`
* `git push origin`

##### Release from Sonatype

###### Point of no return
***

⚠️  The following steps, once completed are final.  They cannot be undone, revoked or altered.  Only proceed if you've 
completed all the above steps and are absolutely certain the release is ready for publication.

***

* Login to https://oss.sonatype.org
* Click on **Staging Repositories** on the left hand side under **Build Promotion**
* On the far left hand side search box enter 'islandora'
* Locate the artifacts you want to release and click on them
* Click Close, then Refresh, then Release

##### Contributor Keys

| Name         | Organization           | Address               | Code Signing Key Fingerprint | Key Id |
|--------------|------------------------|-----------------------|---|:-:|
| Danny Lamb   | Islandora Foundation   | dlamb at islandora.ca | 2D609DB0380A7637A6B72B328D7E7725D47A05FA | D47A05FA |
| Jared Whiklo | University of Manitoba | jwhiklo at gmail.com  | 9F45FC2BE09F4D70DA0C7A5CA51C36E8D4F78790 | D4F78790 |
| Nick Ruest   | York University        | ruestn at yorku.ca    | 159493E15691C84D615B7D1B417FAF1A0E1080CD | 0E1080CD |
| Seth Shaw   | University of Nevada, Las Vegas        | seth.shaw at unlv.edu    | 2FF65B22AFA7B2A57F054F89D160AA658DAE385F | D160AA658DAE385F |

## Releasing PHP Code

This is much easier/straightforward compared to the Java code.  You will need `composer` 2 on your system, but most of it is done through Github. The only thing to be mindful of is how the modules depend on each other. But if you follow these steps, everything will get updated in the correct order.

### JSONLD

Release the `jsonld` module by creating a new release for it in Github.

### Release Openseadragon

Release the `openseadragon` module by creating a new release for it in Github.

### Release Carapace

Release the `carapace` theme by creating a new release for it in Github.

### Release migrate_islandora_csv

Release the `migrate_islandora_csv` module by creating a new release for it in Github.

### Release Chullo

Release chullo by creating a new release for it in Github.

### Release Crayfish-Commons

Crayfish commons depends on the `chullo` library, and must have its dependencies updated before release.

1. Bump the dependency on `islandora/chullo` from `dev-dev` to the release you just made in the previous step.
2. `composer update -W`
3. Commit and push the `composer.json` and `composer.lock` files to Github.
4. Release `crayfish-commons` by creating a new release in Github
5. Put the dependency on `islandora/chullo` back to `dev-dev`
6. `composer update -W` again
7. Commit and push the `composer.json` and `composer.lock` files to Github with a commit message of "Preparing for next development iteration".

### Release Crayfish

Crayfish depends on the `crayfish-commons` library, and must have its dependencies updated before release.

1. Bump the dependency on `islandora/crayfish-commons` in each `composer.json` for each microservice **except for Houdini**. Houdini needs the `dev-symfony-flex` branch of Crayfish Commons, so just leave that dependency alone for now.
2. Run `composer update -W` on each microservice. I did this with a little bash-fu: `for D in */; do (cd $D; composer update -W) done`
4. Commit and push the `composer.json` and `composer.lock` files to Github.
5. Release the microservices by creating a new release for them in Github.
6. Put the dependencies on `islandora/crayfish-commons` back to `dev-dev` **except for Houdini**.
7. Run `composer update -W` on each microservice again. `for D in */; do (cd $D; composer update -W) done` makes this easy.
8. Commit and push the `composer.json` and `composer.lock` files to Github with a commit message of "Preparing for next development iteration".


