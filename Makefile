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
	sed -E -i '.bak' 's/\.md//g' pages/juju/*
	-rm -rf pages/juju/*.bak
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
	sed -E -i '.bak' 's/\.md//g' pages/maas/*
	-rm -rf pages/maas/*.bak
	-rm -rf _includes/*.bak
	-rm -rf _layouts/*.bak
	-rm -rf temp
	./builddocs.py maas

PHONY:snappy-dev-docs
snappy-dev-docs:
	git clone git@github.com:CanonicalLtd/snappy-docs.git temp
	mkdir -p pages/snappy-dev media/snappy-dev
	cp temp/*.md pages/snappy-dev
	cp temp/media/* media/snappy-dev/
	cp _layouts/default.html _layouts/snappy-dev-default.html
	cp temp/navigation.html _includes/snappy-dev-navigation.html
# removed '.bak' from the three sed statements (as -p doesn't seem to be an option as suggested)
	sed -E -i 's/"(.*)\.md"/"{{ site.baseurl }}\/snappy-dev\/\1"/g' _includes/snappy-dev-navigation.html
	sed -E -i 's/"(.*)\.md#/"{{ site.baseurl }}\/snappy-dev\/\1#/g' _includes/snappy-dev-navigation.html
	sed -E -i 's/navigation.html/snappy-dev-navigation.html/g' _layouts/snappy-dev-default.html
	#sed -E -i 's/\.md//g' pages/snappy-dev/*
	sed -E -i 's_]\((.*)\.md_](../\1_g' pages/snappy-dev/*
	-rm -rf pages/snappy-dev/*.bak
	-rm -rf _includes/*.bak
	-rm -rf _layouts/*.bak
	-rm -rf temp
	./builddocs.py snappy-dev

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
	sed -E -i '.bak' 's/\.md//g' pages/snappy/*
	-rm -rf pages/snappy/*.bak
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
	sed -E -i '.bak' 's/\.md//g' pages/snapcraft/*
	-rm -rf pages/snapcraft/*.bak
	-rm -rf _includes/*.bak
	-rm -rf _layouts/*.bak
	-rm -rf temp
	./builddocs.py snapcraft

PHONY:lxd-docs
lxd-docs:
	git clone git@github.com:lxc/lxd.git temp
	mkdir -p pages/lxd
	cp temp/doc/* pages/lxd
	echo "<ul>" > _includes/lxd-navigation.html
	ls pages/lxd >> _includes/lxd-navigation.html
	sed -E -i '.bak' 's/(.*)\.md/<li><a href="{{ site.baseurl }}\/lxd\/\1">\1<\/a><\/li>/g' _includes/lxd-navigation.html
	echo "</ul>" >> _includes/lxd-navigation.html
	cp _layouts/default.html _layouts/lxd-default.html
	sed -E -i '.bak' 's/navigation.html/lxd-navigation.html/g' _layouts/lxd-default.html
	cp pages/lxd/configuration.md pages/lxd/index.md # hack for lack of index page
	sed -E -i '.bak' 's/\.md//g' pages/lxd/*
	-rm -rf pages/lxd/*.bak
	-rm -rf _includes/*.bak
	-rm -rf _layouts/*.bak
	-rm -rf temp
	./builddocs.py lxd


PHONY:clean
clean:
	-rm -rf pages media temp
	-rm _layouts/*-default.html
	-rm _includes/*-navigation.html

PHONY:docs
docs: clean juju-docs maas-docs snappy-docs snappy-dev-docs snapcraft-docs lxd-docs
