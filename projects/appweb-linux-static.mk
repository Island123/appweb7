#
#   appweb-linux-static.mk -- Makefile to build Embedthis Appweb for linux
#

PRODUCT            := appweb
VERSION            := 4.4.0
BUILD_NUMBER       := 0
PROFILE            := static
ARCH               := $(shell uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/')
CC_ARCH            := $(shell echo $(ARCH) | sed 's/x86/i686/;s/x64/x86_64/')
OS                 := linux
CC                 := gcc
LD                 := link
CONFIG             := $(OS)-$(ARCH)-$(PROFILE)
LBIN               := $(CONFIG)/bin

BIT_PACK_CGI       := 1
BIT_PACK_EJSCRIPT  := 0
BIT_PACK_ESP       := 1
BIT_PACK_EST       := 0
BIT_PACK_MATRIXSSL := 0
BIT_PACK_MDB       := 1
BIT_PACK_NANOSSL   := 0
BIT_PACK_OPENSSL   := 0
BIT_PACK_PCRE      := 1
BIT_PACK_PHP       := 0
BIT_PACK_SDB       := 0
BIT_PACK_SQLITE    := 0
BIT_PACK_SSL       := 0

ifeq ($(BIT_PACK_EST),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_LIB),1)
    BIT_PACK_COMPILER := 1
endif
ifeq ($(BIT_PACK_MATRIXSSL),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_MDB),1)
    BIT_PACK_ESP := 1
endif
ifeq ($(BIT_PACK_NANOSSL),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_SDB),1)
    BIT_PACK_ESP := 1
    BIT_PACK_SQLITE := 1
endif

BIT_PACK_CGI_PATH         := cgi
BIT_PACK_COMPILER_PATH    := gcc
BIT_PACK_DIR_PATH         := dir
BIT_PACK_DOXYGEN_PATH     := doxygen
BIT_PACK_DSI_PATH         := dsi
BIT_PACK_EJSCRIPT_PATH    := ejscript
BIT_PACK_ESP_PATH         := esp
BIT_PACK_EST_PATH         := est
BIT_PACK_LIB_PATH         := ar
BIT_PACK_LINK_PATH        := link
BIT_PACK_MAN_PATH         := man
BIT_PACK_MAN2HTML_PATH    := man2html
BIT_PACK_MATRIXSSL_PATH   := /usr/src/matrixssl
BIT_PACK_MDB_PATH         := mdb
BIT_PACK_NANOSSL_PATH     := /usr/src/nanossl
BIT_PACK_OPENSSL_PATH     := /usr/src/openssl
BIT_PACK_PCRE_PATH        := pcre
BIT_PACK_PHP_PATH         := /usr/src/php
BIT_PACK_PMAKER_PATH      := pmaker
BIT_PACK_SDB_PATH         := sdb
BIT_PACK_SQLITE_PATH      := sqlite
BIT_PACK_SSL_PATH         := ssl
BIT_PACK_UTEST_PATH       := utest
BIT_PACK_ZIP_PATH         := zip

CFLAGS             += -O2 -fPIC -w
DFLAGS             += -D_REENTRANT -DPIC $(patsubst %,-D%,$(filter BIT_%,$(MAKEFLAGS))) -DBIT_PACK_CGI=$(BIT_PACK_CGI) -DBIT_PACK_EJSCRIPT=$(BIT_PACK_EJSCRIPT) -DBIT_PACK_ESP=$(BIT_PACK_ESP) -DBIT_PACK_EST=$(BIT_PACK_EST) -DBIT_PACK_MATRIXSSL=$(BIT_PACK_MATRIXSSL) -DBIT_PACK_MDB=$(BIT_PACK_MDB) -DBIT_PACK_NANOSSL=$(BIT_PACK_NANOSSL) -DBIT_PACK_OPENSSL=$(BIT_PACK_OPENSSL) -DBIT_PACK_PCRE=$(BIT_PACK_PCRE) -DBIT_PACK_PHP=$(BIT_PACK_PHP) -DBIT_PACK_SDB=$(BIT_PACK_SDB) -DBIT_PACK_SQLITE=$(BIT_PACK_SQLITE) -DBIT_PACK_SSL=$(BIT_PACK_SSL) 
IFLAGS             += -I$(CONFIG)/inc
LDFLAGS            += '-rdynamic' '-Wl,--enable-new-dtags' '-Wl,-rpath,$$ORIGIN/'
LIBPATHS           += -L$(CONFIG)/bin
LIBS               += -lrt -ldl -lpthread -lm

DEBUG              := debug
CFLAGS-debug       := -g
DFLAGS-debug       := -DBIT_DEBUG
LDFLAGS-debug      := -g
DFLAGS-release     := 
CFLAGS-release     := -O2
LDFLAGS-release    := 
CFLAGS             += $(CFLAGS-$(DEBUG))
DFLAGS             += $(DFLAGS-$(DEBUG))
LDFLAGS            += $(LDFLAGS-$(DEBUG))

BIT_ROOT_PREFIX    := 
BIT_BASE_PREFIX    := $(BIT_ROOT_PREFIX)/usr/local
BIT_DATA_PREFIX    := $(BIT_ROOT_PREFIX)/
BIT_STATE_PREFIX   := $(BIT_ROOT_PREFIX)/var
BIT_APP_PREFIX     := $(BIT_BASE_PREFIX)/lib/$(PRODUCT)
BIT_VAPP_PREFIX    := $(BIT_APP_PREFIX)/$(VERSION)
BIT_BIN_PREFIX     := $(BIT_ROOT_PREFIX)/usr/local/bin
BIT_INC_PREFIX     := $(BIT_ROOT_PREFIX)/usr/local/include
BIT_LIB_PREFIX     := $(BIT_ROOT_PREFIX)/usr/local/lib
BIT_MAN_PREFIX     := $(BIT_ROOT_PREFIX)/usr/local/share/man
BIT_SBIN_PREFIX    := $(BIT_ROOT_PREFIX)/usr/local/sbin
BIT_ETC_PREFIX     := $(BIT_ROOT_PREFIX)/etc/$(PRODUCT)
BIT_WEB_PREFIX     := $(BIT_ROOT_PREFIX)/var/www/$(PRODUCT)-default
BIT_LOG_PREFIX     := $(BIT_ROOT_PREFIX)/var/log/$(PRODUCT)
BIT_SPOOL_PREFIX   := $(BIT_ROOT_PREFIX)/var/spool/$(PRODUCT)
BIT_CACHE_PREFIX   := $(BIT_ROOT_PREFIX)/var/spool/$(PRODUCT)/cache
BIT_SRC_PREFIX     := $(BIT_ROOT_PREFIX)$(PRODUCT)-$(VERSION)


TARGETS            += $(CONFIG)/bin/libmpr.a
TARGETS            += $(CONFIG)/bin/libmprssl.a
TARGETS            += $(CONFIG)/bin/appman
TARGETS            += $(CONFIG)/bin/makerom
TARGETS            += $(CONFIG)/bin/ca.crt
ifeq ($(BIT_PACK_PCRE),1)
TARGETS            += $(CONFIG)/bin/libpcre.a
endif
TARGETS            += $(CONFIG)/bin/libhttp.a
TARGETS            += $(CONFIG)/bin/http
ifeq ($(BIT_PACK_SQLITE),1)
TARGETS            += $(CONFIG)/bin/libsqlite3.a
endif
ifeq ($(BIT_PACK_SQLITE),1)
TARGETS            += $(CONFIG)/bin/sqlite
endif
TARGETS            += $(CONFIG)/bin/libappweb.a
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += $(CONFIG)/bin/libmod_esp.a
endif
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += $(CONFIG)/bin/esp
endif
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += $(CONFIG)/bin/esp.conf
endif
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += src/server/esp.conf
endif
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += $(CONFIG)/esp
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/libejs.a
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/ejs
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/ejsc
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/ejs.mod
endif
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += $(CONFIG)/bin/libmod_cgi.a
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/libmod_ejs.a
endif
ifeq ($(BIT_PACK_PHP),1)
TARGETS            += $(CONFIG)/bin/libmod_php.a
endif
ifeq ($(BIT_PACK_SSL),1)
TARGETS            += $(CONFIG)/bin/libmod_ssl.a
endif
TARGETS            += $(CONFIG)/bin/authpass
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += $(CONFIG)/bin/cgiProgram
endif
TARGETS            += src/server/slink.c
TARGETS            += $(CONFIG)/bin/libslink.a
TARGETS            += $(CONFIG)/bin/appweb
TARGETS            += src/server/cache
TARGETS            += $(CONFIG)/bin/testAppweb
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += test/cgi-bin/testScript
endif
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += test/web/caching/cache.cgi
endif
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += test/web/auth/basic/basic.cgi
endif
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += test/cgi-bin/cgiProgram
endif

unexport CDPATH

ifndef SHOW
.SILENT:
endif

all build compile: prep $(TARGETS)

.PHONY: prep

prep:
	@echo "      [Info] Use "make SHOW=1" to trace executed commands."
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@if [ "$(BIT_APP_PREFIX)" = "" ] ; then echo WARNING: BIT_APP_PREFIX not set ; exit 255 ; fi
	@[ ! -x $(CONFIG)/bin ] && mkdir -p $(CONFIG)/bin; true
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc; true
	@[ ! -x $(CONFIG)/obj ] && mkdir -p $(CONFIG)/obj; true
	@[ ! -f $(CONFIG)/inc/bitos.h ] && cp src/bitos.h $(CONFIG)/inc/bitos.h ; true
	@if ! diff $(CONFIG)/inc/bitos.h src/bitos.h >/dev/null ; then\
		cp src/bitos.h $(CONFIG)/inc/bitos.h  ; \
	fi; true
	@[ ! -f $(CONFIG)/inc/bit.h ] && cp projects/appweb-linux-static-bit.h $(CONFIG)/inc/bit.h ; true
	@if ! diff $(CONFIG)/inc/bit.h projects/appweb-linux-static-bit.h >/dev/null ; then\
		cp projects/appweb-linux-static-bit.h $(CONFIG)/inc/bit.h  ; \
	fi; true
	@if [ -f "$(CONFIG)/.makeflags" ] ; then \
		if [ "$(MAKEFLAGS)" != " ` cat $(CONFIG)/.makeflags`" ] ; then \
			echo "   [Warning] Make flags have changed since the last build: "`cat $(CONFIG)/.makeflags`"" ; \
		fi ; \
	fi
	@echo $(MAKEFLAGS) >$(CONFIG)/.makeflags

clean:
	rm -f "$(CONFIG)/bin/libmpr.a"
	rm -f "$(CONFIG)/bin/libmprssl.a"
	rm -f "$(CONFIG)/bin/appman"
	rm -f "$(CONFIG)/bin/makerom"
	rm -f "$(CONFIG)/bin/libest.a"
	rm -f "$(CONFIG)/bin/ca.crt"
	rm -f "$(CONFIG)/bin/libpcre.a"
	rm -f "$(CONFIG)/bin/libhttp.a"
	rm -f "$(CONFIG)/bin/http"
	rm -f "$(CONFIG)/bin/libsqlite3.a"
	rm -f "$(CONFIG)/bin/sqlite"
	rm -f "$(CONFIG)/bin/libappweb.a"
	rm -f "$(CONFIG)/bin/libmod_esp.a"
	rm -f "$(CONFIG)/bin/esp"
	rm -f "$(CONFIG)/bin/esp.conf"
	rm -f "src/server/esp.conf"
	rm -fr "$(CONFIG)/esp"
	rm -f "$(CONFIG)/bin/libejs.a"
	rm -f "$(CONFIG)/bin/ejs"
	rm -f "$(CONFIG)/bin/ejsc"
	rm -f "$(CONFIG)/bin/libmod_cgi.a"
	rm -f "$(CONFIG)/bin/libmod_ejs.a"
	rm -f "$(CONFIG)/bin/libmod_php.a"
	rm -f "$(CONFIG)/bin/libmod_ssl.a"
	rm -f "$(CONFIG)/bin/authpass"
	rm -f "$(CONFIG)/bin/cgiProgram"
	rm -f "$(CONFIG)/bin/libslink.a"
	rm -f "$(CONFIG)/bin/appweb"
	rm -f "$(CONFIG)/bin/testAppweb"
	rm -f "$(CONFIG)/obj/mprLib.o"
	rm -f "$(CONFIG)/obj/mprSsl.o"
	rm -f "$(CONFIG)/obj/manager.o"
	rm -f "$(CONFIG)/obj/makerom.o"
	rm -f "$(CONFIG)/obj/estLib.o"
	rm -f "$(CONFIG)/obj/pcre.o"
	rm -f "$(CONFIG)/obj/httpLib.o"
	rm -f "$(CONFIG)/obj/http.o"
	rm -f "$(CONFIG)/obj/sqlite3.o"
	rm -f "$(CONFIG)/obj/sqlite.o"
	rm -f "$(CONFIG)/obj/config.o"
	rm -f "$(CONFIG)/obj/convenience.o"
	rm -f "$(CONFIG)/obj/dirHandler.o"
	rm -f "$(CONFIG)/obj/fileHandler.o"
	rm -f "$(CONFIG)/obj/log.o"
	rm -f "$(CONFIG)/obj/server.o"
	rm -f "$(CONFIG)/obj/edi.o"
	rm -f "$(CONFIG)/obj/espAbbrev.o"
	rm -f "$(CONFIG)/obj/espFramework.o"
	rm -f "$(CONFIG)/obj/espHandler.o"
	rm -f "$(CONFIG)/obj/espHtml.o"
	rm -f "$(CONFIG)/obj/espTemplate.o"
	rm -f "$(CONFIG)/obj/mdb.o"
	rm -f "$(CONFIG)/obj/sdb.o"
	rm -f "$(CONFIG)/obj/esp.o"
	rm -f "$(CONFIG)/obj/ejsLib.o"
	rm -f "$(CONFIG)/obj/ejs.o"
	rm -f "$(CONFIG)/obj/ejsc.o"
	rm -f "$(CONFIG)/obj/cgiHandler.o"
	rm -f "$(CONFIG)/obj/ejsHandler.o"
	rm -f "$(CONFIG)/obj/phpHandler.o"
	rm -f "$(CONFIG)/obj/sslModule.o"
	rm -f "$(CONFIG)/obj/authpass.o"
	rm -f "$(CONFIG)/obj/cgiProgram.o"
	rm -f "$(CONFIG)/obj/slink.o"
	rm -f "$(CONFIG)/obj/appweb.o"
	rm -f "$(CONFIG)/obj/testAppweb.o"
	rm -f "$(CONFIG)/obj/testHttp.o"

clobber: clean
	rm -fr ./$(CONFIG)



#
#   version
#
version: $(DEPS_1)
	@echo 4.4.0-0

#
#   mpr.h
#
$(CONFIG)/inc/mpr.h: $(DEPS_2)
	@echo '      [Copy] $(CONFIG)/inc/mpr.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/deps/mpr/mpr.h $(CONFIG)/inc/mpr.h

#
#   bit.h
#
$(CONFIG)/inc/bit.h: $(DEPS_3)
	@echo '      [Copy] $(CONFIG)/inc/bit.h'

#
#   bitos.h
#
DEPS_4 += $(CONFIG)/inc/bit.h

$(CONFIG)/inc/bitos.h: $(DEPS_4)
	@echo '      [Copy] $(CONFIG)/inc/bitos.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/bitos.h $(CONFIG)/inc/bitos.h

#
#   mprLib.o
#
DEPS_5 += $(CONFIG)/inc/bit.h
DEPS_5 += $(CONFIG)/inc/mpr.h
DEPS_5 += $(CONFIG)/inc/bitos.h

$(CONFIG)/obj/mprLib.o: \
    src/deps/mpr/mprLib.c $(DEPS_5)
	@echo '   [Compile] $(CONFIG)/obj/mprLib.o'
	$(CC) -c -o $(CONFIG)/obj/mprLib.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/deps/mpr/mprLib.c

#
#   libmpr
#
DEPS_6 += $(CONFIG)/inc/mpr.h
DEPS_6 += $(CONFIG)/inc/bit.h
DEPS_6 += $(CONFIG)/inc/bitos.h
DEPS_6 += $(CONFIG)/obj/mprLib.o

$(CONFIG)/bin/libmpr.a: $(DEPS_6)
	@echo '      [Link] $(CONFIG)/bin/libmpr.a'
	ar -cr $(CONFIG)/bin/libmpr.a "$(CONFIG)/obj/mprLib.o"

#
#   est.h
#
$(CONFIG)/inc/est.h: $(DEPS_7)
	@echo '      [Copy] $(CONFIG)/inc/est.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/deps/est/est.h $(CONFIG)/inc/est.h

#
#   estLib.o
#
DEPS_8 += $(CONFIG)/inc/bit.h
DEPS_8 += $(CONFIG)/inc/est.h
DEPS_8 += $(CONFIG)/inc/bitos.h

$(CONFIG)/obj/estLib.o: \
    src/deps/est/estLib.c $(DEPS_8)
	@echo '   [Compile] $(CONFIG)/obj/estLib.o'
	$(CC) -c -o $(CONFIG)/obj/estLib.o -O2 -fPIC $(DFLAGS) "$(IFLAGS)" src/deps/est/estLib.c

