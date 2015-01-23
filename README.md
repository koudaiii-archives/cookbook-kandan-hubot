cookbook-kangan-hubot
==================

### Overview

cookbook for kandan and hubot

### Description

install kandan and hubot by Chef Solo.
default timezone is Tokyo.
If you want to Customize. please set default attributes.

Platform is ubuntu14.04 and CentOS6.

* example

Change URL and kandan version

```roles/web.json
  "override_attributes": {
    "my_nginx" : {
      "servername" : "YourServer"
    },
    "my_kandan" : {
      "servername" : "YourServer"
    }
  }
```

```roles/base.json
  "tz": "Asia/Tokyo",
```

### Requirement

* Ruby
* bundler
* SSH login(admin)

### Install

* vagrant 1.6.3 or later
* virtualbox
* vagrant plugin vagrant-omnibus
* Ruby 2.1.5 or later
* gem install bundler

### Usage

* bundle install

```bash
bundle install
```

* provision server

```bash
bundle exec knife solo bootstrap YourServer
```

* [Defalut]kandan accepts the "http://webapp/". Please set up "/etc/nginx/sites-enabled/app".

* setup hubot

```bash
$ ssh root@YourServer
# cd /opt/hubot/ ; yo hubot
```

### Develop(Vagrant)

#### Requiremants

* add hosts

```hosts
192.168.33.10 webapp
```

* add ssh config

```config
vagrant ssh-config >> ~/.ssh/config
```

* chanage Host

```~/.ssh/config
Host webapp
```
* set Host Only Network in virtualbox

[Qiita](http://qiita.com/Itomaki/items/a0a29f29d43a7bd24a32)

#### build and run test

* bootstrapping

```bash
bundle exec rake vagrant:init
```

### Test(Docker)

#### Requirements

* Docker 1.0+

#### build and run test

```bash
bundle exec thor docker
```

### Contribution
- Fork the this repository on GitHub
- Create a named feature branch (like add_component_x)
- Write your change
- If at all possible, write serverspec tests for your change and ensure they all pass
- Submit a pull request using GitHub
