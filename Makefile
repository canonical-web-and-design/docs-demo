PHONY:juju-docs
juju-docs:
	git clone git@github.com:juju/docs.git temp
	mv temp/src/en/ pages
	mv temp/htmldocs/media media
	mv temp/src/navigation.tpl _includes/navigation.html
	sed -E -i 's/href="(.*)\.html/href="{{ site.baseurl }}\/\1/g' _includes/navigation.html
	rm -rf temp
	./builddocs.py


PHONY:clean
clean:
	rm -rf pages
	rm -rf media


PHONY:maas-docs
maas-docs:
	git clone git@github.com:maas-docs/maas-docs.git temp
	mv temp/src/en/ pages
	mv temp/src/navigation.tpl _includes/navigation.html
	sed -E -i 's/href="(.*)\.html/href="{{ site.baseurl }}\/\1/g' _includes/navigation.html
	rm -rf temp
	./builddocs.py
