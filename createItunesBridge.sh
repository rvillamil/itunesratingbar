#!/bin/bash
#
# Copyright (C) Rodrigo Villamil Perez 2018
# Fichero: createItunesBridge.sh
# Autor: Rodrigo Villamil Pérez
# Fecha: 23/12/18
#

# CONSTANTS
OUTPUT_DIR="iTunesRatingBar/bridge/"
TOOLS_DIR=$(PWD)
#
# ${1}: app name
#
function createHeaderFiles() {
    app_name="${1}"
    output="${OUTPUT_DIR}"

    echo "* Creating objective-C headers for app '${app_name}' in '${output}' directory ..."
    cd ${output} > /dev/null 2>&1
    sdef /System/Applications/${app_name}.app > ${app_name}.sdef
    sdp -fh --basename ${app_name} ${app_name}.sdef
    cd - > /dev/null 2>&1

    return 0
}

#
# ${1}: app name
#
function createHeaderSwiftFiles() {  
    app_name="${1}"
    output="${OUTPUT_DIR}"
    echo "* Creating swift headers with for app '${app_name}' in '${output}' directory ..."
    cd ${output} > /dev/null 2>&1
    python ${TOOLS_DIR}/sbhc.py ${app_name}.h &&
    python ${TOOLS_DIR}/sbsc.py ${app_name}.sdef
    cd - > /dev/null 2>&1
  
    return 0
}

#
# -- Main
#
createHeaderFiles "Music" &&
createHeaderSwiftFiles "Music"
