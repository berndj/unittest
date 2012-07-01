#!/bin/bash


CUNIT_URL="http://sourceforge.net/projects/cunit/files/latest/download"
CUNIT_PATH=$(pwd)/install
CUNIT_PACKAGE_NAME=CUnit.tar.bz2

if [ ! -d $CUNIT_PATH/include ]; then
    echo "URL=$CUNIT_URL"
    wget -O $CUNIT_PACKAGE_NAME $CUNIT_URL
    if [ $? -ne 0 ]; then
	echo "ERROR: $CUNIT_URL download failed"
	exit 1
    fi
    tar xjvf $CUNIT_PACKAGE_NAME
    pushd CUnit*
    ./configure --prefix=$CUNIT_PATH
    if [ $? -ne 0 ]; then 
	exit 1
    fi
    make install
    popd
    rm -rf CUnit*
fi

C_INCLUDE_PATH=$CUNIT_PATH/include gcc example.c -L$CUNIT_PATH/lib -Wl,-R$CUNIT_PATH/lib -lcunit -o example

./example
