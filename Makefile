PHONY:juju-docs
juju-docs:
	git clone git@github.com:juju/docs.git temp
	mkdir -p pages/juju media/juju
	cp temp/src/en/* pages/juju/
	cp temp/htmldocs/media/* media/juju/
	cp temp/src/navigation.tpl _includes/juju-navigation.html
	sed -E -i '.bak' 's/href="(.*)\.html/href="{{ site.baseurl }}\/juju\/\1/g' _includes/juju-navigation.html
	cp _layouts/default.html _layouts/juju-default.html
	sed -E -i '.bak' 's/navigation.html/juju-navigation.html/g' _layouts/juju-default.html
	cp pages/juju/about-juju.md pages/juju/index.md # hack for lack of index page
	-rm -rf _includes/*.bak
	-rm -rf _layouts/*.bak
	-rm -rf temp
	./builddocs.py juju

PHONY:maas-docs
maas-docs:
	git clone git@github.com:maas-docs/maas-docs.git temp
	mkdir -p pages/maas
	cp temp/src/en/* pages/maas
	cp temp/src/navigation.tpl _includes/maas-navigation.html
	sed -E -i '.bak' 's/href="(.*)\.html/href="{{ site.baseurl }}\/maas\/\1/g' _includes/maas-navigation.html
	cp _layouts/default.html _layouts/maas-default.html
	sed -E -i '.bak' 's/navigation.html/maas-navigation.html/g' _layouts/maas-default.html
	-rm -rf _includes/*.bak
	-rm -rf _layouts/*.bak
	-rm -rf temp
	./builddocs.py maas

PHONY:snappy-docs
snappy-docs:
	git clone git@github.com:ubuntu-core/snappy.git temp
	mkdir -p pages/snappy
	cp temp/docs/* pages/snappy
	echo "<ul>" > _includes/snappy-navigation.html
	ls pages/snappy >> _includes/snappy-navigation.html
	sed -E -i '.bak' 's/(.*)\.md/<li><a href="{{ site.baseurl }}\/snappy\/\1">\1<\/a><\/li>/g' _includes/snappy-navigation.html
	echo "</ul>" >> _includes/snappy-navigation.html
	cp _layouts/default.html _layouts/snappy-default.html
	sed -E -i '.bak' 's/navigation.html/snappy-navigation.html/g' _layouts/snappy-default.html
	cp pages/snappy/config.md pages/snappy/index.md # hack for lack of index page
	-rm -rf _includes/*.bak
	-rm -rf _layouts/*.bak
	-rm -rf temp
	./builddocs.py snappy

PHONY:snapcraft-docs
snapcraft-docs:
	git clone git@github.com:ubuntu-core/snapcraft.git temp
	mkdir -p pages/snapcraft media/snapcraft
	cp temp/docs/*.md pages/snapcraft
	cp temp/docs/images/* media/snapcraft/
	echo "<ul>" > _includes/snapcraft-navigation.html
	ls pages/snapcraft >> _includes/snapcraft-navigation.html
	sed -E -i '.bak' 's/(.*)\.md/<li><a href="{{ site.baseurl }}\/snapcraft\/\1">\1<\/a><\/li>/g' _includes/snapcraft-navigation.html
	echo "</ul>" >> _includes/snapcraft-navigation.html
	cp _layouts/default.html _layouts/snapcraft-default.html
	sed -E -i '.bak' 's/navigation.html/snapcraft-navigation.html/g' _layouts/snapcraft-default.html
	cp pages/snapcraft/intro.md pages/snapcraft/index.md # hack for lack of index page
	-rm -rf _includes/*.bak
	-rm -rf _layouts/*.bak
	-rm -rf temp
	./builddocs.py snapcraft

PHONY:clean
clean:
	-rm -rf pages media temp
	-rm _layouts/*-default.html
	-rm _includes/*-navigation.html

PHONY:docs
docs: clean juju-docs maas-docs snappy-docs snapcraft-docs