ifeq ($(BIT_PACK_EST),1)
#
#   libest
#
DEPS_9 += $(CONFIG)/inc/est.h
DEPS_9 += $(CONFIG)/inc/bit.h
DEPS_9 += $(CONFIG)/inc/bitos.h
DEPS_9 += $(CONFIG)/obj/estLib.o

$(CONFIG)/bin/libest.a: $(DEPS_9)
	@echo '      [Link] $(CONFIG)/bin/libest.a'
	ar -cr $(CONFIG)/bin/libest.a "$(CONFIG)/obj/estLib.o"
endif

#
#   mprSsl.o
#
DEPS_10 += $(CONFIG)/inc/bit.h
DEPS_10 += $(CONFIG)/inc/mpr.h
DEPS_10 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/mprSsl.o: \
    src/deps/mpr/mprSsl.c $(DEPS_10)
	@echo '   [Compile] $(CONFIG)/obj/mprSsl.o'
	$(CC) -c -o $(CONFIG)/obj/mprSsl.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" "-I$(BIT_PACK_MATRIXSSL_PATH)" "-I$(BIT_PACK_MATRIXSSL_PATH)/matrixssl" "-I$(BIT_PACK_NANOSSL_PATH)/src" "-I$(BIT_PACK_OPENSSL_PATH)/include" src/deps/mpr/mprSsl.c

#
#   libmprssl
#
DEPS_11 += $(CONFIG)/inc/mpr.h
DEPS_11 += $(CONFIG)/inc/bit.h
DEPS_11 += $(CONFIG)/inc/bitos.h
DEPS_11 += $(CONFIG)/obj/mprLib.o
DEPS_11 += $(CONFIG)/bin/libmpr.a
DEPS_11 += $(CONFIG)/inc/est.h
DEPS_11 += $(CONFIG)/obj/estLib.o
ifeq ($(BIT_PACK_EST),1)
    DEPS_11 += $(CONFIG)/bin/libest.a
endif
DEPS_11 += $(CONFIG)/obj/mprSsl.o

$(CONFIG)/bin/libmprssl.a: $(DEPS_11)
	@echo '      [Link] $(CONFIG)/bin/libmprssl.a'
	ar -cr $(CONFIG)/bin/libmprssl.a "$(CONFIG)/obj/mprSsl.o"

#
#   manager.o
#
DEPS_12 += $(CONFIG)/inc/bit.h
DEPS_12 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/manager.o: \
    src/deps/mpr/manager.c $(DEPS_12)
	@echo '   [Compile] $(CONFIG)/obj/manager.o'
	$(CC) -c -o $(CONFIG)/obj/manager.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/deps/mpr/manager.c

#
#   manager
#
DEPS_13 += $(CONFIG)/inc/mpr.h
DEPS_13 += $(CONFIG)/inc/bit.h
DEPS_13 += $(CONFIG)/inc/bitos.h
DEPS_13 += $(CONFIG)/obj/mprLib.o
DEPS_13 += $(CONFIG)/bin/libmpr.a
DEPS_13 += $(CONFIG)/obj/manager.o

LIBS_13 += -lmpr

$(CONFIG)/bin/appman: $(DEPS_13)
	@echo '      [Link] $(CONFIG)/bin/appman'
	$(CC) -o $(CONFIG)/bin/appman $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/manager.o" $(LIBPATHS_13) $(LIBS_13) $(LIBS_13) $(LIBS) $(LIBS) 

#
#   makerom.o
#
DEPS_14 += $(CONFIG)/inc/bit.h
DEPS_14 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/makerom.o: \
    src/deps/mpr/makerom.c $(DEPS_14)
	@echo '   [Compile] $(CONFIG)/obj/makerom.o'
	$(CC) -c -o $(CONFIG)/obj/makerom.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/deps/mpr/makerom.c

#
#   makerom
#
DEPS_15 += $(CONFIG)/inc/mpr.h
DEPS_15 += $(CONFIG)/inc/bit.h
DEPS_15 += $(CONFIG)/inc/bitos.h
DEPS_15 += $(CONFIG)/obj/mprLib.o
DEPS_15 += $(CONFIG)/bin/libmpr.a
DEPS_15 += $(CONFIG)/obj/makerom.o

LIBS_15 += -lmpr

$(CONFIG)/bin/makerom: $(DEPS_15)
	@echo '      [Link] $(CONFIG)/bin/makerom'
	$(CC) -o $(CONFIG)/bin/makerom $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/makerom.o" $(LIBPATHS_15) $(LIBS_15) $(LIBS_15) $(LIBS) $(LIBS) 

#
#   ca-crt
#
DEPS_16 += src/deps/est/ca.crt

$(CONFIG)/bin/ca.crt: $(DEPS_16)
	@echo '      [Copy] $(CONFIG)/bin/ca.crt'
	mkdir -p "$(CONFIG)/bin"
	cp src/deps/est/ca.crt $(CONFIG)/bin/ca.crt

#
#   pcre.h
#
$(CONFIG)/inc/pcre.h: $(DEPS_17)
	@echo '      [Copy] $(CONFIG)/inc/pcre.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/deps/pcre/pcre.h $(CONFIG)/inc/pcre.h

#
#   pcre.o
#
DEPS_18 += $(CONFIG)/inc/bit.h
DEPS_18 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/pcre.o: \
    src/deps/pcre/pcre.c $(DEPS_18)
	@echo '   [Compile] $(CONFIG)/obj/pcre.o'
	$(CC) -c -o $(CONFIG)/obj/pcre.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/deps/pcre/pcre.c

ifeq ($(BIT_PACK_PCRE),1)
#
#   libpcre
#
DEPS_19 += $(CONFIG)/inc/pcre.h
DEPS_19 += $(CONFIG)/inc/bit.h
DEPS_19 += $(CONFIG)/obj/pcre.o

$(CONFIG)/bin/libpcre.a: $(DEPS_19)
	@echo '      [Link] $(CONFIG)/bin/libpcre.a'
	ar -cr $(CONFIG)/bin/libpcre.a "$(CONFIG)/obj/pcre.o"
endif

#
#   http.h
#
$(CONFIG)/inc/http.h: $(DEPS_20)
	@echo '      [Copy] $(CONFIG)/inc/http.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/deps/http/http.h $(CONFIG)/inc/http.h

#
#   httpLib.o
#
DEPS_21 += $(CONFIG)/inc/bit.h
DEPS_21 += $(CONFIG)/inc/http.h
DEPS_21 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/httpLib.o: \
    src/deps/http/httpLib.c $(DEPS_21)
	@echo '   [Compile] $(CONFIG)/obj/httpLib.o'
	$(CC) -c -o $(CONFIG)/obj/httpLib.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/deps/http/httpLib.c

#
#   libhttp
#
DEPS_22 += $(CONFIG)/inc/mpr.h
DEPS_22 += $(CONFIG)/inc/bit.h
DEPS_22 += $(CONFIG)/inc/bitos.h
DEPS_22 += $(CONFIG)/obj/mprLib.o
DEPS_22 += $(CONFIG)/bin/libmpr.a
DEPS_22 += $(CONFIG)/inc/pcre.h
DEPS_22 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_22 += $(CONFIG)/bin/libpcre.a
endif
DEPS_22 += $(CONFIG)/inc/http.h
DEPS_22 += $(CONFIG)/obj/httpLib.o

$(CONFIG)/bin/libhttp.a: $(DEPS_22)
	@echo '      [Link] $(CONFIG)/bin/libhttp.a'
	ar -cr $(CONFIG)/bin/libhttp.a "$(CONFIG)/obj/httpLib.o"

#
#   http.o
#
DEPS_23 += $(CONFIG)/inc/bit.h
DEPS_23 += $(CONFIG)/inc/http.h

$(CONFIG)/obj/http.o: \
    src/deps/http/http.c $(DEPS_23)
	@echo '   [Compile] $(CONFIG)/obj/http.o'
	$(CC) -c -o $(CONFIG)/obj/http.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" "-I$(BIT_PACK_MATRIXSSL_PATH)" "-I$(BIT_PACK_MATRIXSSL_PATH)/matrixssl" "-I$(BIT_PACK_NANOSSL_PATH)/src" "-I$(BIT_PACK_OPENSSL_PATH)/include" src/deps/http/http.c

#
#   http
#
DEPS_24 += $(CONFIG)/inc/mpr.h
DEPS_24 += $(CONFIG)/inc/bit.h
DEPS_24 += $(CONFIG)/inc/bitos.h
DEPS_24 += $(CONFIG)/obj/mprLib.o
DEPS_24 += $(CONFIG)/bin/libmpr.a
DEPS_24 += $(CONFIG)/inc/pcre.h
DEPS_24 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_24 += $(CONFIG)/bin/libpcre.a
endif
DEPS_24 += $(CONFIG)/inc/http.h
DEPS_24 += $(CONFIG)/obj/httpLib.o
DEPS_24 += $(CONFIG)/bin/libhttp.a
DEPS_24 += $(CONFIG)/inc/est.h
DEPS_24 += $(CONFIG)/obj/estLib.o
ifeq ($(BIT_PACK_EST),1)
    DEPS_24 += $(CONFIG)/bin/libest.a
endif
DEPS_24 += $(CONFIG)/obj/mprSsl.o
DEPS_24 += $(CONFIG)/bin/libmprssl.a
DEPS_24 += $(CONFIG)/obj/http.o

LIBS_24 += -lhttp
LIBS_24 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_24 += -lpcre
endif
LIBS_24 += -lmprssl
ifeq ($(BIT_PACK_EST),1)
    LIBS_24 += -lest
endif
ifeq ($(BIT_PACK_MATRIXSSL),1)
    LIBS_24 += -lmatrixssl
    LIBPATHS_24 += -L$(BIT_PACK_MATRIXSSL_PATH)
endif
ifeq ($(BIT_PACK_NANOSSL),1)
    LIBS_24 += -lssls
    LIBPATHS_24 += -L$(BIT_PACK_NANOSSL_PATH)/bin
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_24 += -lssl
    LIBPATHS_24 += -L$(BIT_PACK_OPENSSL_PATH)
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_24 += -lcrypto
    LIBPATHS_24 += -L$(BIT_PACK_OPENSSL_PATH)
endif

$(CONFIG)/bin/http: $(DEPS_24)
	@echo '      [Link] $(CONFIG)/bin/http'
	$(CC) -o $(CONFIG)/bin/http $(LDFLAGS) $(LIBPATHS)    "$(CONFIG)/obj/http.o" $(LIBPATHS_24) $(LIBS_24) $(LIBS_24) $(LIBS) $(LIBS) 

#
#   sqlite3.h
#
$(CONFIG)/inc/sqlite3.h: $(DEPS_25)
	@echo '      [Copy] $(CONFIG)/inc/sqlite3.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/deps/sqlite/sqlite3.h $(CONFIG)/inc/sqlite3.h

#
#   sqlite3.o
#
DEPS_26 += $(CONFIG)/inc/bit.h
DEPS_26 += $(CONFIG)/inc/sqlite3.h

$(CONFIG)/obj/sqlite3.o: \
    src/deps/sqlite/sqlite3.c $(DEPS_26)
	@echo '   [Compile] $(CONFIG)/obj/sqlite3.o'
	$(CC) -c -o $(CONFIG)/obj/sqlite3.o -O2 -fPIC $(DFLAGS) "$(IFLAGS)" src/deps/sqlite/sqlite3.c

ifeq ($(BIT_PACK_SQLITE),1)
#
#   libsqlite3
#
DEPS_27 += $(CONFIG)/inc/sqlite3.h
DEPS_27 += $(CONFIG)/inc/bit.h
DEPS_27 += $(CONFIG)/obj/sqlite3.o

$(CONFIG)/bin/libsqlite3.a: $(DEPS_27)
	@echo '      [Link] $(CONFIG)/bin/libsqlite3.a'
	ar -cr $(CONFIG)/bin/libsqlite3.a "$(CONFIG)/obj/sqlite3.o"
endif

#
#   sqlite.o
#
DEPS_28 += $(CONFIG)/inc/bit.h
DEPS_28 += $(CONFIG)/inc/sqlite3.h

$(CONFIG)/obj/sqlite.o: \
    src/deps/sqlite/sqlite.c $(DEPS_28)
	@echo '   [Compile] $(CONFIG)/obj/sqlite.o'
	$(CC) -c -o $(CONFIG)/obj/sqlite.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/deps/sqlite/sqlite.c

ifeq ($(BIT_PACK_SQLITE),1)
#
#   sqliteshell
#
DEPS_29 += $(CONFIG)/inc/sqlite3.h
DEPS_29 += $(CONFIG)/inc/bit.h
DEPS_29 += $(CONFIG)/obj/sqlite3.o
DEPS_29 += $(CONFIG)/bin/libsqlite3.a
DEPS_29 += $(CONFIG)/obj/sqlite.o

LIBS_29 += -lsqlite3

$(CONFIG)/bin/sqlite: $(DEPS_29)
	@echo '      [Link] $(CONFIG)/bin/sqlite'
	$(CC) -o $(CONFIG)/bin/sqlite $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/sqlite.o" $(LIBPATHS_29) $(LIBS_29) $(LIBS_29) $(LIBS) $(LIBS) 
endif

#
#   appweb.h
#
$(CONFIG)/inc/appweb.h: $(DEPS_30)
	@echo '      [Copy] $(CONFIG)/inc/appweb.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/appweb.h $(CONFIG)/inc/appweb.h

#
#   customize.h
#
$(CONFIG)/inc/customize.h: $(DEPS_31)
	@echo '      [Copy] $(CONFIG)/inc/customize.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/customize.h $(CONFIG)/inc/customize.h

#
#   config.o
#
DEPS_32 += $(CONFIG)/inc/bit.h
DEPS_32 += $(CONFIG)/inc/appweb.h
DEPS_32 += $(CONFIG)/inc/pcre.h
DEPS_32 += $(CONFIG)/inc/mpr.h
DEPS_32 += $(CONFIG)/inc/http.h
DEPS_32 += $(CONFIG)/inc/customize.h

$(CONFIG)/obj/config.o: \
    src/config.c $(DEPS_32)
	@echo '   [Compile] $(CONFIG)/obj/config.o'
	$(CC) -c -o $(CONFIG)/obj/config.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/config.c

#
#   convenience.o
#
DEPS_33 += $(CONFIG)/inc/bit.h
DEPS_33 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/convenience.o: \
    src/convenience.c $(DEPS_33)
	@echo '   [Compile] $(CONFIG)/obj/convenience.o'
	$(CC) -c -o $(CONFIG)/obj/convenience.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/convenience.c

#
#   dirHandler.o
#
DEPS_34 += $(CONFIG)/inc/bit.h
DEPS_34 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/dirHandler.o: \
    src/dirHandler.c $(DEPS_34)
	@echo '   [Compile] $(CONFIG)/obj/dirHandler.o'
	$(CC) -c -o $(CONFIG)/obj/dirHandler.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/dirHandler.c

#
#   fileHandler.o
#
DEPS_35 += $(CONFIG)/inc/bit.h
DEPS_35 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/fileHandler.o: \
    src/fileHandler.c $(DEPS_35)
	@echo '   [Compile] $(CONFIG)/obj/fileHandler.o'
	$(CC) -c -o $(CONFIG)/obj/fileHandler.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/fileHandler.c

#
#   log.o
#
DEPS_36 += $(CONFIG)/inc/bit.h
DEPS_36 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/log.o: \
    src/log.c $(DEPS_36)
	@echo '   [Compile] $(CONFIG)/obj/log.o'
	$(CC) -c -o $(CONFIG)/obj/log.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/log.c

#
#   server.o
#
DEPS_37 += $(CONFIG)/inc/bit.h
DEPS_37 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/server.o: \
    src/server.c $(DEPS_37)
	@echo '   [Compile] $(CONFIG)/obj/server.o'
	$(CC) -c -o $(CONFIG)/obj/server.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/server.c

#
#   libappweb
#
DEPS_38 += $(CONFIG)/inc/mpr.h
DEPS_38 += $(CONFIG)/inc/bit.h
DEPS_38 += $(CONFIG)/inc/bitos.h
DEPS_38 += $(CONFIG)/obj/mprLib.o
DEPS_38 += $(CONFIG)/bin/libmpr.a
DEPS_38 += $(CONFIG)/inc/pcre.h
DEPS_38 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_38 += $(CONFIG)/bin/libpcre.a
endif
DEPS_38 += $(CONFIG)/inc/http.h
DEPS_38 += $(CONFIG)/obj/httpLib.o
DEPS_38 += $(CONFIG)/bin/libhttp.a
DEPS_38 += $(CONFIG)/inc/appweb.h
DEPS_38 += $(CONFIG)/inc/customize.h
DEPS_38 += $(CONFIG)/obj/config.o
DEPS_38 += $(CONFIG)/obj/convenience.o
DEPS_38 += $(CONFIG)/obj/dirHandler.o
DEPS_38 += $(CONFIG)/obj/fileHandler.o
DEPS_38 += $(CONFIG)/obj/log.o
DEPS_38 += $(CONFIG)/obj/server.o

