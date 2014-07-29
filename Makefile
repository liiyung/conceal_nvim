VIMDIR=/usr/share/vim
ADDONS=${VIMDIR}/addons
REGISTRY=${VIMDIR}/registry

all:

install:
	mkdir -pv ${ADDONS}/ftdetect
	cp -v ftdetect/mkdc.vim ${ADDONS}/ftdetect/mkdc.vim
	mkdir -pv ${ADDONS}/ftplugin
	cp -v ftplugin/mkdc.vim ${ADDONS}/ftplugin/mkdc.vim
	mkdir -pv ${ADDONS}/syntax
	cp -v syntax/mkdc.vim ${ADDONS}/syntax/mkdc.vim
	mkdir -pv ${REGISTRY}
	cp -v registry/mkdc.yaml ${REGISTRY}/mkdc.yaml
