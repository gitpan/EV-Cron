#######
##
##----- LOSYME
##----- EV::Cron
##----- Add crontab watcher into EV 
##----- 03_api.t
##
########################################################################################################################

use strict;
use warnings;

use Test::More;
my $tests;
plan tests => $tests;

use EV::Cron;

BEGIN { $tests += 2; }

ok(defined $EV::Cron::VERSION);
ok($EV::Cron::VERSION =~ /^\d{1}.\d{2}$/);

BEGIN { $tests += 1; }

can_ok('EV::Cron', qw(cron cron_ns));

####### END ############################################################################################################
