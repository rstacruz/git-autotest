PREFIX ?= /usr/local

install:
	cp ./bin/* ${PREFIX}/bin/
	mkdir -p ${PREFIX}/share/git-autotest/images
	cp ./share/git-autotest/images/* ${PREFIX}/share/git-autotest/images/

uninstall:
	rm -rf ${PREFIX}/share/git-autotest
	rm -rf ${PREFIX}/bin/git-autotest
	
