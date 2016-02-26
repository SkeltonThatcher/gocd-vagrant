#!/bin/bash
REPORT_FILE="security_tests_results.html"
source ~/.bash_profile && export SQLMAP_PATH=/home/vagrant/sqlmap/sqlmap.py && gauntlt --format=html > ${REPORT_FILE}
