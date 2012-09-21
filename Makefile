#!/usr/bin/make
# Zur Erstellung des Debian-Pakets notwendig (make DESTDIR=/root/sophomorix)
# Created by Rüdiger Beck (jeffbeck-at-web.de)
DESTDIR=

CONF=$(DESTDIR)/etc/linuxmuster-client/tor-browser-bundle
BIN=$(DESTDIR)/usr/bin
SBIN=$(DESTDIR)/usr/sbin
SHARE=$(DESTDIR)/usr/share/linuxmuster-client-tor-browser-bundle
DESKTOP=$(DESTDIR)/usr/share/applications
ICON=$(DESTDIR)/usr/share/pixmaps
ETC=$(DESTDIR)/etc/sudoers.d

help:
	@echo ' '
	@echo 'Most common options of this Makefile:'
	@echo '-------------------------------------'
	@echo ' '
	@echo '   make help'
	@echo '      show this help'
	@echo ' '
	@echo '   make install'
	@echo '      install all stuff'
	@echo ' '
	@echo '   make deb'
	@echo '      create a debian package'
	@echo ' '


install:
	@echo '   * Installing downloader script'
	@install -d -m755 -oroot -groot $(SBIN)
	@install -oroot -groot --mode=0775 scripts/linuxmuster-client-tor-browser-bundle-downloader $(SBIN)
	@echo '   * Installing starter script'
	@install -d -m755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0775 scripts/linuxmuster-client-tor-browser-bundle $(BIN)
	@echo '   * Installing unity dash entry'
	@install -d -m0755 -oroot -groot $(DESKTOP)
	@install -oroot -groot --mode=0644 icons/tor-browser-bundle.desktop $(DESKTOP)
	@echo '   * Installing icon'
	@install -d -m0755 -oroot -groot $(ICON)
	@install -oroot -groot --mode=0644 icons/tor-browser-bundle.png $(ICON)



# build a package
deb:
	### deb
	@echo 'Did you do a dch -i ?'
	#@sleep 8
	dpkg-buildpackage -tc -uc -us -sa -rfakeroot
	@echo ''
	@echo 'Do not forget to tag this version in git'
	@echo ''


clean:
	# delete stuff after building package