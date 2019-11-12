#!/bin/bash

# docker commit -p -m "centoslocal snapshot the systemd for ansible" -a "HBK Mustang" centos-systemd hbkmustang/centos-systemd-ansible:v2
# docker push hbkmustang/centos-systemd-ansible

docker container stop centos-systemd
docker container rm centos-systemd
docker run --hostname="centoslocal" -d -p 192.168.33.21:22:22 -p 192.168.33.21:80:80 --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name=centos-systemd hbkmustang/centos-systemd-ansible:v2

#!/bin/bash

# docker commit -p -m "debianlocal systemd snapshot for ansible" -a "HBK Mustang" debian-systemd hbkmustang/debian-systemd-ansible:v4
# docker push hbkmustang/debian-systemd-ansible:v2

docker container stop debian-systemd
docker container rm debian-systemd
docker run --hostname="debianlocal" -d -p 192.168.33.22:22:22 -p 192.168.33.22:80:80 --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name=debian-systemd hbkmustang/debian-systemd-ansible:v4

#!/bin/bash

ansible-playbook /etc/ansible/nginx.yml -t install
ansible-playbook /etc/ansible/nginx.yml -t start -t enable
ansible-playbook /etc/ansible/nginx.yml -t stop -t disable

ansible-playbook /etc/ansible/progs.yml -t regulary
ansible-playbook /etc/ansible/progs.yml -t packages_delete --extra-vars='package_remove=unzip,zip'
ansible-playbook /etc/ansible/progs.yml -t packages_install --extra-vars='package_install=unzip,zip,nano'
 
