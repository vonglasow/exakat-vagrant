Exakat-vagrant
==============

Builds a vagrant with [exakat](http://www.exakat.io/) and all dependencies installed.

How do I use it?
----------------

Make sure you have all pre-requisite

* Ansible
* Vagrant
* Git


Then : 

::
   
    git clone https://github.com/dseguy/exakat-vagrant.git exakat-vagrant
    cd exakat-vagrant
    vagrant up --provision
    
More details
------------

* PHP binary for exakat execution (PHP with curl, tokenizer and sqlite3).
* PHP5.2 PHP5.3 PHP5.4 PHP5.5 PHP5.6 PHP7.0 and PHP7.1 for exakat analysis
* Neo4j 2.2.7 and gremlin 2.0 plugin, running on Java 8


Author
------

This repoistory is the brain child of [Alexis Van Glasow](https://github.com/vonglasow), with the help of contributor. 