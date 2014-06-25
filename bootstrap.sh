#!/bin/bash

## compile imagemagick with q8
apt-get install --force-yes -y -q devscripts imagemagick libgraphviz-dev libcdt4 libcgraph5 libgd3 libgraph4 libgvc5 libgvpr1 libpathplan4 libvpx1 libxdot4 libxpm4
cd /tmp
mkdir -p source/imagemagick
cd source/imagemagick
apt-get source --force-yes -y -q imagemagick
apt-get build-dep --force-yes -y -q imagemagick
cd imagemagick*
sed -i 's/\t\-\-x\-libraries\=\/usr\/lib\/X11/\t\-\-x\-libraries\=\/usr\/lib\/X11 \\\n\t--with-quantum-depth=8 \\\n\t--disable-openmp/' debian/rules
perl -pi -e 's/modules-Q16/modules-Q8/g' debian/libmagickcore5-extra.install
perl -pi -e 's/modules-Q16/modules-Q8/g' debian/libmagickcore5.install
dch -l local "$(basename `pwd`-q8)"
debuild -us -uc
apt-get remove --force-yes -y -q imagemagick
dpkg -i ../*.deb
cd /
rm -rf /tmp/*
## end imagemagick

## mongodb 10gen key
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

add-apt-repository ppa:jon-severinsson/ffmpeg -y
add-apt-repository ppa:nginx/development -y # for latest nginx, this is the mainline version which IS a stable version suitable for production according to nginx devs
apt-get update
apt-get install --force-yes -y -q ffmpeg nodejs nginx whois runit libgdcm-tools dcmtk phantomjs mongodb-10gen

## clean up so we use less space
apt-get clean
