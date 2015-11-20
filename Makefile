all: composer deb neo4j

composer: deb
	curl -sS https://getcomposer.org/installer | php
	sudo mv composer.phar /usr/local/bin/composer

deb: dotdeb.gpg /etc/apt/sources.list.d/php54.list /etc/apt/sources.list.d/php55.list /etc/apt/sources.list.d/php56.list /etc/apt/sources.list.d/webupd8team-java.list
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get install vim tree git php5-cli zip wkhtmltopdf maven vim python-software-properties php5-mysqlnd sqlite gcc make libxml2-dev autoconf re2c bison screen php5-curl php5-sqlite libssl-dev libcurl4-openssl-dev pkg-config libbz2-dev libjpeg-dev libpng-dev libXpm-dev libfreetype6-dev libgmp3-dev libldap2-dev libmcrypt-dev libmhash-dev freetds-dev libz-dev ncurses-dev libpcre3-dev unixODBC-dev libsqlite-dev libaspell-dev libreadline6-dev librecode-dev oracle-java8-installer
	sudo apt-get clean
	sudo apt-get install libt1-dev

neo4j: /etc/apt/sources.list.d/webupd8team-java.list
	wget http://dist.neo4j.org/neo4j-community-2.2.4-unix.tar.gz
	tar -xvf neo4j-community-2.2.4-unix.tar.gz
	mv neo4j-community-2.2.4 neo4j

gremlin: neo4j
	git clone https://github.com/thinkaurelius/neo4j-gremlin-plugin.git neo4j-gremlin-plugin
	$(shell cd neo4j-gremlin-plugin && mvn clean package)
	unzip neo4j-gremlin-plugin/target/neo4j-gremlin-plugin-2.1-SNAPSHOT-server-plugin.zip -d neo4j/plugins/gremlin-plugin
	neo4j/bin/neo4j restart

gremlin-hard: neo4j
	git clone https://github.com/thinkaurelius/neo4j-gremlin-plugin.git gremlin-plugin
	git clone https://github.com/tinkerpop/blueprints
	git clone https://github.com/tinkerpop/pipes
	git clone https://github.com/tinkerpop/rexster
	git clone https://github.com/tinkerpop/gremlin

dotdeb.gpg:
	wget https://www.dotdeb.org/dotdeb.gpg
	sudo apt-key add dotdeb.gpg

/etc/apt/sources.list.d/php54.list: dotdeb.gpg
	echo "deb http://packages.dotdeb.org squeeze-php54 all" | sudo tee /etc/apt/sources.list.d/php54.list
	echo "deb-src http://packages.dotdeb.org squeeze-php54 all" | sudo tee /etc/apt/sources.list.d/php54.list

/etc/apt/sources.list.d/php55.list: dotdeb.gpg
	echo "deb http://packages.dotdeb.org wheezy-php55 all" | sudo tee /etc/apt/sources.list.d/php55.list
	echo "deb-src http://packages.dotdeb.org wheezy-php55 all" | sudo tee /etc/apt/sources.list.d/php55.list

/etc/apt/sources.list.d/php56.list: dotdeb.gpg
	echo "deb http://packages.dotdeb.org wheezy-php56 all" | sudo tee /etc/apt/sources.list.d/php56.list
	echo "deb-src http://packages.dotdeb.org wheezy-php56 all" | sudo tee /etc/apt/sources.list.d/php56.list

/etc/apt/sources.list.d/webupd8team-java.list:
	echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | sudo tee /etc/apt/sources.list.d/webupd8team-java.list
	echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

clean:
	sudo rm -rf /etc/apt/sources.list.d/php54.list
	sudo rm -rf /etc/apt/sources.list.d/php55.list
	sudo rm -rf /etc/apt/sources.list.d/php56.list
	sudo rm -rf /etc/apt/sources.list.d/webupd8team-java.list
	sudo rm -rf neo4j
	sudo rm -rf gremlin
	sudi rm -rf neo4j-community-2.2.4-unix.tar.gz
	sudo apt-key del 4096R/89DF5277
	sudo apt-get update

.INTERMEDIATE: dotdeb.gpg neo4j-community-2.2.4-unix.tar.gz

.PHONY: clean all
