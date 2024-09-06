#!/usr/bin/env bash

set -e

VERSION="0.4.3"
DOWNLOAD_LINK="https://github.com/juicity/juicity/releases/download"
FULL_DOWNLOAD_LINK=""
PKG_NAME=""

create_temp_dir(){
    TEMP_DIR=`mktemp -d temp.XXXXXX`
}

set_dl_link(){
    ARCH=$1
    PKG_NAME="juicity-linux-${ARCH}.zip"
    FULL_DOWNLOAD_LINK=""
    FULL_DOWNLOAD_LINK="${DOWNLOAD_LINK}/v${VERSION}/${PKG_NAME}"
}

download_pkg(){
    echo "Download ${FULL_DOWNLOAD_LINK}"
    create_temp_dir
    curl -L "${FULL_DOWNLOAD_LINK}" -o ${TEMP_DIR}/${PKG_NAME} || exit 1

}

unzip_pkg(){
    rm -rf juicity-client
    unzip -j -o "${TEMP_DIR}/${PKG_NAME}" 'juicity-client'
    rm -rf ${TEMP_DIR}
}

pack_zip(){
    local pack_name="magisk-juicity-${VERSION}-$1.zip"
    rm -rf ${pack_name}
    zip -r -o -X -ll ${pack_name} ./ -x '.git/*' -x 'LICENSE' -x 'README.md' -x 'build.sh' -x '.github/*' -x ".gitignore" -x "temp.*" -x "*.zip"
}

for arch in arm64 armv7; do
    set_dl_link ${arch}
    download_pkg
    unzip_pkg
    pack_zip ${arch}
done