$(CONFIG)/bin/libappweb.a: $(DEPS_38)
	@echo '      [Link] $(CONFIG)/bin/libappweb.a'
	ar -cr $(CONFIG)/bin/libappweb.a "$(CONFIG)/obj/config.o" "$(CONFIG)/obj/convenience.o" "$(CONFIG)/obj/dirHandler.o" "$(CONFIG)/obj/fileHandler.o" "$(CONFIG)/obj/log.o" "$(CONFIG)/obj/server.o"

#
#   edi.h
#
$(CONFIG)/inc/edi.h: $(DEPS_39)
	@echo '      [Copy] $(CONFIG)/inc/edi.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/esp/edi.h $(CONFIG)/inc/edi.h

#
#   esp.h
#
$(CONFIG)/inc/esp.h: $(DEPS_40)
	@echo '      [Copy] $(CONFIG)/inc/esp.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/esp/esp.h $(CONFIG)/inc/esp.h

#
#   mdb.h
#
$(CONFIG)/inc/mdb.h: $(DEPS_41)
	@echo '      [Copy] $(CONFIG)/inc/mdb.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/esp/mdb.h $(CONFIG)/inc/mdb.h

#
#   edi.o
#
DEPS_42 += $(CONFIG)/inc/bit.h
DEPS_42 += $(CONFIG)/inc/edi.h
DEPS_42 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/edi.o: \
    src/esp/edi.c $(DEPS_42)
	@echo '   [Compile] $(CONFIG)/obj/edi.o'
	$(CC) -c -o $(CONFIG)/obj/edi.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/esp/edi.c

#
#   espAbbrev.o
#
DEPS_43 += $(CONFIG)/inc/bit.h
DEPS_43 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/espAbbrev.o: \
    src/esp/espAbbrev.c $(DEPS_43)
	@echo '   [Compile] $(CONFIG)/obj/espAbbrev.o'
	$(CC) -c -o $(CONFIG)/obj/espAbbrev.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/esp/espAbbrev.c

#
#   espFramework.o
#
DEPS_44 += $(CONFIG)/inc/bit.h
DEPS_44 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/espFramework.o: \
    src/esp/espFramework.c $(DEPS_44)
	@echo '   [Compile] $(CONFIG)/obj/espFramework.o'
	$(CC) -c -o $(CONFIG)/obj/espFramework.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/esp/espFramework.c

#
#   espHandler.o
#
DEPS_45 += $(CONFIG)/inc/bit.h
DEPS_45 += $(CONFIG)/inc/appweb.h
DEPS_45 += $(CONFIG)/inc/esp.h
DEPS_45 += $(CONFIG)/inc/edi.h

$(CONFIG)/obj/espHandler.o: \
    src/esp/espHandler.c $(DEPS_45)
	@echo '   [Compile] $(CONFIG)/obj/espHandler.o'
	$(CC) -c -o $(CONFIG)/obj/espHandler.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/esp/espHandler.c

#
#   espHtml.o
#
DEPS_46 += $(CONFIG)/inc/bit.h
DEPS_46 += $(CONFIG)/inc/esp.h
DEPS_46 += $(CONFIG)/inc/edi.h

$(CONFIG)/obj/espHtml.o: \
    src/esp/espHtml.c $(DEPS_46)
	@echo '   [Compile] $(CONFIG)/obj/espHtml.o'
	$(CC) -c -o $(CONFIG)/obj/espHtml.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/esp/espHtml.c

#
#   espTemplate.o
#
DEPS_47 += $(CONFIG)/inc/bit.h
DEPS_47 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/espTemplate.o: \
    src/esp/espTemplate.c $(DEPS_47)
	@echo '   [Compile] $(CONFIG)/obj/espTemplate.o'
	$(CC) -c -o $(CONFIG)/obj/espTemplate.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/esp/espTemplate.c

#
#   mdb.o
#
DEPS_48 += $(CONFIG)/inc/bit.h
DEPS_48 += $(CONFIG)/inc/appweb.h
DEPS_48 += $(CONFIG)/inc/edi.h
DEPS_48 += $(CONFIG)/inc/mdb.h
DEPS_48 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/mdb.o: \
    src/esp/mdb.c $(DEPS_48)
	@echo '   [Compile] $(CONFIG)/obj/mdb.o'
	$(CC) -c -o $(CONFIG)/obj/mdb.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/esp/mdb.c

#
#   sdb.o
#
DEPS_49 += $(CONFIG)/inc/bit.h
DEPS_49 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/sdb.o: \
    src/esp/sdb.c $(DEPS_49)
	@echo '   [Compile] $(CONFIG)/obj/sdb.o'
	$(CC) -c -o $(CONFIG)/obj/sdb.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/esp/sdb.c

ifeq ($(BIT_PACK_ESP),1)
#
#   libmod_esp
#
DEPS_50 += $(CONFIG)/inc/mpr.h
DEPS_50 += $(CONFIG)/inc/bit.h
DEPS_50 += $(CONFIG)/inc/bitos.h
DEPS_50 += $(CONFIG)/obj/mprLib.o
DEPS_50 += $(CONFIG)/bin/libmpr.a
DEPS_50 += $(CONFIG)/inc/pcre.h
DEPS_50 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_50 += $(CONFIG)/bin/libpcre.a
endif
DEPS_50 += $(CONFIG)/inc/http.h
DEPS_50 += $(CONFIG)/obj/httpLib.o
DEPS_50 += $(CONFIG)/bin/libhttp.a
DEPS_50 += $(CONFIG)/inc/appweb.h
DEPS_50 += $(CONFIG)/inc/customize.h
DEPS_50 += $(CONFIG)/obj/config.o
DEPS_50 += $(CONFIG)/obj/convenience.o
DEPS_50 += $(CONFIG)/obj/dirHandler.o
DEPS_50 += $(CONFIG)/obj/fileHandler.o
DEPS_50 += $(CONFIG)/obj/log.o
DEPS_50 += $(CONFIG)/obj/server.o
DEPS_50 += $(CONFIG)/bin/libappweb.a
DEPS_50 += $(CONFIG)/inc/edi.h
DEPS_50 += $(CONFIG)/inc/esp.h
DEPS_50 += $(CONFIG)/inc/mdb.h
DEPS_50 += $(CONFIG)/obj/edi.o
DEPS_50 += $(CONFIG)/obj/espAbbrev.o
DEPS_50 += $(CONFIG)/obj/espFramework.o
DEPS_50 += $(CONFIG)/obj/espHandler.o
DEPS_50 += $(CONFIG)/obj/espHtml.o
DEPS_50 += $(CONFIG)/obj/espTemplate.o
DEPS_50 += $(CONFIG)/obj/mdb.o
DEPS_50 += $(CONFIG)/obj/sdb.o

$(CONFIG)/bin/libmod_esp.a: $(DEPS_50)
	@echo '      [Link] $(CONFIG)/bin/libmod_esp.a'
	ar -cr $(CONFIG)/bin/libmod_esp.a "$(CONFIG)/obj/edi.o" "$(CONFIG)/obj/espAbbrev.o" "$(CONFIG)/obj/espFramework.o" "$(CONFIG)/obj/espHandler.o" "$(CONFIG)/obj/espHtml.o" "$(CONFIG)/obj/espTemplate.o" "$(CONFIG)/obj/mdb.o" "$(CONFIG)/obj/sdb.o"
endif

#
#   esp.o
#
DEPS_51 += $(CONFIG)/inc/bit.h
DEPS_51 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/esp.o: \
    src/esp/esp.c $(DEPS_51)
	@echo '   [Compile] $(CONFIG)/obj/esp.o'
	$(CC) -c -o $(CONFIG)/obj/esp.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/esp/esp.c

ifeq ($(BIT_PACK_ESP),1)
#
#   espcmd
#
DEPS_52 += $(CONFIG)/inc/mpr.h
DEPS_52 += $(CONFIG)/inc/bit.h
DEPS_52 += $(CONFIG)/inc/bitos.h
DEPS_52 += $(CONFIG)/obj/mprLib.o
DEPS_52 += $(CONFIG)/bin/libmpr.a
DEPS_52 += $(CONFIG)/inc/pcre.h
DEPS_52 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_52 += $(CONFIG)/bin/libpcre.a
endif
DEPS_52 += $(CONFIG)/inc/http.h
DEPS_52 += $(CONFIG)/obj/httpLib.o
DEPS_52 += $(CONFIG)/bin/libhttp.a
DEPS_52 += $(CONFIG)/inc/appweb.h
DEPS_52 += $(CONFIG)/inc/customize.h
DEPS_52 += $(CONFIG)/obj/config.o
DEPS_52 += $(CONFIG)/obj/convenience.o
DEPS_52 += $(CONFIG)/obj/dirHandler.o
DEPS_52 += $(CONFIG)/obj/fileHandler.o
DEPS_52 += $(CONFIG)/obj/log.o
DEPS_52 += $(CONFIG)/obj/server.o
DEPS_52 += $(CONFIG)/bin/libappweb.a
DEPS_52 += $(CONFIG)/inc/edi.h
DEPS_52 += $(CONFIG)/inc/esp.h
DEPS_52 += $(CONFIG)/inc/mdb.h
DEPS_52 += $(CONFIG)/obj/edi.o
DEPS_52 += $(CONFIG)/obj/espAbbrev.o
DEPS_52 += $(CONFIG)/obj/espFramework.o
DEPS_52 += $(CONFIG)/obj/espHandler.o
DEPS_52 += $(CONFIG)/obj/espHtml.o
DEPS_52 += $(CONFIG)/obj/espTemplate.o
DEPS_52 += $(CONFIG)/obj/mdb.o
DEPS_52 += $(CONFIG)/obj/sdb.o
DEPS_52 += $(CONFIG)/bin/libmod_esp.a
DEPS_52 += $(CONFIG)/obj/esp.o

LIBS_52 += -lappweb
LIBS_52 += -lhttp
LIBS_52 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_52 += -lpcre
endif
ifeq ($(BIT_PACK_SQLITE),1)
    LIBS_52 += -lsqlite3
endif
LIBS_52 += -lmod_esp

$(CONFIG)/bin/esp: $(DEPS_52)
	@echo '      [Link] $(CONFIG)/bin/esp'
	$(CC) -o $(CONFIG)/bin/esp $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/edi.o" "$(CONFIG)/obj/esp.o" "$(CONFIG)/obj/espAbbrev.o" "$(CONFIG)/obj/espFramework.o" "$(CONFIG)/obj/espHandler.o" "$(CONFIG)/obj/espHtml.o" "$(CONFIG)/obj/espTemplate.o" "$(CONFIG)/obj/mdb.o" "$(CONFIG)/obj/sdb.o" $(LIBPATHS_52) $(LIBS_52) $(LIBS_52) $(LIBS) $(LIBS) 
endif

ifeq ($(BIT_PACK_ESP),1)
#
#   esp.conf
#
DEPS_53 += src/esp/esp.conf

$(CONFIG)/bin/esp.conf: $(DEPS_53)
	@echo '      [Copy] $(CONFIG)/bin/esp.conf'
	mkdir -p "$(CONFIG)/bin"
	cp src/esp/esp.conf $(CONFIG)/bin/esp.conf
endif

ifeq ($(BIT_PACK_ESP),1)
#
#   esp.conf.server
#
DEPS_54 += src/esp/esp.conf

src/server/esp.conf: $(DEPS_54)
	@echo '      [Copy] src/server/esp.conf'
	mkdir -p "src/server"
	cp src/esp/esp.conf src/server/esp.conf
endif

ifeq ($(BIT_PACK_ESP),1)
#
#   proto
#
DEPS_55 += src/esp/proto

