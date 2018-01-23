.PHONY: test clean 

SO=""
ifeq ($(shell uname),Darwin)
	SO=bundle
else
	SO=so
endif

test: native/lib.${SO}
	ruby -e "require './native/lib'; gt = RiceTest.new(); puts gt.run(\"OK\");" && echo OK || echo WA

native/%.${SO}: %.cc
	mkdir -p native/
	rm -rf native/${<:.cc=}
	mkdir native/${<:.cc=}/
	cp $< native/${<:.cc=}
	(cd native/${<:.cc=}/; ruby -e 'require "mkmf-rice"; create_makefile("${<:.cc=}")'; make ${<:.cc=.${SO}})
	cp native/${<:.cc=}/${<:.cc=.${SO}} $@

clean:
	rm -rf native/
