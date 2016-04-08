= Avalon Fedora 4 Conversion Tester

A Hydra Works](https://github.com/projecthydra-labs/hydra-works) based app for testing the conversion of Avalon content from Fedora 3 to Fedora 4

== Known Bugs

* AdminCollections fail to import
* Relationships are local
* MasterFile labels are lost

All of these will be fixed prior to Avalon converting of course.

== What Is Working

* Descriptive Metadata is converted for all objects
* DublinCore information is converted
* Thumbnails and Posters are exported successfully
* mhMetadata is converted for MasterFiles
* encoding information is converted

== To Set This Tester Up

1. Clone this Repo
1. Run `bundle install`
1. Open `config/fedora3.yml` and edit the yml file to point to your current Fedora 3 repo along with login information
1. Open a new terminal window and launch the Fedora 4 wrapper `fcrepo_wrapper -p 8984`
1. Open a new terminal window and launch the Solr 5 wrapper `solr_wrapper -d solr/config/ --collection_name hydra-development`
1. If you are not using avalon as your instance namespace you need to update the rake task:
  1. Open `lib/tasks/fedora_migrate.rake`
  1. In `namespace: "avalon"` on line 3 of the rake file, replace `"avalon"` with the namespace your avalon instance uses
1. In your original terminal window run `rake migrate`
1. A migration report will be generated in `migration_report`
1. As long as your terminal window with your Fedora 4 wrapper is open you can view the Fedora 4 instance at http://127.0.0.1:8984/rest

== See Also

This project is based on [Hydra Works](https://github.com/projecthydra-labs/hydra-works)

The migration is performed by the [Fedora Migrate Gem](https://github.com/projecthydra-labs/fedora-migrate)