$(CONFIG)/esp: $(DEPS_55)
	@echo '      [Copy] $(CONFIG)/esp'
	mkdir -p "$(CONFIG)/esp/components/angular/client/lib/angular"
	cp src/esp/proto/components/angular/client/lib/angular/angular-animate.js $(CONFIG)/esp/components/angular/client/lib/angular/angular-animate.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-bootstrap-prettify.js $(CONFIG)/esp/components/angular/client/lib/angular/angular-bootstrap-prettify.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-bootstrap.js $(CONFIG)/esp/components/angular/client/lib/angular/angular-bootstrap.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-cookies.js $(CONFIG)/esp/components/angular/client/lib/angular/angular-cookies.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-loader.js $(CONFIG)/esp/components/angular/client/lib/angular/angular-loader.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-mocks.js $(CONFIG)/esp/components/angular/client/lib/angular/angular-mocks.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-resource.js $(CONFIG)/esp/components/angular/client/lib/angular/angular-resource.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-route.js $(CONFIG)/esp/components/angular/client/lib/angular/angular-route.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-sanitize.js $(CONFIG)/esp/components/angular/client/lib/angular/angular-sanitize.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-scenario.js $(CONFIG)/esp/components/angular/client/lib/angular/angular-scenario.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-touch.js $(CONFIG)/esp/components/angular/client/lib/angular/angular-touch.js
	cp src/esp/proto/components/angular/client/lib/angular/angular.js $(CONFIG)/esp/components/angular/client/lib/angular/angular.js
	cp src/esp/proto/components/angular/client/lib/angular/errors.json $(CONFIG)/esp/components/angular/client/lib/angular/errors.json
	cp src/esp/proto/components/angular/client/lib/angular/version.json $(CONFIG)/esp/components/angular/client/lib/angular/version.json
	cp src/esp/proto/components/angular/client/lib/angular/version.txt $(CONFIG)/esp/components/angular/client/lib/angular/version.txt
	mkdir -p "$(CONFIG)/esp/components/angular"
	cp src/esp/proto/components/angular/config.json $(CONFIG)/esp/components/angular/config.json
	mkdir -p "$(CONFIG)/esp/components/angular-esp/client/lib/angular-esp/ext"
	cp src/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-field-errors.js $(CONFIG)/esp/components/angular-esp/client/lib/angular-esp/ext/esp-field-errors.js
	cp src/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-format.js $(CONFIG)/esp/components/angular-esp/client/lib/angular-esp/ext/esp-format.js
	cp src/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-input-group.js $(CONFIG)/esp/components/angular-esp/client/lib/angular-esp/ext/esp-input-group.js
	cp src/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-input.js $(CONFIG)/esp/components/angular-esp/client/lib/angular-esp/ext/esp-input.js
	cp src/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-titlecase.js $(CONFIG)/esp/components/angular-esp/client/lib/angular-esp/ext/esp-titlecase.js
	cp src/esp/proto/components/angular-esp/client/lib/angular-esp/ext/Esp.js $(CONFIG)/esp/components/angular-esp/client/lib/angular-esp/ext/Esp.js
	mkdir -p "$(CONFIG)/esp/components/angular-esp"
	cp src/esp/proto/components/angular-esp/config.json $(CONFIG)/esp/components/angular-esp/config.json
	mkdir -p "$(CONFIG)/esp/components/angular-extras"
	cp src/esp/proto/components/angular-extras/config.json $(CONFIG)/esp/components/angular-extras/config.json
	cp src/esp/proto/components/angular-extras/misc.js $(CONFIG)/esp/components/angular-extras/misc.js
	mkdir -p "$(CONFIG)/esp/components/angular-local/client/lib/angular-local/ext"
	cp src/esp/proto/components/angular-local/client/lib/angular-local/ext/LocalStore.js $(CONFIG)/esp/components/angular-local/client/lib/angular-local/ext/LocalStore.js
	mkdir -p "$(CONFIG)/esp/components/angular-local"
	cp src/esp/proto/components/angular-local/config.json $(CONFIG)/esp/components/angular-local/config.json
	mkdir -p "$(CONFIG)/esp/components/angular-mvc/client/app"
	cp src/esp/proto/components/angular-mvc/client/app/main.js $(CONFIG)/esp/components/angular-mvc/client/app/main.js
	mkdir -p "$(CONFIG)/esp/components/angular-mvc/client/css"
	cp src/esp/proto/components/angular-mvc/client/css/all.less $(CONFIG)/esp/components/angular-mvc/client/css/all.less
	cp src/esp/proto/components/angular-mvc/client/css/app.less $(CONFIG)/esp/components/angular-mvc/client/css/app.less
	cp src/esp/proto/components/angular-mvc/client/css/fix.css $(CONFIG)/esp/components/angular-mvc/client/css/fix.css
	cp src/esp/proto/components/angular-mvc/client/css/theme.less $(CONFIG)/esp/components/angular-mvc/client/css/theme.less
	mkdir -p "$(CONFIG)/esp/components/angular-mvc/client"
	cp src/esp/proto/components/angular-mvc/client/index.esp $(CONFIG)/esp/components/angular-mvc/client/index.esp
	mkdir -p "$(CONFIG)/esp/components/angular-mvc/client/pages"
	cp src/esp/proto/components/angular-mvc/client/pages/splash.html $(CONFIG)/esp/components/angular-mvc/client/pages/splash.html
	mkdir -p "$(CONFIG)/esp/components/angular-mvc"
	cp src/esp/proto/components/angular-mvc/config.json $(CONFIG)/esp/components/angular-mvc/config.json
	cp src/esp/proto/components/angular-mvc/start.bit $(CONFIG)/esp/components/angular-mvc/start.bit
	mkdir -p "$(CONFIG)/esp/components/angular-session/client/lib/angular-session/ext"
	cp src/esp/proto/components/angular-session/client/lib/angular-session/ext/SessionStore.js $(CONFIG)/esp/components/angular-session/client/lib/angular-session/ext/SessionStore.js
	mkdir -p "$(CONFIG)/esp/components/angular-session"
	cp src/esp/proto/components/angular-session/config.json $(CONFIG)/esp/components/angular-session/config.json
	mkdir -p "$(CONFIG)/esp/components/angular-ui-bootstrap/client/lib/angular-ui-bootstrap"
	cp src/esp/proto/components/angular-ui-bootstrap/client/lib/angular-ui-bootstrap/ui-bootstrap-tpls.js $(CONFIG)/esp/components/angular-ui-bootstrap/client/lib/angular-ui-bootstrap/ui-bootstrap-tpls.js
	mkdir -p "$(CONFIG)/esp/components/angular-ui-bootstrap"
	cp src/esp/proto/components/angular-ui-bootstrap/config.json $(CONFIG)/esp/components/angular-ui-bootstrap/config.json
	mkdir -p "$(CONFIG)/esp/components/animate/client/css"
	cp src/esp/proto/components/animate/client/css/animate.css $(CONFIG)/esp/components/animate/client/css/animate.css
	mkdir -p "$(CONFIG)/esp/components/animate"
	cp src/esp/proto/components/animate/config.json $(CONFIG)/esp/components/animate/config.json
	mkdir -p "$(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/css"
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/css/bootstrap-theme.css $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/css/bootstrap-theme.css
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/css/bootstrap-theme.min.css $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/css/bootstrap-theme.min.css
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/css/bootstrap.css $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/css/bootstrap.css
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/css/bootstrap.min.css $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/css/bootstrap.min.css
	mkdir -p "$(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/fonts"
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.eot $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.eot
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.svg $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.svg
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.ttf $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.ttf
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.woff $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.woff
	mkdir -p "$(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/js"
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/js/bootstrap.js $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/js/bootstrap.js
	mkdir -p "$(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less"
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/alerts.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/alerts.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/badges.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/badges.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/bootstrap.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/bootstrap.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/breadcrumbs.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/breadcrumbs.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/button-groups.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/button-groups.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/buttons.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/buttons.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/carousel.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/carousel.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/close.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/close.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/code.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/code.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/component-animations.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/component-animations.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/dropdowns.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/dropdowns.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/forms.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/forms.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/glyphicons.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/glyphicons.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/grid.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/grid.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/input-groups.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/input-groups.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/jumbotron.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/jumbotron.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/labels.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/labels.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/list-group.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/list-group.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/media.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/media.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/mixins.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/mixins.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/modals.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/modals.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/navbar.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/navbar.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/navs.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/navs.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/normalize.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/normalize.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/pager.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/pager.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/pagination.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/pagination.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/panels.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/panels.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/popovers.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/popovers.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/print.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/print.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/progress-bars.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/progress-bars.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/responsive-utilities.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/responsive-utilities.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/scaffolding.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/scaffolding.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/tables.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/tables.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/theme.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/theme.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/thumbnails.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/thumbnails.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/tooltip.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/tooltip.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/type.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/type.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/utilities.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/utilities.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/variables.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/variables.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/wells.less $(CONFIG)/esp/components/bootstrap/client/lib/bootstrap/less/wells.less
	mkdir -p "$(CONFIG)/esp/components/bootstrap"
	cp src/esp/proto/components/bootstrap/config.json $(CONFIG)/esp/components/bootstrap/config.json
	mkdir -p "$(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/css"
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/css/font-awesome-ie7.css $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/css/font-awesome-ie7.css
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/css/font-awesome-ie7.min.css $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/css/font-awesome-ie7.min.css
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/css/font-awesome.css $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/css/font-awesome.css
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/css/font-awesome.min.css $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/css/font-awesome.min.css
	mkdir -p "$(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/font"
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.eot $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.eot
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.svg $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.svg
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.ttf $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.ttf
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.woff $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.woff
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/font/FontAwesome.otf $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/font/FontAwesome.otf
	mkdir -p "$(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/less"
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/bootstrap.less $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/less/bootstrap.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/core.less $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/less/core.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/extras.less $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/less/extras.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/font-awesome-ie7.less $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/less/font-awesome-ie7.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/font-awesome.less $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/less/font-awesome.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/icons.less $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/less/icons.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/mixins.less $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/less/mixins.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/path.less $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/less/path.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/variables.less $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/less/variables.less
	mkdir -p "$(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/scss"
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_bootstrap.scss $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/scss/_bootstrap.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_core.scss $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/scss/_core.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_extras.scss $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/scss/_extras.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_icons.scss $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/scss/_icons.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_mixins.scss $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/scss/_mixins.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_path.scss $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/scss/_path.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_variables.scss $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/scss/_variables.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/font-awesome-ie7.scss $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/scss/font-awesome-ie7.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/font-awesome.scss $(CONFIG)/esp/components/font-awesome/client/lib/font-awesome/scss/font-awesome.scss
	mkdir -p "$(CONFIG)/esp/components/font-awesome"
	cp src/esp/proto/components/font-awesome/config.json $(CONFIG)/esp/components/font-awesome/config.json
	mkdir -p "$(CONFIG)/esp/components/html5shiv/client/lib/html5shiv"
	cp src/esp/proto/components/html5shiv/client/lib/html5shiv/html5shiv.js $(CONFIG)/esp/components/html5shiv/client/lib/html5shiv/html5shiv.js
	mkdir -p "$(CONFIG)/esp/components/html5shiv"
	cp src/esp/proto/components/html5shiv/config.json $(CONFIG)/esp/components/html5shiv/config.json
	mkdir -p "$(CONFIG)/esp/components/jquery/client/lib/jquery"
	cp src/esp/proto/components/jquery/client/lib/jquery/jquery.js $(CONFIG)/esp/components/jquery/client/lib/jquery/jquery.js
	mkdir -p "$(CONFIG)/esp/components/jquery"
	cp src/esp/proto/components/jquery/config.json $(CONFIG)/esp/components/jquery/config.json
	mkdir -p "$(CONFIG)/esp/components/legacy-mvc"
	cp src/esp/proto/components/legacy-mvc/config.json $(CONFIG)/esp/components/legacy-mvc/config.json
	mkdir -p "$(CONFIG)/esp/components/legacy-mvc/layouts"
	cp src/esp/proto/components/legacy-mvc/layouts/default.esp $(CONFIG)/esp/components/legacy-mvc/layouts/default.esp
	mkdir -p "$(CONFIG)/esp/components/legacy-mvc/static/css"
	cp src/esp/proto/components/legacy-mvc/static/css/all.css $(CONFIG)/esp/components/legacy-mvc/static/css/all.css
	cp src/esp/proto/components/legacy-mvc/static/css/all.less $(CONFIG)/esp/components/legacy-mvc/static/css/all.less
	cp src/esp/proto/components/legacy-mvc/static/css/app.less $(CONFIG)/esp/components/legacy-mvc/static/css/app.less
	cp src/esp/proto/components/legacy-mvc/static/css/esp.less $(CONFIG)/esp/components/legacy-mvc/static/css/esp.less
	cp src/esp/proto/components/legacy-mvc/static/css/more.less $(CONFIG)/esp/components/legacy-mvc/static/css/more.less
	cp src/esp/proto/components/legacy-mvc/static/css/normalize.less $(CONFIG)/esp/components/legacy-mvc/static/css/normalize.less
	cp src/esp/proto/components/legacy-mvc/static/css/theme.less $(CONFIG)/esp/components/legacy-mvc/static/css/theme.less
	mkdir -p "$(CONFIG)/esp/components/legacy-mvc/static/images"
	cp src/esp/proto/components/legacy-mvc/static/images/banner.jpg $(CONFIG)/esp/components/legacy-mvc/static/images/banner.jpg
	cp src/esp/proto/components/legacy-mvc/static/images/favicon.ico $(CONFIG)/esp/components/legacy-mvc/static/images/favicon.ico
	cp src/esp/proto/components/legacy-mvc/static/images/splash.jpg $(CONFIG)/esp/components/legacy-mvc/static/images/splash.jpg
	mkdir -p "$(CONFIG)/esp/components/legacy-mvc/static"
	cp src/esp/proto/components/legacy-mvc/static/index.esp $(CONFIG)/esp/components/legacy-mvc/static/index.esp
	mkdir -p "$(CONFIG)/esp/components/legacy-mvc/static/lib"
	cp src/esp/proto/components/legacy-mvc/static/lib/html5shiv.js $(CONFIG)/esp/components/legacy-mvc/static/lib/html5shiv.js
	cp src/esp/proto/components/legacy-mvc/static/lib/jquery.esp.js $(CONFIG)/esp/components/legacy-mvc/static/lib/jquery.esp.js
	cp src/esp/proto/components/legacy-mvc/static/lib/jquery.js $(CONFIG)/esp/components/legacy-mvc/static/lib/jquery.js
	cp src/esp/proto/components/legacy-mvc/static/lib/jquery.simplemodal.js $(CONFIG)/esp/components/legacy-mvc/static/lib/jquery.simplemodal.js
	cp src/esp/proto/components/legacy-mvc/static/lib/jquery.tablesorter.js $(CONFIG)/esp/components/legacy-mvc/static/lib/jquery.tablesorter.js
	cp src/esp/proto/components/legacy-mvc/static/lib/less.js $(CONFIG)/esp/components/legacy-mvc/static/lib/less.js
	cp src/esp/proto/components/legacy-mvc/static/lib/respond.js $(CONFIG)/esp/components/legacy-mvc/static/lib/respond.js
	mkdir -p "$(CONFIG)/esp/components/less/client/lib/less"
	cp src/esp/proto/components/less/client/lib/less/less.js $(CONFIG)/esp/components/less/client/lib/less/less.js
	mkdir -p "$(CONFIG)/esp/components/less"
	cp src/esp/proto/components/less/config.json $(CONFIG)/esp/components/less/config.json
	mkdir -p "$(CONFIG)/esp/components/more/client/css"
	cp src/esp/proto/components/more/client/css/more.less $(CONFIG)/esp/components/more/client/css/more.less
	mkdir -p "$(CONFIG)/esp/components/more"
	cp src/esp/proto/components/more/config.json $(CONFIG)/esp/components/more/config.json
	mkdir -p "$(CONFIG)/esp/components/normalize/client/css"
	cp src/esp/proto/components/normalize/client/css/normalize.less $(CONFIG)/esp/components/normalize/client/css/normalize.less
	mkdir -p "$(CONFIG)/esp/components/normalize"
	cp src/esp/proto/components/normalize/config.json $(CONFIG)/esp/components/normalize/config.json
	mkdir -p "$(CONFIG)/esp/components/respond/client/lib/respond"
	cp src/esp/proto/components/respond/client/lib/respond/respond.js $(CONFIG)/esp/components/respond/client/lib/respond/respond.js
	mkdir -p "$(CONFIG)/esp/components/respond"
	cp src/esp/proto/components/respond/config.json $(CONFIG)/esp/components/respond/config.json
	mkdir -p "$(CONFIG)/esp/components/server"
	cp src/esp/proto/components/server/app.conf $(CONFIG)/esp/components/server/app.conf
	cp src/esp/proto/components/server/appweb.conf $(CONFIG)/esp/components/server/appweb.conf
	cp src/esp/proto/components/server/config.json $(CONFIG)/esp/components/server/config.json
	mkdir -p "$(CONFIG)/esp/templates/angular-mvc"
	cp src/esp/proto/templates/angular-mvc/controller.c $(CONFIG)/esp/templates/angular-mvc/controller.c
	cp src/esp/proto/templates/angular-mvc/controller.js $(CONFIG)/esp/templates/angular-mvc/controller.js
	cp src/esp/proto/templates/angular-mvc/edit.html $(CONFIG)/esp/templates/angular-mvc/edit.html
	cp src/esp/proto/templates/angular-mvc/list.html $(CONFIG)/esp/templates/angular-mvc/list.html
	cp src/esp/proto/templates/angular-mvc/model.js $(CONFIG)/esp/templates/angular-mvc/model.js
	mkdir -p "$(CONFIG)/esp/templates/legacy-mvc"
	cp src/esp/proto/templates/legacy-mvc/controller.c $(CONFIG)/esp/templates/legacy-mvc/controller.c
	cp src/esp/proto/templates/legacy-mvc/edit.html $(CONFIG)/esp/templates/legacy-mvc/edit.html
	cp src/esp/proto/templates/legacy-mvc/list.html $(CONFIG)/esp/templates/legacy-mvc/list.html
	mkdir -p "$(CONFIG)/esp/templates/server"
	cp src/esp/proto/templates/server/app.c $(CONFIG)/esp/templates/server/app.c
	cp src/esp/proto/templates/server/controller.c $(CONFIG)/esp/templates/server/controller.c
	cp src/esp/proto/templates/server/migration.c $(CONFIG)/esp/templates/server/migration.c
endif

#
#   ejs.h
#
$(CONFIG)/inc/ejs.h: $(DEPS_56)
	@echo '      [Copy] $(CONFIG)/inc/ejs.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/deps/ejs/ejs.h $(CONFIG)/inc/ejs.h

#
#   ejs.slots.h
#
$(CONFIG)/inc/ejs.slots.h: $(DEPS_57)
	@echo '      [Copy] $(CONFIG)/inc/ejs.slots.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/deps/ejs/ejs.slots.h $(CONFIG)/inc/ejs.slots.h

#
#   ejsByteGoto.h
#
$(CONFIG)/inc/ejsByteGoto.h: $(DEPS_58)
	@echo '      [Copy] $(CONFIG)/inc/ejsByteGoto.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/deps/ejs/ejsByteGoto.h $(CONFIG)/inc/ejsByteGoto.h

#
#   ejsLib.o
#
DEPS_59 += $(CONFIG)/inc/bit.h
DEPS_59 += $(CONFIG)/inc/ejs.h
DEPS_59 += $(CONFIG)/inc/mpr.h
DEPS_59 += $(CONFIG)/inc/pcre.h
DEPS_59 += $(CONFIG)/inc/bitos.h
DEPS_59 += $(CONFIG)/inc/http.h
DEPS_59 += $(CONFIG)/inc/ejs.slots.h

$(CONFIG)/obj/ejsLib.o: \
    src/deps/ejs/ejsLib.c $(DEPS_59)
	@echo '   [Compile] $(CONFIG)/obj/ejsLib.o'
	$(CC) -c -o $(CONFIG)/obj/ejsLib.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/deps/ejs/ejsLib.c

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   libejs
#
DEPS_60 += $(CONFIG)/inc/mpr.h
DEPS_60 += $(CONFIG)/inc/bit.h
DEPS_60 += $(CONFIG)/inc/bitos.h
DEPS_60 += $(CONFIG)/obj/mprLib.o
DEPS_60 += $(CONFIG)/bin/libmpr.a
DEPS_60 += $(CONFIG)/inc/pcre.h
DEPS_60 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_60 += $(CONFIG)/bin/libpcre.a
endif
DEPS_60 += $(CONFIG)/inc/http.h
DEPS_60 += $(CONFIG)/obj/httpLib.o
DEPS_60 += $(CONFIG)/bin/libhttp.a
DEPS_60 += $(CONFIG)/inc/ejs.h
DEPS_60 += $(CONFIG)/inc/ejs.slots.h
DEPS_60 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_60 += $(CONFIG)/obj/ejsLib.o

$(CONFIG)/bin/libejs.a: $(DEPS_60)
	@echo '      [Link] $(CONFIG)/bin/libejs.a'
	ar -cr $(CONFIG)/bin/libejs.a "$(CONFIG)/obj/ejsLib.o"
endif

#
#   ejs.o
#
DEPS_61 += $(CONFIG)/inc/bit.h
DEPS_61 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejs.o: \
    src/deps/ejs/ejs.c $(DEPS_61)
	@echo '   [Compile] $(CONFIG)/obj/ejs.o'
	$(CC) -c -o $(CONFIG)/obj/ejs.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/deps/ejs/ejs.c

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   ejs
#
DEPS_62 += $(CONFIG)/inc/mpr.h
DEPS_62 += $(CONFIG)/inc/bit.h
DEPS_62 += $(CONFIG)/inc/bitos.h
DEPS_62 += $(CONFIG)/obj/mprLib.o
DEPS_62 += $(CONFIG)/bin/libmpr.a
DEPS_62 += $(CONFIG)/inc/pcre.h
DEPS_62 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_62 += $(CONFIG)/bin/libpcre.a
endif
DEPS_62 += $(CONFIG)/inc/http.h
DEPS_62 += $(CONFIG)/obj/httpLib.o
DEPS_62 += $(CONFIG)/bin/libhttp.a
DEPS_62 += $(CONFIG)/inc/ejs.h
DEPS_62 += $(CONFIG)/inc/ejs.slots.h
DEPS_62 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_62 += $(CONFIG)/obj/ejsLib.o
DEPS_62 += $(CONFIG)/bin/libejs.a
DEPS_62 += $(CONFIG)/obj/ejs.o

