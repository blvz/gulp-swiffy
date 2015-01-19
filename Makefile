LSC=node_modules/LiveScript/bin/lsc
VOWS=node_modules/vows/bin/vows
default: metadata compile test

compile: deps src/*.ls
	@for f in src/*.ls; do \
		p=$${f%/*} ; \
		[[ $$p == src ]] && p='' ; \
		$(LSC) -c $$f -o ./$${p#*/} ; \
	done

test: compile test/*
	@$(VOWS) --spec test/runner.js

metadata: *.json.ls
	@$(LSC) -c *.json.ls

deps: metadata
	@npm install

.PHONY: test
