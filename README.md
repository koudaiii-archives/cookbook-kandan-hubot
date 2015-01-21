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
      "servername" : "webapp"
    }
  }
```

```roles/base.json
  "tz": "Asia/Tokyo",
  "override_attributes": {
    }
  },
```

* setup hubot
root user
```
# cd /opt/hubot/
# yo hubot
# sh hubot.sh start
```


### Requirement

* cookbook 'nginx'
* cookbook 'timezone-ii'

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

* build berks

```bash
bundle exec berks vendor cookbooks
```

* provision server

```bash
bundle exec knife solo bootstrap YourServer
```

* [Defalut]kandan accepts the "http://webapp/". Please set up "/etc/nginx/sites-enabled/app".

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

#### build and run test

* bootstrapping

```bash
bundle exec rake vagrant:bootstrap
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
