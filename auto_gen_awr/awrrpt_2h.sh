##########################################
#
# App name: auto generate awr report (2h)
# Version: 0.1.0
# Last update: 2018/06/13
# Author: WENG Yan (yan.weng@gemalto.com)
#
##########################################

#!/bin/bash
whereami=$(cd `dirname $0`; pwd)

export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=/opt/oracle/11.2.0
export ORACLE_SID=TSMDB
export PATH=$PATH:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch
awr_report_path='/var/tmp/auto_gen_awr/report'

datetime=`date  +%Y%m%d%H`
cd ${awr_report_path}
$ORACLE_HOME/bin/sqlplus / as sysdba @${whereami}/awrrpt_2h.sql
exit
