VIMDIR=/usr/share/vim
ADDONS=${VIMDIR}/addons
REGISTRY=${VIMDIR}/registry

all:

install:
	mkdir -pv ${ADDONS}/ftdetect
	cp -v ftdetect/conceal.vim ${ADDONS}/ftdetect/conceal.vim
	mkdir -pv ${ADDONS}/ftplugin
	cp -v ftplugin/conceal.vim ${ADDONS}/ftplugin/markdown_c.vim
	mkdir -pv ${ADDONS}/syntax
	cp -v syntax/conceal.vim ${ADDONS}/syntax/markdown_c.vim
	mkdir -pv ${REGISTRY}
	cp -v registry/conceal.yaml ${REGISTRY}/markdown_c.yaml
