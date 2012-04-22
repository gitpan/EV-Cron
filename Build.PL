#######
##
##----- LOSYME
##----- EV::Cron
##----- Add crontab watcher into EV 
##----- Build.PL
##
########################################################################################################################

use strict;
use Module::Build;

Module::Build->new(
      module_name        => 'EV::Cron' 
    , license            => 'perl' 
    , dist_author        => 'Loïc TROCHET <losyme@gmail.com>' 
    , dist_version_from  => 'lib/EV/Cron.pm'
    , add_to_cleanup     => [ 'EV-Cron-*' ]
    , configure_requires
      => {
          'Module::Build' => 0 
      }
    , build_requires
      => {
          'Test::More' => 0
      }
    , requires
      => {
          'perl'                  => 5.010
        , 'EV'                    => 0
        , 'DateTime'              => 0
        , 'DateTime::Event::Cron' => 0
        , 'Params::Validate'      => 0
      } 
)->create_build_script;

####### END ############################################################################################################
