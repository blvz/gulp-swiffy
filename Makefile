default: all

LSC=./node_modules/LiveScript/bin/lsc

all: build

metadata: package.json.ls
	@ [ -f "$(LSC)" ] || npm install LiveScript
	@ $(LSC) -c *.json.ls

build: metadata src/*.ls
	@for f in src/*.ls; do \
		p=$${f%/*} ; \
		[[ $$p == src ]] && p='' ; \
		$(LSC) -c $$f -o ./$${p#*/} ; \
	done

test: build
	@ $(LSC) test/*.ls

install: metadata
	@ npm install
