#!/bin/sh

#total_files=`find data_unzip -type f -name '*.DAT' -print | wc -l`
#record_count=`find data_unzip -type f -name '*.DAT' -print0 | xargs -I '{}' -0 cat '{}' | grep '^B' | wc -l`
#echo "Loading $record_count records across $total_files files"

# archived
find \
    data_unzip/yearly/199* \
    data_unzip/yearly/2000 \
    data_unzip/yearly/2001_archived \
    -type f -name '*.DAT' -print0 | \
    xargs -I '{}' -0 cat '{}' | \
    grep '^B' | \
    sed -e 's/\\/\\\\/g' | \
    sed 's/\r$//' | \
    cut -d';' -f1-20 | \
    psql -c "COPY psi.sales_archived_raw FROM STDIN WITH DELIMITER ';' NULL '';"

# current
find \
    data_unzip/yearly/2001_current \
    data_unzip/yearly/2002 \
    data_unzip/yearly/2003 \
    data_unzip/yearly/2004 \
    data_unzip/yearly/2005 \
    data_unzip/yearly/2006 \
    data_unzip/yearly/2007 \
    data_unzip/yearly/2008 \
    data_unzip/yearly/2009 \
    data_unzip/yearly/201* \
    data_unzip/weekly \
    -type f -name '*.DAT' -print0 | \
    xargs -I '{}' -0 cat '{}' | \
    grep '^B' | \
    sed -e 's/\\/\\\\/g' | \
    sed 's/\r$//' | \
    cut -d';' -f1-24 | \
    psql -c "COPY psi.sales_current_raw FROM STDIN WITH DELIMITER ';' NULL '';"
