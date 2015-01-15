FROM chef/centos-6

RUN yum -y install tar
RUN install -d -m 755 /cookbooks /etc/chef /var/chef/node

RUN echo "local_mode      true" >> /etc/chef/client.rb;  \
    echo "cookbook_path  ['/cookbooks']" >> /etc/chef/client.rb; \
    echo "cache_path      '/var/chef/cache'" >> /etc/chef/client.rb; \
    echo "node_path       '/var/chef/node'" >> /etc/chef/client.rb; \
    echo "environment     '_default'" >> /etc/chef/client.rb; \
    echo "ssl_verify_mode :verify_peer" >> /etc/chef/client.rb;

RUN echo '{"run_list":["recipe[my_timezone]"]}' > /var/chef/node/my_timezone.json
RUN echo '{"run_list":["recipe[my_ntp]"]}' > /var/chef/node/my_ntp.json
RUN echo '{"run_list":["recipe[my_locale]"]}' > /var/chef/node/my_locale.json
RUN echo '{"run_list":["recipe[my_postfix]"]}' > /var/chef/node/my_postfix.json

COPY ./cookbooks /cookbooks

RUN chef-client -j /var/chef/node/my_timezone.json
RUN chef-client -j /var/chef/node/my_ntp.json
RUN chef-client -j /var/chef/node/my_locale.json
RUN chef-client -j /var/chef/node/my_postfix.json
