# ruby-rice-sandbox
A sandbox to befriend Ruby and Rice.

# Usage on EC2 Ubuntu

Here is an example tested on a vanilla Ubuntu on EC2 on 2018-01-22:

OS: `$ cat /etc/lsb-release`:

```
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.3 LTS"
```

System: `$ uname -a`

```
Linux ip-172-31-44-47 4.4.0-1047-aws #56-Ubuntu SMP Sat Jan 6 19:39:06 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
```

Commands:

```
sudo apt-get update

# `rbenv`, via https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-14-04
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile

# Install our `ruby`.
time CONFIGURE_OPTS="--enable-shared" rbenv install 2.3.1
rbenv local 2.3.1

# Install `rice`.
sudo apt-get install -y build-essential autoconf
time gem install rice -v 2.1.2

# Fetch and run our code.
git clone https://github.com/FriendlyData/ruby-rice-sandbox.git
(cd ruby-rice-sandbox; make)
```

# Output
The last three lines of the output (or the only three lines, if you run the same `make` command again), should be:

```
ruby -e 'require "./native/lib"; gt = RiceTest.new(); puts gt.run("OK");' && echo OK || echo WA
<passed>OK</passed>
OK
```

# Semaphore

[![Build Status](https://semaphoreci.com/api/v1/friendly-data/ruby-rice-sandbox/branches/master/badge.svg)](https://semaphoreci.com/friendly-data/ruby-rice-sandbox)

I have configured Semaphore to pass the tests within this repo with the following commands:

```
sudo apt-get update
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
CONFIGURE_OPTS="--enable-shared" rbenv install -f 2.3.1
rbenv local 2.3.1
sudo apt-get install -y build-essential autoconf
gem install rice -v 2.1.2
make
```