LIBS_62 += -lejs
LIBS_62 += -lhttp
LIBS_62 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_62 += -lpcre
endif
ifeq ($(BIT_PACK_SQLITE),1)
    LIBS_62 += -lsqlite3
endif

$(CONFIG)/bin/ejs: $(DEPS_62)
	@echo '      [Link] $(CONFIG)/bin/ejs'
	$(CC) -o $(CONFIG)/bin/ejs $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejs.o" $(LIBPATHS_62) $(LIBS_62) $(LIBS_62) $(LIBS) $(LIBS) 
endif

#
#   ejsc.o
#
DEPS_63 += $(CONFIG)/inc/bit.h
DEPS_63 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsc.o: \
    src/deps/ejs/ejsc.c $(DEPS_63)
	@echo '   [Compile] $(CONFIG)/obj/ejsc.o'
	$(CC) -c -o $(CONFIG)/obj/ejsc.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/deps/ejs/ejsc.c

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   ejsc
#
DEPS_64 += $(CONFIG)/inc/mpr.h
DEPS_64 += $(CONFIG)/inc/bit.h
DEPS_64 += $(CONFIG)/inc/bitos.h
DEPS_64 += $(CONFIG)/obj/mprLib.o
DEPS_64 += $(CONFIG)/bin/libmpr.a
DEPS_64 += $(CONFIG)/inc/pcre.h
DEPS_64 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_64 += $(CONFIG)/bin/libpcre.a
endif
DEPS_64 += $(CONFIG)/inc/http.h
DEPS_64 += $(CONFIG)/obj/httpLib.o
DEPS_64 += $(CONFIG)/bin/libhttp.a
DEPS_64 += $(CONFIG)/inc/ejs.h
DEPS_64 += $(CONFIG)/inc/ejs.slots.h
DEPS_64 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_64 += $(CONFIG)/obj/ejsLib.o
DEPS_64 += $(CONFIG)/bin/libejs.a
DEPS_64 += $(CONFIG)/obj/ejsc.o

LIBS_64 += -lejs
LIBS_64 += -lhttp
LIBS_64 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_64 += -lpcre
endif
ifeq ($(BIT_PACK_SQLITE),1)
    LIBS_64 += -lsqlite3
endif

$(CONFIG)/bin/ejsc: $(DEPS_64)
	@echo '      [Link] $(CONFIG)/bin/ejsc'
	$(CC) -o $(CONFIG)/bin/ejsc $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsc.o" $(LIBPATHS_64) $(LIBS_64) $(LIBS_64) $(LIBS) $(LIBS) 
endif

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   ejs.mod
#
DEPS_65 += src/deps/ejs/ejs.es
DEPS_65 += $(CONFIG)/inc/mpr.h
DEPS_65 += $(CONFIG)/inc/bit.h
DEPS_65 += $(CONFIG)/inc/bitos.h
DEPS_65 += $(CONFIG)/obj/mprLib.o
DEPS_65 += $(CONFIG)/bin/libmpr.a
DEPS_65 += $(CONFIG)/inc/pcre.h
DEPS_65 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_65 += $(CONFIG)/bin/libpcre.a
endif
DEPS_65 += $(CONFIG)/inc/http.h
DEPS_65 += $(CONFIG)/obj/httpLib.o
DEPS_65 += $(CONFIG)/bin/libhttp.a
DEPS_65 += $(CONFIG)/inc/ejs.h
DEPS_65 += $(CONFIG)/inc/ejs.slots.h
DEPS_65 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_65 += $(CONFIG)/obj/ejsLib.o
DEPS_65 += $(CONFIG)/bin/libejs.a
DEPS_65 += $(CONFIG)/obj/ejsc.o
DEPS_65 += $(CONFIG)/bin/ejsc

$(CONFIG)/bin/ejs.mod: $(DEPS_65)
	$(LBIN)/ejsc --out ./$(CONFIG)/bin/ejs.mod --optimize 9 --bind --require null src/deps/ejs/ejs.es
endif

#
#   cgiHandler.o
#
DEPS_66 += $(CONFIG)/inc/bit.h
DEPS_66 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/cgiHandler.o: \
    src/modules/cgiHandler.c $(DEPS_66)
	@echo '   [Compile] $(CONFIG)/obj/cgiHandler.o'
	$(CC) -c -o $(CONFIG)/obj/cgiHandler.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/modules/cgiHandler.c

ifeq ($(BIT_PACK_CGI),1)
#
#   libmod_cgi
#
DEPS_67 += $(CONFIG)/inc/mpr.h
DEPS_67 += $(CONFIG)/inc/bit.h
DEPS_67 += $(CONFIG)/inc/bitos.h
DEPS_67 += $(CONFIG)/obj/mprLib.o
DEPS_67 += $(CONFIG)/bin/libmpr.a
DEPS_67 += $(CONFIG)/inc/pcre.h
DEPS_67 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_67 += $(CONFIG)/bin/libpcre.a
endif
DEPS_67 += $(CONFIG)/inc/http.h
DEPS_67 += $(CONFIG)/obj/httpLib.o
DEPS_67 += $(CONFIG)/bin/libhttp.a
DEPS_67 += $(CONFIG)/inc/appweb.h
DEPS_67 += $(CONFIG)/inc/customize.h
DEPS_67 += $(CONFIG)/obj/config.o
DEPS_67 += $(CONFIG)/obj/convenience.o
DEPS_67 += $(CONFIG)/obj/dirHandler.o
DEPS_67 += $(CONFIG)/obj/fileHandler.o
DEPS_67 += $(CONFIG)/obj/log.o
DEPS_67 += $(CONFIG)/obj/server.o
DEPS_67 += $(CONFIG)/bin/libappweb.a
DEPS_67 += $(CONFIG)/obj/cgiHandler.o

$(CONFIG)/bin/libmod_cgi.a: $(DEPS_67)
	@echo '      [Link] $(CONFIG)/bin/libmod_cgi.a'
	ar -cr $(CONFIG)/bin/libmod_cgi.a "$(CONFIG)/obj/cgiHandler.o"
endif

#
#   ejsHandler.o
#
DEPS_68 += $(CONFIG)/inc/bit.h
DEPS_68 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/ejsHandler.o: \
    src/modules/ejsHandler.c $(DEPS_68)
	@echo '   [Compile] $(CONFIG)/obj/ejsHandler.o'
	$(CC) -c -o $(CONFIG)/obj/ejsHandler.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/modules/ejsHandler.c

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   libmod_ejs
#
DEPS_69 += $(CONFIG)/inc/mpr.h
DEPS_69 += $(CONFIG)/inc/bit.h
DEPS_69 += $(CONFIG)/inc/bitos.h
DEPS_69 += $(CONFIG)/obj/mprLib.o
DEPS_69 += $(CONFIG)/bin/libmpr.a
DEPS_69 += $(CONFIG)/inc/pcre.h
DEPS_69 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_69 += $(CONFIG)/bin/libpcre.a
endif
DEPS_69 += $(CONFIG)/inc/http.h
DEPS_69 += $(CONFIG)/obj/httpLib.o
DEPS_69 += $(CONFIG)/bin/libhttp.a
DEPS_69 += $(CONFIG)/inc/appweb.h
DEPS_69 += $(CONFIG)/inc/customize.h
DEPS_69 += $(CONFIG)/obj/config.o
DEPS_69 += $(CONFIG)/obj/convenience.o
DEPS_69 += $(CONFIG)/obj/dirHandler.o
DEPS_69 += $(CONFIG)/obj/fileHandler.o
DEPS_69 += $(CONFIG)/obj/log.o
DEPS_69 += $(CONFIG)/obj/server.o
DEPS_69 += $(CONFIG)/bin/libappweb.a
DEPS_69 += $(CONFIG)/inc/ejs.h
DEPS_69 += $(CONFIG)/inc/ejs.slots.h
DEPS_69 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_69 += $(CONFIG)/obj/ejsLib.o
DEPS_69 += $(CONFIG)/bin/libejs.a
DEPS_69 += $(CONFIG)/obj/ejsHandler.o

$(CONFIG)/bin/libmod_ejs.a: $(DEPS_69)
	@echo '      [Link] $(CONFIG)/bin/libmod_ejs.a'
	ar -cr $(CONFIG)/bin/libmod_ejs.a "$(CONFIG)/obj/ejsHandler.o"
endif

#
#   phpHandler.o
#
DEPS_70 += $(CONFIG)/inc/bit.h
DEPS_70 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/phpHandler.o: \
    src/modules/phpHandler.c $(DEPS_70)
	@echo '   [Compile] $(CONFIG)/obj/phpHandler.o'
	$(CC) -c -o $(CONFIG)/obj/phpHandler.o -O2 -fPIC $(DFLAGS) "$(IFLAGS)" "-I$(BIT_PACK_PHP_PATH)" "-I$(BIT_PACK_PHP_PATH)/main" "-I$(BIT_PACK_PHP_PATH)/Zend" "-I$(BIT_PACK_PHP_PATH)/TSRM" src/modules/phpHandler.c

ifeq ($(BIT_PACK_PHP),1)
#
#   libmod_php
#
DEPS_71 += $(CONFIG)/inc/mpr.h
DEPS_71 += $(CONFIG)/inc/bit.h
DEPS_71 += $(CONFIG)/inc/bitos.h
DEPS_71 += $(CONFIG)/obj/mprLib.o
DEPS_71 += $(CONFIG)/bin/libmpr.a
DEPS_71 += $(CONFIG)/inc/pcre.h
DEPS_71 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_71 += $(CONFIG)/bin/libpcre.a
endif
DEPS_71 += $(CONFIG)/inc/http.h
DEPS_71 += $(CONFIG)/obj/httpLib.o
DEPS_71 += $(CONFIG)/bin/libhttp.a
DEPS_71 += $(CONFIG)/inc/appweb.h
DEPS_71 += $(CONFIG)/inc/customize.h
DEPS_71 += $(CONFIG)/obj/config.o
DEPS_71 += $(CONFIG)/obj/convenience.o
DEPS_71 += $(CONFIG)/obj/dirHandler.o
DEPS_71 += $(CONFIG)/obj/fileHandler.o
DEPS_71 += $(CONFIG)/obj/log.o
DEPS_71 += $(CONFIG)/obj/server.o
DEPS_71 += $(CONFIG)/bin/libappweb.a
DEPS_71 += $(CONFIG)/obj/phpHandler.o

$(CONFIG)/bin/libmod_php.a: $(DEPS_71)
	@echo '      [Link] $(CONFIG)/bin/libmod_php.a'
	ar -cr $(CONFIG)/bin/libmod_php.a "$(CONFIG)/obj/phpHandler.o"
endif

#
#   sslModule.o
#
DEPS_72 += $(CONFIG)/inc/bit.h
DEPS_72 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/sslModule.o: \
    src/modules/sslModule.c $(DEPS_72)
	@echo '   [Compile] $(CONFIG)/obj/sslModule.o'
	$(CC) -c -o $(CONFIG)/obj/sslModule.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" "-I$(BIT_PACK_MATRIXSSL_PATH)" "-I$(BIT_PACK_MATRIXSSL_PATH)/matrixssl" "-I$(BIT_PACK_NANOSSL_PATH)/src" "-I$(BIT_PACK_OPENSSL_PATH)/include" src/modules/sslModule.c

ifeq ($(BIT_PACK_SSL),1)
#
#   libmod_ssl
#
DEPS_73 += $(CONFIG)/inc/mpr.h
DEPS_73 += $(CONFIG)/inc/bit.h
DEPS_73 += $(CONFIG)/inc/bitos.h
DEPS_73 += $(CONFIG)/obj/mprLib.o
DEPS_73 += $(CONFIG)/bin/libmpr.a
DEPS_73 += $(CONFIG)/inc/pcre.h
DEPS_73 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_73 += $(CONFIG)/bin/libpcre.a
endif
DEPS_73 += $(CONFIG)/inc/http.h
DEPS_73 += $(CONFIG)/obj/httpLib.o
DEPS_73 += $(CONFIG)/bin/libhttp.a
DEPS_73 += $(CONFIG)/inc/appweb.h
DEPS_73 += $(CONFIG)/inc/customize.h
DEPS_73 += $(CONFIG)/obj/config.o
DEPS_73 += $(CONFIG)/obj/convenience.o
DEPS_73 += $(CONFIG)/obj/dirHandler.o
DEPS_73 += $(CONFIG)/obj/fileHandler.o
DEPS_73 += $(CONFIG)/obj/log.o
DEPS_73 += $(CONFIG)/obj/server.o
DEPS_73 += $(CONFIG)/bin/libappweb.a
DEPS_73 += $(CONFIG)/inc/est.h
DEPS_73 += $(CONFIG)/obj/estLib.o
ifeq ($(BIT_PACK_EST),1)
    DEPS_73 += $(CONFIG)/bin/libest.a
endif
DEPS_73 += $(CONFIG)/obj/mprSsl.o
DEPS_73 += $(CONFIG)/bin/libmprssl.a
DEPS_73 += $(CONFIG)/obj/sslModule.o

$(CONFIG)/bin/libmod_ssl.a: $(DEPS_73)
	@echo '      [Link] $(CONFIG)/bin/libmod_ssl.a'
	ar -cr $(CONFIG)/bin/libmod_ssl.a "$(CONFIG)/obj/sslModule.o"
endif

#
#   authpass.o
#
DEPS_74 += $(CONFIG)/inc/bit.h
DEPS_74 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/authpass.o: \
    src/utils/authpass.c $(DEPS_74)
	@echo '   [Compile] $(CONFIG)/obj/authpass.o'
	$(CC) -c -o $(CONFIG)/obj/authpass.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/utils/authpass.c

#
#   authpass
#
DEPS_75 += $(CONFIG)/inc/mpr.h
DEPS_75 += $(CONFIG)/inc/bit.h
DEPS_75 += $(CONFIG)/inc/bitos.h
DEPS_75 += $(CONFIG)/obj/mprLib.o
DEPS_75 += $(CONFIG)/bin/libmpr.a
DEPS_75 += $(CONFIG)/inc/pcre.h
DEPS_75 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_75 += $(CONFIG)/bin/libpcre.a
endif
DEPS_75 += $(CONFIG)/inc/http.h
DEPS_75 += $(CONFIG)/obj/httpLib.o
DEPS_75 += $(CONFIG)/bin/libhttp.a
DEPS_75 += $(CONFIG)/inc/appweb.h
DEPS_75 += $(CONFIG)/inc/customize.h
DEPS_75 += $(CONFIG)/obj/config.o
DEPS_75 += $(CONFIG)/obj/convenience.o
DEPS_75 += $(CONFIG)/obj/dirHandler.o
DEPS_75 += $(CONFIG)/obj/fileHandler.o
DEPS_75 += $(CONFIG)/obj/log.o
DEPS_75 += $(CONFIG)/obj/server.o
DEPS_75 += $(CONFIG)/bin/libappweb.a
DEPS_75 += $(CONFIG)/obj/authpass.o

LIBS_75 += -lappweb
LIBS_75 += -lhttp
LIBS_75 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_75 += -lpcre
endif

$(CONFIG)/bin/authpass: $(DEPS_75)
	@echo '      [Link] $(CONFIG)/bin/authpass'
	$(CC) -o $(CONFIG)/bin/authpass $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/authpass.o" $(LIBPATHS_75) $(LIBS_75) $(LIBS_75) $(LIBS) $(LIBS) 

#
#   cgiProgram.o
#
DEPS_76 += $(CONFIG)/inc/bit.h

$(CONFIG)/obj/cgiProgram.o: \
    src/utils/cgiProgram.c $(DEPS_76)
	@echo '   [Compile] $(CONFIG)/obj/cgiProgram.o'
	$(CC) -c -o $(CONFIG)/obj/cgiProgram.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/utils/cgiProgram.c

ifeq ($(BIT_PACK_CGI),1)
#
#   cgiProgram
#
DEPS_77 += $(CONFIG)/inc/bit.h
DEPS_77 += $(CONFIG)/obj/cgiProgram.o

$(CONFIG)/bin/cgiProgram: $(DEPS_77)
	@echo '      [Link] $(CONFIG)/bin/cgiProgram'
	$(CC) -o $(CONFIG)/bin/cgiProgram $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/cgiProgram.o" $(LIBS) $(LIBS) 
endif

#
#   slink.c
#
src/server/slink.c: $(DEPS_78)
	cd src/server; [ ! -f slink.c ] && cp slink.empty slink.c ; true ; cd ../..

#
#   slink.o
#
DEPS_79 += $(CONFIG)/inc/bit.h
DEPS_79 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/slink.o: \
    src/server/slink.c $(DEPS_79)
	@echo '   [Compile] $(CONFIG)/obj/slink.o'
	$(CC) -c -o $(CONFIG)/obj/slink.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" src/server/slink.c

