FROM chef/centos-6

RUN yum -y install tar
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

COPY ./cookbooks /cookbooks
COPY ./roles /roles

RUN chef-client -j /var/chef/node/base.json
RUN chef-client -j /var/chef/node/mail.json
RUN chef-client -j /var/chef/node/db.json
