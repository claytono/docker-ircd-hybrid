#!/bin/bash -euxv


URL="http://ftp.debian.org/debian/pool/main/i/ircd-hybrid/"
DSC="ircd-hybrid_7.2.2.dfsg.2-10+deb7u1.dsc"
DIFF="ircd-hybrid_7.2.2.dfsg.2-10+deb7u1.diff.gz"
TAR="ircd-hybrid_7.2.2.dfsg.2.orig.tar.gz"

set -o pipefail

cd /tmp

PKGS="build-essential devscripts wget"

apt-get update
apt-get install -y $PKGS

for file in $DSC $DIFF $TAR; do 
    wget ${URL}/$file
done

dpkg-source -x $DSC
echo y | mk-build-deps -i $DSC

cd $(find -maxdepth 1 -name 'ircd-hybrid*' -type d)
echo 9 > debian/compat

patch -p1 </tmp/patch.diff

dpkg-buildpackage

cd ..
dpkg -i ircd-hybrid*.deb
rm -rf ircd-hybrid*

apt-get purge -y $PKGS
apt-get autoremove -y --purge

rm -rf /var/lib/apt/lists/*
