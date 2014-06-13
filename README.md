Drupal-nfs Cookbook
=================

Setup nfs shares

[![Build Status](https://travis-ci.org/arknoll/drupal-nfs.png?branch=master)](https://travis-ci.org/arknoll/drupal-nfs)

Requirements
------------

### Platform:

Ubuntu

### Cookbooks:

nfs

Drupal-lamp usage
-----------------
Try this cookbook with drupal-lamp https://github.com/newmediadenver/drupal-lamp

To get it working with drupal-lamp:
* Open Berksfile in your drupal-lamp directory and place the following line in there
````
cookbook "drupal-nfs", git: "https://github.com/arknoll/drupal-nfs", branch: "master"
````
* Open chef/roles/drupal_lamp.rb in your drupal-lamp directory and add "recipe[drupal-nfs]", to the env_run_lists run list array

* run either 'vagrant up' or 'vagrant provision'

Usage
-----
### Mac Example:

**Expose a share of /srv/www/example/current**

This example will open up an nfs share:
* for the folder located at /srv/www/example/current
* it will be writeable
* when written to from the mount it will act as if you are user www-data and group www-data

````
"nfs_exports": {
    "/srv/www/example/current": {
      "clients": {
        "*": {
          "writeable": true,
          "sync": false,
          "options": [
            "no_subtree_check",
            "all_squash",
            "async"
          ],
          "anon_user_name": "www-data",
          "anon_group_name": "www-data"
        }
      }
    }
  }
````

**Mount the share on your mac**
````
sudo mount -o resvport [server ip]:/srv/www/example/current test
````


### Linux Example:

**Expose a share of /assets**

This example will open up an nfs share of the /assets folder on the virtualized server with the following details:

* Only clients with the IP address of 192.168.50.1 can mount this share (the default IP of a drupal-lamp host machine as seen by the virtualized server).
* Those who mount this will have write access.
* The [NFS sync option][1] will be used to ensure greater data cache coherence.
* Those who mount this will come through as www-data:www-data (uid 33 & gid 33 in a default drupal-lamp virtualized Ubuntu server).


````
  "nfs_exports": {
    "/assets": {
      "clients": {
        "192.168.50.1": {
          "writeable": true,
          "sync": true,
          "options": [
            "all_squash",
            "anonuid=33",
            "anongid=33"
          ]
        }
      }
    }
  }
````


**Mount the share on your linux machine**

Note:  Assumes you've exposed the share /assets on your virtualized server and you've created an empty assets folder in your drupal-lamp directory.

From the host machine:

````
sudo mount 192.168.50.5:/assets /home/[your_user_name]/drupal-lamp/assets
````


Attributes
----------

````
"nfs_exports": {
  "[share directory]": { # directory to share
    "clients": { # who can access
      "[ip address or *]": {
        "writeable": true, # true or false
        "sync": , # true or false
        "options": [], # array of nfs exports options. See nfs cookbook for options
        "user_map": "www-data", # this sets the anon user by name
        "group_map": "www-data" # this sets the anon group by name
      }
    }
  }
}
````
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


  [1]: http://linux.die.net/man/5/nfs
