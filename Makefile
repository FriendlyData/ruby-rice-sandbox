.PHONY: test clean pack

OUT_DIR=out
ARCHIVE=archive.tar.gz

CPP=g++

CPPFLAGS=
CPPFLAGS+= -std=c++11
CPPFLAGS+= -fPIC # Required for the library to be dynamically linkable.
CPPFLAGS+= -w  # Disable warnings.

LDFLAGS=
LDFLAGS+= -shared
LDFLAGS+= -ldl -lpthread

CPPFLAGS+= -I./.rbenv/versions/2.3.1/include/ruby-2.3.0/
CPPFLAGS+= -I./.rbenv/versions/2.3.1/include/ruby-2.3.0/x86_64-linux/
CPPFLAGS+= -I./.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rice-2.1.2
LDFLAGS+= ./.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rice-2.1.2/rice/librice.a

test: ${OUT_DIR}/lib.so
	ruby -e "require './${OUT_DIR}/lib'; gt = RiceTest.new(); puts gt.run(\"OK\");" && echo OK || echo WA

clean:
	rm -rf "${OUT_DIR}"

pack:
	@rm -f ${ARCHIVE} && tar czf ${ARCHIVE} lib.cc Makefile  rice.h
	@echo 'cat <<EOF | base64 --decode | tar xz'
	@base64 ${ARCHIVE}
	@echo 'EOF'

${OUT_DIR}/%.o: %.cc
	@mkdir -p "${OUT_DIR}"
	${CPP} ${CPPFLAGS} -c "$<" -o "$@"

${OUT_DIR}/%.so: ${OUT_DIR}/%.o
	${CPP} -o "$@" "$<" ${LDFLAGS}
