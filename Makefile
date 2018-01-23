.PHONY: test clean 

native/%.so: %.cc
	mkdir -p native/${<:.cc=}
	cp $< native/${<:.cc=}
	(cd native/${<:.cc=}/; ruby -e 'require "mkmf-rice"; create_makefile("${<:.cc=}")'; make ${<:.cc=.so})
	cp native/${<:.cc=}/${<:.cc=.so} $@

test: native/lib.so
	ruby -e "require './native/lib'; gt = RiceTest.new(); puts gt.run(\"OK\");" && echo OK || echo WA

clean:
	rm -rf native/
