VERSION=$(shell ./ufwd -v 2>&1)
MACHINE=$(shell uname -sp | tr '[A-Z]' '[a-z]' | sed -e 's/\s/-/')

all: test

test:
	go test ./...

pack: manpage
	go build .
	mkdir -p tmp/bin tmp/share/man pkg
	cp ufwd tmp/bin
	cp man/ufwd.1 tmp/share/man
	cd tmp && zip -r ../pkg/ufwd-$(VERSION)-$(MACHINE).zip bin
	rm -r tmp

manpage:
	ronn --manual="Mir's uwfd manual" --organization='Mir' man/*.ronn
