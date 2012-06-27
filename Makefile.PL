#######
##
##----- LOSYME
##----- EV::Cron
##----- Add crontab watcher into EV
##----- Makefile.PL
##
########################################################################################################################

use strict;
use ExtUtils::MakeMaker;

WriteMakefile
(
      NAME             => 'EV::Cron'
    , LICENSE          => 'perl'
    , AUTHOR           => 'Loïc TROCHET <losyme@gmail.com>'
    , VERSION_FROM     => 'lib/EV/Cron.pm'
    , ABSTRACT         => 'Add crontab watcher into EV.'
    , clean            => { FILES => 'EV-Cron-*' }
    , META_MERGE       => { resources => { repository  => 'https://github.com/losyme/EV-Cron' }}
    , MIN_PERL_VERSION => '5.010'
    , BUILD_REQUIRES
      => {
          'Test::More' => 0
      }
    , PREREQ_PM
      => {
          'EV'                    => 0
        , 'DateTime'              => 0
        , 'DateTime::TimeZone'    => 0
        , 'DateTime::Event::Cron' => 0
        , 'Params::Validate'      => 0
      }
);

####### END ############################################################################################################