#
#   libslink
#
DEPS_80 += src/server/slink.c
DEPS_80 += $(CONFIG)/inc/mpr.h
DEPS_80 += $(CONFIG)/inc/bit.h
DEPS_80 += $(CONFIG)/inc/bitos.h
DEPS_80 += $(CONFIG)/obj/mprLib.o
DEPS_80 += $(CONFIG)/bin/libmpr.a
DEPS_80 += $(CONFIG)/inc/pcre.h
DEPS_80 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_80 += $(CONFIG)/bin/libpcre.a
endif
DEPS_80 += $(CONFIG)/inc/http.h
DEPS_80 += $(CONFIG)/obj/httpLib.o
DEPS_80 += $(CONFIG)/bin/libhttp.a
DEPS_80 += $(CONFIG)/inc/appweb.h
DEPS_80 += $(CONFIG)/inc/customize.h
DEPS_80 += $(CONFIG)/obj/config.o
DEPS_80 += $(CONFIG)/obj/convenience.o
DEPS_80 += $(CONFIG)/obj/dirHandler.o
DEPS_80 += $(CONFIG)/obj/fileHandler.o
DEPS_80 += $(CONFIG)/obj/log.o
DEPS_80 += $(CONFIG)/obj/server.o
DEPS_80 += $(CONFIG)/bin/libappweb.a
DEPS_80 += $(CONFIG)/inc/edi.h
DEPS_80 += $(CONFIG)/inc/esp.h
DEPS_80 += $(CONFIG)/inc/mdb.h
DEPS_80 += $(CONFIG)/obj/edi.o
DEPS_80 += $(CONFIG)/obj/espAbbrev.o
DEPS_80 += $(CONFIG)/obj/espFramework.o
DEPS_80 += $(CONFIG)/obj/espHandler.o
DEPS_80 += $(CONFIG)/obj/espHtml.o
DEPS_80 += $(CONFIG)/obj/espTemplate.o
DEPS_80 += $(CONFIG)/obj/mdb.o
DEPS_80 += $(CONFIG)/obj/sdb.o
ifeq ($(BIT_PACK_ESP),1)
    DEPS_80 += $(CONFIG)/bin/libmod_esp.a
endif
DEPS_80 += $(CONFIG)/obj/slink.o

$(CONFIG)/bin/libslink.a: $(DEPS_80)
	@echo '      [Link] $(CONFIG)/bin/libslink.a'
	ar -cr $(CONFIG)/bin/libslink.a "$(CONFIG)/obj/slink.o"

#
#   appweb.o
#
DEPS_81 += $(CONFIG)/inc/bit.h
DEPS_81 += $(CONFIG)/inc/appweb.h
DEPS_81 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/appweb.o: \
    src/server/appweb.c $(DEPS_81)
	@echo '   [Compile] $(CONFIG)/obj/appweb.o'
	$(CC) -c -o $(CONFIG)/obj/appweb.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" "-I$(BIT_PACK_MATRIXSSL_PATH)" "-I$(BIT_PACK_MATRIXSSL_PATH)/matrixssl" "-I$(BIT_PACK_NANOSSL_PATH)/src" "-I$(BIT_PACK_OPENSSL_PATH)/include" "-I$(BIT_PACK_PHP_PATH)" "-I$(BIT_PACK_PHP_PATH)/main" "-I$(BIT_PACK_PHP_PATH)/Zend" "-I$(BIT_PACK_PHP_PATH)/TSRM" src/server/appweb.c

#
#   appweb
#
DEPS_82 += $(CONFIG)/inc/mpr.h
DEPS_82 += $(CONFIG)/inc/bit.h
DEPS_82 += $(CONFIG)/inc/bitos.h
DEPS_82 += $(CONFIG)/obj/mprLib.o
DEPS_82 += $(CONFIG)/bin/libmpr.a
DEPS_82 += $(CONFIG)/inc/pcre.h
DEPS_82 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_82 += $(CONFIG)/bin/libpcre.a
endif
DEPS_82 += $(CONFIG)/inc/http.h
DEPS_82 += $(CONFIG)/obj/httpLib.o
DEPS_82 += $(CONFIG)/bin/libhttp.a
DEPS_82 += $(CONFIG)/inc/appweb.h
DEPS_82 += $(CONFIG)/inc/customize.h
DEPS_82 += $(CONFIG)/obj/config.o
DEPS_82 += $(CONFIG)/obj/convenience.o
DEPS_82 += $(CONFIG)/obj/dirHandler.o
DEPS_82 += $(CONFIG)/obj/fileHandler.o
DEPS_82 += $(CONFIG)/obj/log.o
DEPS_82 += $(CONFIG)/obj/server.o
DEPS_82 += $(CONFIG)/bin/libappweb.a
DEPS_82 += src/server/slink.c
DEPS_82 += $(CONFIG)/inc/edi.h
DEPS_82 += $(CONFIG)/inc/esp.h
DEPS_82 += $(CONFIG)/inc/mdb.h
DEPS_82 += $(CONFIG)/obj/edi.o
DEPS_82 += $(CONFIG)/obj/espAbbrev.o
DEPS_82 += $(CONFIG)/obj/espFramework.o
DEPS_82 += $(CONFIG)/obj/espHandler.o
DEPS_82 += $(CONFIG)/obj/espHtml.o
DEPS_82 += $(CONFIG)/obj/espTemplate.o
DEPS_82 += $(CONFIG)/obj/mdb.o
DEPS_82 += $(CONFIG)/obj/sdb.o
ifeq ($(BIT_PACK_ESP),1)
    DEPS_82 += $(CONFIG)/bin/libmod_esp.a
endif
DEPS_82 += $(CONFIG)/obj/slink.o
DEPS_82 += $(CONFIG)/bin/libslink.a
DEPS_82 += $(CONFIG)/inc/est.h
DEPS_82 += $(CONFIG)/obj/estLib.o
ifeq ($(BIT_PACK_EST),1)
    DEPS_82 += $(CONFIG)/bin/libest.a
endif
DEPS_82 += $(CONFIG)/obj/mprSsl.o
DEPS_82 += $(CONFIG)/bin/libmprssl.a
DEPS_82 += $(CONFIG)/obj/sslModule.o
ifeq ($(BIT_PACK_SSL),1)
    DEPS_82 += $(CONFIG)/bin/libmod_ssl.a
endif
DEPS_82 += $(CONFIG)/inc/ejs.h
DEPS_82 += $(CONFIG)/inc/ejs.slots.h
DEPS_82 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_82 += $(CONFIG)/obj/ejsLib.o
ifeq ($(BIT_PACK_EJSCRIPT),1)
    DEPS_82 += $(CONFIG)/bin/libejs.a
endif
DEPS_82 += $(CONFIG)/obj/ejsHandler.o
ifeq ($(BIT_PACK_EJSCRIPT),1)
    DEPS_82 += $(CONFIG)/bin/libmod_ejs.a
endif
DEPS_82 += $(CONFIG)/obj/phpHandler.o
ifeq ($(BIT_PACK_PHP),1)
    DEPS_82 += $(CONFIG)/bin/libmod_php.a
endif
DEPS_82 += $(CONFIG)/obj/cgiHandler.o
ifeq ($(BIT_PACK_CGI),1)
    DEPS_82 += $(CONFIG)/bin/libmod_cgi.a
endif
DEPS_82 += $(CONFIG)/obj/appweb.o

LIBS_82 += -lappweb
LIBS_82 += -lhttp
LIBS_82 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_82 += -lpcre
endif
LIBS_82 += -lslink
ifeq ($(BIT_PACK_ESP),1)
    LIBS_82 += -lmod_esp
endif
ifeq ($(BIT_PACK_SQLITE),1)
    LIBS_82 += -lsqlite3
endif
ifeq ($(BIT_PACK_SSL),1)
    LIBS_82 += -lmod_ssl
endif
LIBS_82 += -lmprssl
ifeq ($(BIT_PACK_EST),1)
    LIBS_82 += -lest
endif
ifeq ($(BIT_PACK_MATRIXSSL),1)
    LIBS_82 += -lmatrixssl
    LIBPATHS_82 += -L$(BIT_PACK_MATRIXSSL_PATH)
endif
ifeq ($(BIT_PACK_NANOSSL),1)
    LIBS_82 += -lssls
    LIBPATHS_82 += -L$(BIT_PACK_NANOSSL_PATH)/bin
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_82 += -lssl
    LIBPATHS_82 += -L$(BIT_PACK_OPENSSL_PATH)
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_82 += -lcrypto
    LIBPATHS_82 += -L$(BIT_PACK_OPENSSL_PATH)
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
    LIBS_82 += -lmod_ejs
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
    LIBS_82 += -lejs
endif
ifeq ($(BIT_PACK_PHP),1)
    LIBS_82 += -lmod_php
endif
ifeq ($(BIT_PACK_PHP),1)
    LIBS_82 += -lphp5
    LIBPATHS_82 += -L$(BIT_PACK_PHP_PATH)/libs
endif
ifeq ($(BIT_PACK_CGI),1)
    LIBS_82 += -lmod_cgi
endif

$(CONFIG)/bin/appweb: $(DEPS_82)
	@echo '      [Link] $(CONFIG)/bin/appweb'
	$(CC) -o $(CONFIG)/bin/appweb $(LDFLAGS) $(LIBPATHS)     "$(CONFIG)/obj/appweb.o" $(LIBPATHS_82) $(LIBS_82) $(LIBS_82) $(LIBS) $(LIBS) 

#
#   server-cache
#
src/server/cache: $(DEPS_83)
	cd src/server; mkdir -p cache ; cd ../..

#
#   testAppweb.h
#
$(CONFIG)/inc/testAppweb.h: $(DEPS_84)
	@echo '      [Copy] $(CONFIG)/inc/testAppweb.h'
	mkdir -p "$(CONFIG)/inc"
	cp test/src/testAppweb.h $(CONFIG)/inc/testAppweb.h

#
#   testAppweb.o
#
DEPS_85 += $(CONFIG)/inc/bit.h
DEPS_85 += $(CONFIG)/inc/testAppweb.h
DEPS_85 += $(CONFIG)/inc/mpr.h
DEPS_85 += $(CONFIG)/inc/http.h

$(CONFIG)/obj/testAppweb.o: \
    test/src/testAppweb.c $(DEPS_85)
	@echo '   [Compile] $(CONFIG)/obj/testAppweb.o'
	$(CC) -c -o $(CONFIG)/obj/testAppweb.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" test/src/testAppweb.c

#
#   testHttp.o
#
DEPS_86 += $(CONFIG)/inc/bit.h
DEPS_86 += $(CONFIG)/inc/testAppweb.h

$(CONFIG)/obj/testHttp.o: \
    test/src/testHttp.c $(DEPS_86)
	@echo '   [Compile] $(CONFIG)/obj/testHttp.o'
	$(CC) -c -o $(CONFIG)/obj/testHttp.o $(CFLAGS) $(DFLAGS) "$(IFLAGS)" test/src/testHttp.c

#
#   testAppweb
#
DEPS_87 += $(CONFIG)/inc/mpr.h
DEPS_87 += $(CONFIG)/inc/bit.h
DEPS_87 += $(CONFIG)/inc/bitos.h
DEPS_87 += $(CONFIG)/obj/mprLib.o
DEPS_87 += $(CONFIG)/bin/libmpr.a
DEPS_87 += $(CONFIG)/inc/pcre.h
DEPS_87 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_87 += $(CONFIG)/bin/libpcre.a
endif
DEPS_87 += $(CONFIG)/inc/http.h
DEPS_87 += $(CONFIG)/obj/httpLib.o
DEPS_87 += $(CONFIG)/bin/libhttp.a
DEPS_87 += $(CONFIG)/inc/appweb.h
DEPS_87 += $(CONFIG)/inc/customize.h
DEPS_87 += $(CONFIG)/obj/config.o
DEPS_87 += $(CONFIG)/obj/convenience.o
DEPS_87 += $(CONFIG)/obj/dirHandler.o
DEPS_87 += $(CONFIG)/obj/fileHandler.o
DEPS_87 += $(CONFIG)/obj/log.o
DEPS_87 += $(CONFIG)/obj/server.o
DEPS_87 += $(CONFIG)/bin/libappweb.a
DEPS_87 += $(CONFIG)/inc/testAppweb.h
DEPS_87 += $(CONFIG)/obj/testAppweb.o
DEPS_87 += $(CONFIG)/obj/testHttp.o

LIBS_87 += -lappweb
LIBS_87 += -lhttp
LIBS_87 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_87 += -lpcre
endif

$(CONFIG)/bin/testAppweb: $(DEPS_87)
	@echo '      [Link] $(CONFIG)/bin/testAppweb'
	$(CC) -o $(CONFIG)/bin/testAppweb $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/testAppweb.o" "$(CONFIG)/obj/testHttp.o" $(LIBPATHS_87) $(LIBS_87) $(LIBS_87) $(LIBS) $(LIBS) 

ifeq ($(BIT_PACK_CGI),1)
#
#   test-testScript
#
DEPS_88 += $(CONFIG)/inc/mpr.h
DEPS_88 += $(CONFIG)/inc/bit.h
DEPS_88 += $(CONFIG)/inc/bitos.h
DEPS_88 += $(CONFIG)/obj/mprLib.o
DEPS_88 += $(CONFIG)/bin/libmpr.a
DEPS_88 += $(CONFIG)/inc/pcre.h
DEPS_88 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_88 += $(CONFIG)/bin/libpcre.a
endif
DEPS_88 += $(CONFIG)/inc/http.h
DEPS_88 += $(CONFIG)/obj/httpLib.o
DEPS_88 += $(CONFIG)/bin/libhttp.a
DEPS_88 += $(CONFIG)/inc/appweb.h
DEPS_88 += $(CONFIG)/inc/customize.h
DEPS_88 += $(CONFIG)/obj/config.o
DEPS_88 += $(CONFIG)/obj/convenience.o
DEPS_88 += $(CONFIG)/obj/dirHandler.o
DEPS_88 += $(CONFIG)/obj/fileHandler.o
DEPS_88 += $(CONFIG)/obj/log.o
DEPS_88 += $(CONFIG)/obj/server.o
DEPS_88 += $(CONFIG)/bin/libappweb.a
DEPS_88 += $(CONFIG)/inc/testAppweb.h
DEPS_88 += $(CONFIG)/obj/testAppweb.o
DEPS_88 += $(CONFIG)/obj/testHttp.o
DEPS_88 += $(CONFIG)/bin/testAppweb

test/cgi-bin/testScript: $(DEPS_88)
	cd test; echo '#!../$(CONFIG)/bin/cgiProgram' >cgi-bin/testScript ; chmod +x cgi-bin/testScript ; cd ..
endif

ifeq ($(BIT_PACK_CGI),1)
#
#   test-cache.cgi
#
DEPS_89 += $(CONFIG)/inc/mpr.h
DEPS_89 += $(CONFIG)/inc/bit.h
DEPS_89 += $(CONFIG)/inc/bitos.h
DEPS_89 += $(CONFIG)/obj/mprLib.o
DEPS_89 += $(CONFIG)/bin/libmpr.a
DEPS_89 += $(CONFIG)/inc/pcre.h
DEPS_89 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_89 += $(CONFIG)/bin/libpcre.a
endif
DEPS_89 += $(CONFIG)/inc/http.h
DEPS_89 += $(CONFIG)/obj/httpLib.o
DEPS_89 += $(CONFIG)/bin/libhttp.a
DEPS_89 += $(CONFIG)/inc/appweb.h
DEPS_89 += $(CONFIG)/inc/customize.h
DEPS_89 += $(CONFIG)/obj/config.o
DEPS_89 += $(CONFIG)/obj/convenience.o
DEPS_89 += $(CONFIG)/obj/dirHandler.o
DEPS_89 += $(CONFIG)/obj/fileHandler.o
DEPS_89 += $(CONFIG)/obj/log.o
DEPS_89 += $(CONFIG)/obj/server.o
DEPS_89 += $(CONFIG)/bin/libappweb.a
DEPS_89 += $(CONFIG)/inc/testAppweb.h
DEPS_89 += $(CONFIG)/obj/testAppweb.o
DEPS_89 += $(CONFIG)/obj/testHttp.o
DEPS_89 += $(CONFIG)/bin/testAppweb

test/web/caching/cache.cgi: $(DEPS_89)
	cd test; echo "#!`type -p ejs`" >web/caching/cache.cgi ; cd ..
	cd test; echo 'print("HTTP/1.0 200 OK\nContent-Type: text/plain\n\n" + Date() + "\n")' >>web/caching/cache.cgi ; cd ..
	cd test; chmod +x web/caching/cache.cgi ; cd ..
endif

