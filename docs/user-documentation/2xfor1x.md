#What's Different between Islandora 1.x and 2.x

In the most basic terms, Islandora 7.x-2.x is the version of Islandora that works with [Fedora 4](https://wiki.duraspace.org/display/FEDORA4x/Fedora+4.x+Documentation). Because Fedora 4 is a vastly different platform than Fedora 3, so too is Islandora 7.x-2.x a major departure from what came before. Switching to 7.x-2.x represents not just a typical upgrade with improvements, features, and bug fixes, but rather a major shift in how objects are stored and managed. 

Moving from Islandora 7.x-1.x to 7.x-2.x requires a migration of objects, which you can learn about [here](migration/migration.md). It also requires some adjustments in how you think about your objects and their relationships, and how to manage them in Islandora, which we will cover below.

##Fedora 

###Repository Structure

Fedora 3 stored all objects at the top level of the repository, although presentation of the objects could mimic a directory structure by having objects 'in' collections and collections 'in' other collections. This image is a helpful oversimplification:

![image](https://cloud.githubusercontent.com/assets/2371345/10912108/525c2a0e-821e-11e5-9c5b-d853b62f1e5a.png)

Fedora 4 differs considerably in that there is an innate tree hierarchy to the repository rather than a flat structure. Put less simply, "a Fedora 4 repository consists of a directed acyclic graph of resources where edges represent a parent-child relation" ([Fedora 4](https://wiki.duraspace.org/display/FEDORA4x/The+Fedora+4+object+model)).

###Object Structure
A Fedora 3 digital object had three elements:

* Digital Object Identifier: A unique, persistent identifier for the digital object.
* System Properties: A set of system-defined descriptive properties that is necessary to manage and track the object in the repository.
* Datastream(s): The element in a Fedora digital object that represents a content item.


##Islandora

###Ingest

In Fedora 3:
* Go to a collection
* Click *Manage*
* Add an object
* Fill out a metadata form
* Upload object/Ingest

In Fedora 3:
* Click *Add Content* (like any Drupal node)
* Select content type 
* Fill out a metadata form
    * Add thumbnail, select parent collection, upload object, configure standard Drupal node options (comments, url path, etc)
* Ingest occurs asynchronously soon after. 

###Collections

###Forms

###Display

###Derivatives

