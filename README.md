Drupal-nfs Cookbook
=================

Setup nfs shares

[![Build Status](https://travis-ci.org/arknoll/drupal-nfs.png?branch=master)](https://travis-ci.org/arknoll/drupal-nfs)

Try this cookbook with drupal-lamp https://github.com/newmediadenver/drupal-lamp

To get it working with drupal-lamp:
* Add reference in BerksFile
* Add "recipe[drupal-nfs]", to the run list

Requirements
------------

### Platform:

Ubuntu

### Cookbooks:

nfs

Attributes
----------

````
"nfs_exports": {
  "/assets": { # directory to share
    "clients": { # who can access
      "[ip address]": {
        "writable": true, # true or false
        "sync": , # true or false
        "options": "" # see nfs cookbook for options
      }
    }
  }
}

Recipes
-------

### drupal-nfs::default

Adds a mountable nfs share

Testing
-------

[![Build Status](https://travis-ci.org/arknoll/drupal-nfs.png?branch=master)](https://travis-ci.org/arknoll/drupal-nfs)

The cookbook provides the following Rake tasks for testing:

    rake foodcritic                   # Lint Chef cookbooks
    rake integration                  # Alias for kitchen:all
    rake kitchen:all                  # Run all test instances
    rake kitchen:default-centos-64    # Run default-centos-64 test instance
    rake kitchen:default-ubuntu-1204  # Run default-ubuntu-1204 test instance
    rake rubocop                      # Run RuboCop style and lint checks
    rake spec                         # Run ChefSpec examples
    rake test                         # Run all tests

License
-------

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Contributing
------------

We welcome contributed improvements and bug fixes via the usual workflow:

1. Fork this repository
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request