ifeq ($(BIT_PACK_CGI),1)
#
#   test-basic.cgi
#
DEPS_90 += $(CONFIG)/inc/mpr.h
DEPS_90 += $(CONFIG)/inc/bit.h
DEPS_90 += $(CONFIG)/inc/bitos.h
DEPS_90 += $(CONFIG)/obj/mprLib.o
DEPS_90 += $(CONFIG)/bin/libmpr.a
DEPS_90 += $(CONFIG)/inc/pcre.h
DEPS_90 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_90 += $(CONFIG)/bin/libpcre.a
endif
DEPS_90 += $(CONFIG)/inc/http.h
DEPS_90 += $(CONFIG)/obj/httpLib.o
DEPS_90 += $(CONFIG)/bin/libhttp.a
DEPS_90 += $(CONFIG)/inc/appweb.h
DEPS_90 += $(CONFIG)/inc/customize.h
DEPS_90 += $(CONFIG)/obj/config.o
DEPS_90 += $(CONFIG)/obj/convenience.o
DEPS_90 += $(CONFIG)/obj/dirHandler.o
DEPS_90 += $(CONFIG)/obj/fileHandler.o
DEPS_90 += $(CONFIG)/obj/log.o
DEPS_90 += $(CONFIG)/obj/server.o
DEPS_90 += $(CONFIG)/bin/libappweb.a
DEPS_90 += $(CONFIG)/inc/testAppweb.h
DEPS_90 += $(CONFIG)/obj/testAppweb.o
DEPS_90 += $(CONFIG)/obj/testHttp.o
DEPS_90 += $(CONFIG)/bin/testAppweb

test/web/auth/basic/basic.cgi: $(DEPS_90)
	cd test; echo "#!`type -p ejs`" >web/auth/basic/basic.cgi ; cd ..
	cd test; echo 'print("HTTP/1.0 200 OK\nContent-Type: text/plain\n\n" + serialize(App.env, {pretty: true}) + "\n")' >>web/auth/basic/basic.cgi ; cd ..
	cd test; chmod +x web/auth/basic/basic.cgi ; cd ..
endif

ifeq ($(BIT_PACK_CGI),1)
#
#   test-cgiProgram
#
DEPS_91 += $(CONFIG)/inc/bit.h
DEPS_91 += $(CONFIG)/obj/cgiProgram.o
DEPS_91 += $(CONFIG)/bin/cgiProgram

