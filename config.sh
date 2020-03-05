#!/bin/bash
#
# Constants and config

curLang=jbo                     # Language code to use as an ouput filename. Note that, generally speaking, languages have their locale attached (en_GB, fr_FR, etc.).
version=`date "+%Y.%m.%d"`	# Version of the dictionary
w1="wordlist_local"             # Local wordlist file, storing additional words regarding to the official list from the web. No problem if this causes duplicates: they will be removed.
w2="wordlist_cache.html"        # Intermediate file to store the web page containing worlist to process/filter. This is used as a cache.
webListRefresh="3600*24*7"      # Seconds before updating the list from the web (default: 1 week)
oxtFilePrefix="libreoffice-openoffice-lojban-dictionary-$curLang-v"     # Prefix used to generate file name of the OXT file (LibreOffice / OpenOffice extension)
oxtFileName="$oxtFilePrefix$version.oxt"                                # OXT file name
xpiFilePrefix="firefox-legacy-thunderbird-lojban-dictionary-$curLang-v" # Ditto, for Firefox <43
xpiFileName="$xpiFilePrefix$version.xpi"                                # ...
xpi43FilePrefix="firefox-lojban-dictionary-$curLang-v"                  # Ditto, for Firefox >=43
xpi43FileName="$xpi43FilePrefix$version.xpi"                            # ...
verbose=1                       # Verbosity level (0..2)

# Internals
is64="$(uname -m)"
if [ "$is64" = "x86_64" ]; then
	binSuffix="-x64"
	is64=1;
else
	binSuffix="-x32"
	is64=0;
fi

binSuffix="$binSuffix-$(lscpu | sed -En 's/^.* ([^ ]* Endian)$/\1/p' | sed 's/ /_/')"
