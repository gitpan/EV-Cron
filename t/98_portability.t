#######
##
##----- LOSYME
##----- EV::Cron
##----- Add crontab watcher into EV 
##----- 98_portability.t
##
########################################################################################################################

use strict;
use warnings;
use Test::More;

eval 'use Test::Portability::Files';
plan(skip_all => 'Test::Portability::Files required for testing filenames portability') if $@;

run_tests();

####### END ############################################################################################################
