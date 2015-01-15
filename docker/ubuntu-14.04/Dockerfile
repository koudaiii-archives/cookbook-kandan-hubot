FROM chef/ubuntu-14.04

RUN apt-get update

# work around for AUFS bug
# as per https://github.com/docker/docker/issues/783#issuecomment-56013588
# ERROR:GMT FATAL:  could not access private key file "/etc/ssl/private/ssl-cert-snakeoil.key": Permission denied
# Reference: https://github.com/nimiq/docker-postgresql93/issues/2
RUN apt-get install -y -q postgresql-client-9.3
RUN apt-get install -y -q libpq-dev
RUN apt-get install -y -q postgresql-9.3
RUN mkdir /etc/ssl/private-copy; mv /etc/ssl/private/* /etc/ssl/private-copy/; rm -r /etc/ssl/private; mv /etc/ssl/private-copy /etc/ssl/private; chmod -R 0700 /etc/ssl/private; chown -R postgres /etc/ssl/private


RUN install -d -m 755 /cookbooks /etc/chef /var/chef/node

RUN echo "local_mode      true" >> /etc/chef/client.rb;  \
    echo "cookbook_path  ['/cookbooks']" >> /etc/chef/client.rb; \
    echo "cache_path      '/var/chef/cache'" >> /etc/chef/client.rb; \
    echo "node_path       '/var/chef/node'" >> /etc/chef/client.rb; \
    echo "environment     '_default'" >> /etc/chef/client.rb; \
    echo "ssl_verify_mode :verify_peer" >> /etc/chef/client.rb;

RUN echo '{"run_list":["role[base]"]}' > /var/chef/node/base.json
RUN echo '{"run_list":["role[mail]"]}' > /var/chef/node/mail.json
RUN echo '{"run_list":["role[db]"]}' > /var/chef/node/db.json
RUN echo '{"run_list":["role[ruby]"]}' > /var/chef/node/ruby.json

COPY ./cookbooks /cookbooks
COPY ./roles /roles

RUN chef-client -j /var/chef/node/base.json
RUN chef-client -j /var/chef/node/mail.json
RUN chef-client -j /var/chef/node/db.json
RUN chef-client -j /var/chef/node/ruby.json