test/cgi-bin/cgiProgram: $(DEPS_91)
	cd test; cp ../$(CONFIG)/bin/cgiProgram cgi-bin/cgiProgram ; cd ..
	cd test; cp ../$(CONFIG)/bin/cgiProgram cgi-bin/nph-cgiProgram ; cd ..
	cd test; cp ../$(CONFIG)/bin/cgiProgram 'cgi-bin/cgi Program' ; cd ..
	cd test; cp ../$(CONFIG)/bin/cgiProgram web/cgiProgram.cgi ; cd ..
	cd test; chmod +x cgi-bin/* web/cgiProgram.cgi ; cd ..
endif


#
#   stop
#
DEPS_92 += compile

stop: $(DEPS_92)
	@./$(CONFIG)/bin/appman stop disable uninstall >/dev/null 2>&1 ; true

#
#   installBinary
#
installBinary: $(DEPS_93)
	mkdir -p "$(BIT_APP_PREFIX)"
	mkdir -p "$(BIT_VAPP_PREFIX)"
	mkdir -p "$(BIT_ETC_PREFIX)"
	mkdir -p "$(BIT_WEB_PREFIX)"
	mkdir -p "$(BIT_LOG_PREFIX)"
	mkdir -p "$(BIT_SPOOL_PREFIX)"
	rm -fr "$(BIT_CACHE_PREFIX)"
	mkdir -p "$(BIT_CACHE_PREFIX)"
	mkdir -p "$(BIT_APP_PREFIX)"
	rm -f "$(BIT_APP_PREFIX)/latest"
	ln -s "4.4.0" "$(BIT_APP_PREFIX)/latest"
	mkdir -p "$(BIT_LOG_PREFIX)"
	chmod 755 "$(BIT_LOG_PREFIX)"
	[ `id -u` = 0 ] && chown $(WEB_USER):$(WEB_GROUP) "$(BIT_LOG_PREFIX)"; true
	mkdir -p "$(BIT_CACHE_PREFIX)"
	chmod 755 "$(BIT_CACHE_PREFIX)"
	[ `id -u` = 0 ] && chown $(WEB_USER):$(WEB_GROUP) "$(BIT_CACHE_PREFIX)"; true
	mkdir -p "$(BIT_VAPP_PREFIX)/bin"
	cp $(CONFIG)/bin/appweb $(BIT_VAPP_PREFIX)/bin/appweb
	mkdir -p "$(BIT_BIN_PREFIX)"
	rm -f "$(BIT_BIN_PREFIX)/appweb"
	ln -s "$(BIT_VAPP_PREFIX)/bin/appweb" "$(BIT_BIN_PREFIX)/appweb"
	cp $(CONFIG)/bin/appman $(BIT_VAPP_PREFIX)/bin/appman
	rm -f "$(BIT_BIN_PREFIX)/appman"
	ln -s "$(BIT_VAPP_PREFIX)/bin/appman" "$(BIT_BIN_PREFIX)/appman"
	cp $(CONFIG)/bin/http $(BIT_VAPP_PREFIX)/bin/http
	rm -f "$(BIT_BIN_PREFIX)/http"
	ln -s "$(BIT_VAPP_PREFIX)/bin/http" "$(BIT_BIN_PREFIX)/http"
ifeq ($(BIT_PACK_ESP),1)
	cp $(CONFIG)/bin/esp $(BIT_VAPP_PREFIX)/bin/esp
	rm -f "$(BIT_BIN_PREFIX)/esp"
	ln -s "$(BIT_VAPP_PREFIX)/bin/esp" "$(BIT_BIN_PREFIX)/esp"
endif
ifeq ($(BIT_PACK_SSL),1)
	cp $(CONFIG)/bin/ca.crt $(BIT_VAPP_PREFIX)/bin/ca.crt
endif
ifeq ($(BIT_PACK_OPENSSL),1)
	cp $(CONFIG)/bin/libssl*.so* $(BIT_VAPP_PREFIX)/bin/libssl*.so*
	cp $(CONFIG)/bin/libcrypto*.so* $(BIT_VAPP_PREFIX)/bin/libcrypto*.so*
endif
ifeq ($(BIT_PACK_PHP),1)
	cp $(CONFIG)/bin/libphp5.so $(BIT_VAPP_PREFIX)/bin/libphp5.so
endif
ifeq ($(BIT_PACK_ESP),1)
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular"
	cp src/esp/proto/components/angular/client/lib/angular/angular-animate.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/angular-animate.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-bootstrap-prettify.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/angular-bootstrap-prettify.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-bootstrap.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/angular-bootstrap.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-cookies.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/angular-cookies.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-loader.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/angular-loader.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-mocks.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/angular-mocks.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-resource.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/angular-resource.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-route.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/angular-route.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-sanitize.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/angular-sanitize.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-scenario.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/angular-scenario.js
	cp src/esp/proto/components/angular/client/lib/angular/angular-touch.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/angular-touch.js
	cp src/esp/proto/components/angular/client/lib/angular/angular.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/angular.js
	cp src/esp/proto/components/angular/client/lib/angular/errors.json $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/errors.json
	cp src/esp/proto/components/angular/client/lib/angular/version.json $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/version.json
	cp src/esp/proto/components/angular/client/lib/angular/version.txt $(BIT_VAPP_PREFIX)/esp/proto/components/angular/client/lib/angular/version.txt
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular"
	cp src/esp/proto/components/angular/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/angular/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-esp/client/lib/angular-esp/ext"
	cp src/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-field-errors.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-field-errors.js
	cp src/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-format.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-format.js
	cp src/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-input-group.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-input-group.js
	cp src/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-input.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-input.js
	cp src/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-titlecase.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular-esp/client/lib/angular-esp/ext/esp-titlecase.js
	cp src/esp/proto/components/angular-esp/client/lib/angular-esp/ext/Esp.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular-esp/client/lib/angular-esp/ext/Esp.js
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-esp"
	cp src/esp/proto/components/angular-esp/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/angular-esp/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-extras"
	cp src/esp/proto/components/angular-extras/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/angular-extras/config.json
	cp src/esp/proto/components/angular-extras/misc.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular-extras/misc.js
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-local/client/lib/angular-local/ext"
	cp src/esp/proto/components/angular-local/client/lib/angular-local/ext/LocalStore.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular-local/client/lib/angular-local/ext/LocalStore.js
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-local"
	cp src/esp/proto/components/angular-local/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/angular-local/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc/client/app"
	cp src/esp/proto/components/angular-mvc/client/app/main.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc/client/app/main.js
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc/client/css"
	cp src/esp/proto/components/angular-mvc/client/css/all.less $(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc/client/css/all.less
	cp src/esp/proto/components/angular-mvc/client/css/app.less $(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc/client/css/app.less
	cp src/esp/proto/components/angular-mvc/client/css/fix.css $(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc/client/css/fix.css
	cp src/esp/proto/components/angular-mvc/client/css/theme.less $(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc/client/css/theme.less
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc/client"
	cp src/esp/proto/components/angular-mvc/client/index.esp $(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc/client/index.esp
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc/client/pages"
	cp src/esp/proto/components/angular-mvc/client/pages/splash.html $(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc/client/pages/splash.html
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc"
	cp src/esp/proto/components/angular-mvc/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc/config.json
	cp src/esp/proto/components/angular-mvc/start.bit $(BIT_VAPP_PREFIX)/esp/proto/components/angular-mvc/start.bit
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-session/client/lib/angular-session/ext"
	cp src/esp/proto/components/angular-session/client/lib/angular-session/ext/SessionStore.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular-session/client/lib/angular-session/ext/SessionStore.js
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-session"
	cp src/esp/proto/components/angular-session/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/angular-session/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-ui-bootstrap/client/lib/angular-ui-bootstrap"
	cp src/esp/proto/components/angular-ui-bootstrap/client/lib/angular-ui-bootstrap/ui-bootstrap-tpls.js $(BIT_VAPP_PREFIX)/esp/proto/components/angular-ui-bootstrap/client/lib/angular-ui-bootstrap/ui-bootstrap-tpls.js
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/angular-ui-bootstrap"
	cp src/esp/proto/components/angular-ui-bootstrap/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/angular-ui-bootstrap/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/animate/client/css"
	cp src/esp/proto/components/animate/client/css/animate.css $(BIT_VAPP_PREFIX)/esp/proto/components/animate/client/css/animate.css
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/animate"
	cp src/esp/proto/components/animate/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/animate/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/css"
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/css/bootstrap-theme.css $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/css/bootstrap-theme.css
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/css/bootstrap-theme.min.css $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/css/bootstrap-theme.min.css
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/css/bootstrap.css $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/css/bootstrap.css
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/css/bootstrap.min.css $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/css/bootstrap.min.css
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/fonts"
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.eot $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.eot
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.svg $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.svg
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.ttf $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.ttf
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.woff $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/fonts/glyphicons-halflings-regular.woff
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/js"
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/js/bootstrap.js $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/js/bootstrap.js
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less"
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/alerts.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/alerts.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/badges.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/badges.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/bootstrap.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/bootstrap.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/breadcrumbs.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/breadcrumbs.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/button-groups.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/button-groups.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/buttons.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/buttons.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/carousel.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/carousel.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/close.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/close.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/code.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/code.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/component-animations.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/component-animations.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/dropdowns.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/dropdowns.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/forms.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/forms.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/glyphicons.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/glyphicons.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/grid.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/grid.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/input-groups.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/input-groups.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/jumbotron.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/jumbotron.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/labels.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/labels.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/list-group.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/list-group.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/media.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/media.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/mixins.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/mixins.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/modals.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/modals.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/navbar.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/navbar.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/navs.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/navs.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/normalize.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/normalize.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/pager.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/pager.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/pagination.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/pagination.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/panels.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/panels.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/popovers.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/popovers.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/print.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/print.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/progress-bars.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/progress-bars.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/responsive-utilities.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/responsive-utilities.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/scaffolding.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/scaffolding.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/tables.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/tables.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/theme.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/theme.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/thumbnails.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/thumbnails.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/tooltip.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/tooltip.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/type.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/type.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/utilities.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/utilities.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/variables.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/variables.less
	cp src/esp/proto/components/bootstrap/client/lib/bootstrap/less/wells.less $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/client/lib/bootstrap/less/wells.less
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap"
	cp src/esp/proto/components/bootstrap/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/bootstrap/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/css"
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/css/font-awesome-ie7.css $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/css/font-awesome-ie7.css
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/css/font-awesome-ie7.min.css $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/css/font-awesome-ie7.min.css
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/css/font-awesome.css $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/css/font-awesome.css
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/css/font-awesome.min.css $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/css/font-awesome.min.css
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/font"
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.eot $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.eot
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.svg $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.svg
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.ttf $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.ttf
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.woff $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/font/fontawesome-webfont.woff
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/font/FontAwesome.otf $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/font/FontAwesome.otf
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/less"
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/bootstrap.less $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/less/bootstrap.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/core.less $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/less/core.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/extras.less $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/less/extras.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/font-awesome-ie7.less $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/less/font-awesome-ie7.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/font-awesome.less $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/less/font-awesome.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/icons.less $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/less/icons.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/mixins.less $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/less/mixins.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/path.less $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/less/path.less
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/less/variables.less $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/less/variables.less
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/scss"
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_bootstrap.scss $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_bootstrap.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_core.scss $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_core.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_extras.scss $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_extras.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_icons.scss $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_icons.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_mixins.scss $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_mixins.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_path.scss $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_path.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_variables.scss $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/scss/_variables.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/font-awesome-ie7.scss $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/scss/font-awesome-ie7.scss
	cp src/esp/proto/components/font-awesome/client/lib/font-awesome/scss/font-awesome.scss $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/client/lib/font-awesome/scss/font-awesome.scss
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome"
	cp src/esp/proto/components/font-awesome/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/font-awesome/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/html5shiv/client/lib/html5shiv"
	cp src/esp/proto/components/html5shiv/client/lib/html5shiv/html5shiv.js $(BIT_VAPP_PREFIX)/esp/proto/components/html5shiv/client/lib/html5shiv/html5shiv.js
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/html5shiv"
	cp src/esp/proto/components/html5shiv/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/html5shiv/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/jquery/client/lib/jquery"
	cp src/esp/proto/components/jquery/client/lib/jquery/jquery.js $(BIT_VAPP_PREFIX)/esp/proto/components/jquery/client/lib/jquery/jquery.js
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/jquery"
	cp src/esp/proto/components/jquery/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/jquery/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc"
	cp src/esp/proto/components/legacy-mvc/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/layouts"
	cp src/esp/proto/components/legacy-mvc/layouts/default.esp $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/layouts/default.esp
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/css"
	cp src/esp/proto/components/legacy-mvc/static/css/all.css $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/css/all.css
	cp src/esp/proto/components/legacy-mvc/static/css/all.less $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/css/all.less
	cp src/esp/proto/components/legacy-mvc/static/css/app.less $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/css/app.less
	cp src/esp/proto/components/legacy-mvc/static/css/esp.less $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/css/esp.less
	cp src/esp/proto/components/legacy-mvc/static/css/more.less $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/css/more.less
	cp src/esp/proto/components/legacy-mvc/static/css/normalize.less $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/css/normalize.less
	cp src/esp/proto/components/legacy-mvc/static/css/theme.less $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/css/theme.less
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/images"
	cp src/esp/proto/components/legacy-mvc/static/images/banner.jpg $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/images/banner.jpg
	cp src/esp/proto/components/legacy-mvc/static/images/favicon.ico $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/images/favicon.ico
	cp src/esp/proto/components/legacy-mvc/static/images/splash.jpg $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/images/splash.jpg
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static"
	cp src/esp/proto/components/legacy-mvc/static/index.esp $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/index.esp
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/lib"
	cp src/esp/proto/components/legacy-mvc/static/lib/html5shiv.js $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/lib/html5shiv.js
	cp src/esp/proto/components/legacy-mvc/static/lib/jquery.esp.js $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/lib/jquery.esp.js
	cp src/esp/proto/components/legacy-mvc/static/lib/jquery.js $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/lib/jquery.js
	cp src/esp/proto/components/legacy-mvc/static/lib/jquery.simplemodal.js $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/lib/jquery.simplemodal.js
	cp src/esp/proto/components/legacy-mvc/static/lib/jquery.tablesorter.js $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/lib/jquery.tablesorter.js
	cp src/esp/proto/components/legacy-mvc/static/lib/less.js $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/lib/less.js
	cp src/esp/proto/components/legacy-mvc/static/lib/respond.js $(BIT_VAPP_PREFIX)/esp/proto/components/legacy-mvc/static/lib/respond.js
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/less/client/lib/less"
	cp src/esp/proto/components/less/client/lib/less/less.js $(BIT_VAPP_PREFIX)/esp/proto/components/less/client/lib/less/less.js
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/less"
	cp src/esp/proto/components/less/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/less/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/more/client/css"
	cp src/esp/proto/components/more/client/css/more.less $(BIT_VAPP_PREFIX)/esp/proto/components/more/client/css/more.less
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/more"
	cp src/esp/proto/components/more/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/more/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/normalize/client/css"
	cp src/esp/proto/components/normalize/client/css/normalize.less $(BIT_VAPP_PREFIX)/esp/proto/components/normalize/client/css/normalize.less
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/normalize"
	cp src/esp/proto/components/normalize/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/normalize/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/respond/client/lib/respond"
	cp src/esp/proto/components/respond/client/lib/respond/respond.js $(BIT_VAPP_PREFIX)/esp/proto/components/respond/client/lib/respond/respond.js
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/respond"
	cp src/esp/proto/components/respond/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/respond/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/components/server"
	cp src/esp/proto/components/server/app.conf $(BIT_VAPP_PREFIX)/esp/proto/components/server/app.conf
	cp src/esp/proto/components/server/appweb.conf $(BIT_VAPP_PREFIX)/esp/proto/components/server/appweb.conf
	cp src/esp/proto/components/server/config.json $(BIT_VAPP_PREFIX)/esp/proto/components/server/config.json
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/templates/angular-mvc"
	cp src/esp/proto/templates/angular-mvc/controller.c $(BIT_VAPP_PREFIX)/esp/proto/templates/angular-mvc/controller.c
	cp src/esp/proto/templates/angular-mvc/controller.js $(BIT_VAPP_PREFIX)/esp/proto/templates/angular-mvc/controller.js
	cp src/esp/proto/templates/angular-mvc/edit.html $(BIT_VAPP_PREFIX)/esp/proto/templates/angular-mvc/edit.html
	cp src/esp/proto/templates/angular-mvc/list.html $(BIT_VAPP_PREFIX)/esp/proto/templates/angular-mvc/list.html
	cp src/esp/proto/templates/angular-mvc/model.js $(BIT_VAPP_PREFIX)/esp/proto/templates/angular-mvc/model.js
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/templates/legacy-mvc"
	cp src/esp/proto/templates/legacy-mvc/controller.c $(BIT_VAPP_PREFIX)/esp/proto/templates/legacy-mvc/controller.c
	cp src/esp/proto/templates/legacy-mvc/edit.html $(BIT_VAPP_PREFIX)/esp/proto/templates/legacy-mvc/edit.html
	cp src/esp/proto/templates/legacy-mvc/list.html $(BIT_VAPP_PREFIX)/esp/proto/templates/legacy-mvc/list.html
	mkdir -p "$(BIT_VAPP_PREFIX)/esp/proto/templates/server"
	cp src/esp/proto/templates/server/app.c $(BIT_VAPP_PREFIX)/esp/proto/templates/server/app.c
	cp src/esp/proto/templates/server/controller.c $(BIT_VAPP_PREFIX)/esp/proto/templates/server/controller.c
	cp src/esp/proto/templates/server/migration.c $(BIT_VAPP_PREFIX)/esp/proto/templates/server/migration.c
endif
ifeq ($(BIT_PACK_ESP),1)
	cp $(CONFIG)/bin/esp.conf $(BIT_VAPP_PREFIX)/bin/esp.conf
endif
	mkdir -p "$(BIT_WEB_PREFIX)/bench"
	cp src/server/web/bench/1b.html $(BIT_WEB_PREFIX)/bench/1b.html
	cp src/server/web/bench/4k.html $(BIT_WEB_PREFIX)/bench/4k.html
	cp src/server/web/bench/64k.html $(BIT_WEB_PREFIX)/bench/64k.html
	mkdir -p "$(BIT_WEB_PREFIX)"
	cp src/server/web/favicon.ico $(BIT_WEB_PREFIX)/favicon.ico
	mkdir -p "$(BIT_WEB_PREFIX)/icons"
	cp src/server/web/icons/back.gif $(BIT_WEB_PREFIX)/icons/back.gif
	cp src/server/web/icons/blank.gif $(BIT_WEB_PREFIX)/icons/blank.gif
	cp src/server/web/icons/compressed.gif $(BIT_WEB_PREFIX)/icons/compressed.gif
	cp src/server/web/icons/folder.gif $(BIT_WEB_PREFIX)/icons/folder.gif
	cp src/server/web/icons/parent.gif $(BIT_WEB_PREFIX)/icons/parent.gif
	cp src/server/web/icons/space.gif $(BIT_WEB_PREFIX)/icons/space.gif
	cp src/server/web/icons/text.gif $(BIT_WEB_PREFIX)/icons/text.gif
	cp src/server/web/iehacks.css $(BIT_WEB_PREFIX)/iehacks.css
	mkdir -p "$(BIT_WEB_PREFIX)/images"
	cp src/server/web/images/banner.jpg $(BIT_WEB_PREFIX)/images/banner.jpg
	cp src/server/web/images/bottomShadow.jpg $(BIT_WEB_PREFIX)/images/bottomShadow.jpg
	cp src/server/web/images/shadow.jpg $(BIT_WEB_PREFIX)/images/shadow.jpg
	cp src/server/web/index.html $(BIT_WEB_PREFIX)/index.html
	cp src/server/web/min-index.html $(BIT_WEB_PREFIX)/min-index.html
	cp src/server/web/print.css $(BIT_WEB_PREFIX)/print.css
	cp src/server/web/screen.css $(BIT_WEB_PREFIX)/screen.css
	mkdir -p "$(BIT_WEB_PREFIX)/test"
	cp src/server/web/test/bench.html $(BIT_WEB_PREFIX)/test/bench.html
	cp src/server/web/test/test.cgi $(BIT_WEB_PREFIX)/test/test.cgi
	cp src/server/web/test/test.ejs $(BIT_WEB_PREFIX)/test/test.ejs
	cp src/server/web/test/test.esp $(BIT_WEB_PREFIX)/test/test.esp
	cp src/server/web/test/test.html $(BIT_WEB_PREFIX)/test/test.html
	cp src/server/web/test/test.php $(BIT_WEB_PREFIX)/test/test.php
	cp src/server/web/test/test.pl $(BIT_WEB_PREFIX)/test/test.pl
	cp src/server/web/test/test.py $(BIT_WEB_PREFIX)/test/test.py
	mkdir -p "$(BIT_WEB_PREFIX)/test"
	cp src/server/web/test/test.cgi $(BIT_WEB_PREFIX)/test/test.cgi
	chmod 755 "$(BIT_WEB_PREFIX)/test/test.cgi"
	cp src/server/web/test/test.pl $(BIT_WEB_PREFIX)/test/test.pl
	chmod 755 "$(BIT_WEB_PREFIX)/test/test.pl"
	cp src/server/web/test/test.py $(BIT_WEB_PREFIX)/test/test.py
	chmod 755 "$(BIT_WEB_PREFIX)/test/test.py"
	mkdir -p "$(BIT_ETC_PREFIX)"
	cp src/server/mime.types $(BIT_ETC_PREFIX)/mime.types
	cp src/server/self.crt $(BIT_ETC_PREFIX)/self.crt
	cp src/server/self.key $(BIT_ETC_PREFIX)/self.key
ifeq ($(BIT_PACK_PHP),1)
	cp src/server/php.ini $(BIT_ETC_PREFIX)/php.ini
endif
	cp src/server/appweb.conf $(BIT_ETC_PREFIX)/appweb.conf
	cp src/server/sample.conf $(BIT_ETC_PREFIX)/sample.conf
	cp src/server/self.crt $(BIT_ETC_PREFIX)/self.crt
	cp src/server/self.key $(BIT_ETC_PREFIX)/self.key
	mkdir -p "$(BIT_VAPP_PREFIX)/inc"
	cp $(CONFIG)/inc/bit.h $(BIT_VAPP_PREFIX)/inc/bit.h
	mkdir -p "$(BIT_INC_PREFIX)/appweb"
	rm -f "$(BIT_INC_PREFIX)/appweb/bit.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/bit.h" "$(BIT_INC_PREFIX)/appweb/bit.h"
	cp src/bitos.h $(BIT_VAPP_PREFIX)/inc/bitos.h
	rm -f "$(BIT_INC_PREFIX)/appweb/bitos.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/bitos.h" "$(BIT_INC_PREFIX)/appweb/bitos.h"
	cp src/appweb.h $(BIT_VAPP_PREFIX)/inc/appweb.h
	rm -f "$(BIT_INC_PREFIX)/appweb/appweb.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/appweb.h" "$(BIT_INC_PREFIX)/appweb/appweb.h"
	cp src/customize.h $(BIT_VAPP_PREFIX)/inc/customize.h
	rm -f "$(BIT_INC_PREFIX)/appweb/customize.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/customize.h" "$(BIT_INC_PREFIX)/appweb/customize.h"
	cp src/deps/est/est.h $(BIT_VAPP_PREFIX)/inc/est.h
	rm -f "$(BIT_INC_PREFIX)/appweb/est.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/est.h" "$(BIT_INC_PREFIX)/appweb/est.h"
	cp src/deps/http/http.h $(BIT_VAPP_PREFIX)/inc/http.h
	rm -f "$(BIT_INC_PREFIX)/appweb/http.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/http.h" "$(BIT_INC_PREFIX)/appweb/http.h"
	cp src/deps/mpr/mpr.h $(BIT_VAPP_PREFIX)/inc/mpr.h
	rm -f "$(BIT_INC_PREFIX)/appweb/mpr.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/mpr.h" "$(BIT_INC_PREFIX)/appweb/mpr.h"
	cp src/deps/pcre/pcre.h $(BIT_VAPP_PREFIX)/inc/pcre.h
	rm -f "$(BIT_INC_PREFIX)/appweb/pcre.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/pcre.h" "$(BIT_INC_PREFIX)/appweb/pcre.h"
	cp src/deps/sqlite/sqlite3.h $(BIT_VAPP_PREFIX)/inc/sqlite3.h
	rm -f "$(BIT_INC_PREFIX)/appweb/sqlite3.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/sqlite3.h" "$(BIT_INC_PREFIX)/appweb/sqlite3.h"
ifeq ($(BIT_PACK_ESP),1)
	cp src/esp/edi.h $(BIT_VAPP_PREFIX)/inc/edi.h
	rm -f "$(BIT_INC_PREFIX)/appweb/edi.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/edi.h" "$(BIT_INC_PREFIX)/appweb/edi.h"
	cp src/esp/esp.h $(BIT_VAPP_PREFIX)/inc/esp.h
	rm -f "$(BIT_INC_PREFIX)/appweb/esp.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/esp.h" "$(BIT_INC_PREFIX)/appweb/esp.h"
	cp src/esp/mdb.h $(BIT_VAPP_PREFIX)/inc/mdb.h
	rm -f "$(BIT_INC_PREFIX)/appweb/mdb.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/mdb.h" "$(BIT_INC_PREFIX)/appweb/mdb.h"
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
	cp src/deps/ejs/ejs.h $(BIT_VAPP_PREFIX)/inc/ejs.h
	rm -f "$(BIT_INC_PREFIX)/appweb/ejs.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/ejs.h" "$(BIT_INC_PREFIX)/appweb/ejs.h"
	cp src/deps/ejs/ejs.slots.h $(BIT_VAPP_PREFIX)/inc/ejs.slots.h
	rm -f "$(BIT_INC_PREFIX)/appweb/ejs.slots.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/ejs.slots.h" "$(BIT_INC_PREFIX)/appweb/ejs.slots.h"
	cp src/deps/ejs/ejsByteGoto.h $(BIT_VAPP_PREFIX)/inc/ejsByteGoto.h
	rm -f "$(BIT_INC_PREFIX)/appweb/ejsByteGoto.h"
	ln -s "$(BIT_VAPP_PREFIX)/inc/ejsByteGoto.h" "$(BIT_INC_PREFIX)/appweb/ejsByteGoto.h"
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
	cp $(CONFIG)/bin/ejs.mod $(BIT_VAPP_PREFIX)/bin/ejs.mod
endif
	mkdir -p "$(BIT_VAPP_PREFIX)/doc/man1"
	cp doc/man/appman.1 $(BIT_VAPP_PREFIX)/doc/man1/appman.1
	mkdir -p "$(BIT_MAN_PREFIX)/man1"
	rm -f "$(BIT_MAN_PREFIX)/man1/appman.1"
	ln -s "$(BIT_VAPP_PREFIX)/doc/man1/appman.1" "$(BIT_MAN_PREFIX)/man1/appman.1"
	cp doc/man/appweb.1 $(BIT_VAPP_PREFIX)/doc/man1/appweb.1
	rm -f "$(BIT_MAN_PREFIX)/man1/appweb.1"
	ln -s "$(BIT_VAPP_PREFIX)/doc/man1/appweb.1" "$(BIT_MAN_PREFIX)/man1/appweb.1"
	cp doc/man/appwebMonitor.1 $(BIT_VAPP_PREFIX)/doc/man1/appwebMonitor.1
	rm -f "$(BIT_MAN_PREFIX)/man1/appwebMonitor.1"
	ln -s "$(BIT_VAPP_PREFIX)/doc/man1/appwebMonitor.1" "$(BIT_MAN_PREFIX)/man1/appwebMonitor.1"
	cp doc/man/authpass.1 $(BIT_VAPP_PREFIX)/doc/man1/authpass.1
	rm -f "$(BIT_MAN_PREFIX)/man1/authpass.1"
	ln -s "$(BIT_VAPP_PREFIX)/doc/man1/authpass.1" "$(BIT_MAN_PREFIX)/man1/authpass.1"
	cp doc/man/esp.1 $(BIT_VAPP_PREFIX)/doc/man1/esp.1
	rm -f "$(BIT_MAN_PREFIX)/man1/esp.1"
	ln -s "$(BIT_VAPP_PREFIX)/doc/man1/esp.1" "$(BIT_MAN_PREFIX)/man1/esp.1"
	cp doc/man/http.1 $(BIT_VAPP_PREFIX)/doc/man1/http.1
	rm -f "$(BIT_MAN_PREFIX)/man1/http.1"
	ln -s "$(BIT_VAPP_PREFIX)/doc/man1/http.1" "$(BIT_MAN_PREFIX)/man1/http.1"
	cp doc/man/makerom.1 $(BIT_VAPP_PREFIX)/doc/man1/makerom.1
	rm -f "$(BIT_MAN_PREFIX)/man1/makerom.1"
	ln -s "$(BIT_VAPP_PREFIX)/doc/man1/makerom.1" "$(BIT_MAN_PREFIX)/man1/makerom.1"
	cp doc/man/manager.1 $(BIT_VAPP_PREFIX)/doc/man1/manager.1
	rm -f "$(BIT_MAN_PREFIX)/man1/manager.1"
	ln -s "$(BIT_VAPP_PREFIX)/doc/man1/manager.1" "$(BIT_MAN_PREFIX)/man1/manager.1"
	mkdir -p "$(BIT_ROOT_PREFIX)/etc/init.d"
	cp package/linux/appweb.init $(BIT_ROOT_PREFIX)/etc/init.d/appweb
	[ `id -u` = 0 ] && chown root:root "$(BIT_ROOT_PREFIX)/etc/init.d/appweb"; true
	chmod 755 "$(BIT_ROOT_PREFIX)/etc/init.d/appweb"
	echo 'set LOG_DIR "$(BIT_LOG_PREFIX)"\nset CACHE_DIR "$(BIT_CACHE_PREFIX)"\nDocuments "$(BIT_WEB_PREFIX)\nListen 80\nListenSecure 443\n' >$(BIT_ETC_PREFIX)/install.conf

#
#   start
#
DEPS_94 += compile
DEPS_94 += stop

start: $(DEPS_94)
	./$(CONFIG)/bin/appman install enable start

#
#   install
#
DEPS_95 += compile
DEPS_95 += stop
DEPS_95 += installBinary
DEPS_95 += start

install: $(DEPS_95)
	


#
#   uninstall
#
DEPS_96 += build
DEPS_96 += compile
DEPS_96 += stop

uninstall: $(DEPS_96)
	rm -f "$(BIT_ETC_PREFIX)/appweb.conf"
	rm -f "$(BIT_ETC_PREFIX)/esp.conf"
	rm -f "$(BIT_ETC_PREFIX)/mine.types"
	rm -f "$(BIT_ETC_PREFIX)/install.conf"
	rm -fr "$(BIT_INC_PREFIX)/appweb"
	rm -fr "$(BIT_WEB_PREFIX)"
	rm -fr "$(BIT_SPOOL_PREFIX)"
	rm -fr "$(BIT_CACHE_PREFIX)"
	rm -fr "$(BIT_LOG_PREFIX)"
	rm -fr "$(BIT_VAPP_PREFIX)"
	rmdir -p "$(BIT_ETC_PREFIX)" 2>/dev/null ; true
	rmdir -p "$(BIT_WEB_PREFIX)" 2>/dev/null ; true
	rmdir -p "$(BIT_LOG_PREFIX)" 2>/dev/null ; true
	rmdir -p "$(BIT_SPOOL_PREFIX)" 2>/dev/null ; true
	rmdir -p "$(BIT_CACHE_PREFIX)" 2>/dev/null ; true
	rm -f "$(BIT_APP_PREFIX)/latest"
	rmdir -p "$(BIT_APP_PREFIX)" 2>/dev/null ; true

#
#   genslink
#
genslink: $(DEPS_97)
	cd src/server; esp --static --genlink slink.c --flat compile ; cd ../..

#
#   run
#
DEPS_98 += compile

run: $(DEPS_98)
	cd src/server; sudo ../../$(CONFIG)/bin/appweb -v ; cd ../..

