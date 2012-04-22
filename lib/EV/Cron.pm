#######
##
##----- LOSYME
##----- EV::Cron
##----- Add crontab watcher into EV 
##----- Cron.pm
##
########################################################################################################################

package EV::Cron;

use strict;
use warnings;

our $VERSION   =   '0.01';
our $AUTHORITY = 'LOSYME';

use feature qw(state);
use EV;
use DateTime;
use DateTime::Event::Cron;
use Params::Validate qw(validate SCALAR CODEREF);

BEGIN
{
    no strict 'refs';
    foreach my $function (qw(cron cron_ns)) { *{ "EV::$function" } = *{ "EV::Cron::$function" }; }
}

##--------------------------------------------------------------------------------------------------------------------##
sub _add_watcher
{
    my %params = validate
                 (
                     @_
                 ,   {
                         start => { type =>  SCALAR }
                     ,   cron  => { type =>  SCALAR }
                     ,   cb    => { type => CODEREF }
                     }    
                 );

    my $ev_call = $params{start}
                ? 'EV::periodic'
                : 'EV::periodic_ns';
    
    no strict 'refs';
    return &$ev_call
           (
               0
           ,   0
           ,   sub ##+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
               {
                   my ($watcher, $now) = @_;
                   state $dt_event = DateTime::Event::Cron->new($params{cron});
                   return $dt_event->next(DateTime->from_epoch(epoch => $now))->epoch;
               } ##+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
           ,   $params{cb}
           );
}

##--------------------------------------------------------------------------------------------------------------------##
sub cron
{
    return _add_watcher(start => 1, cron => $_[0], cb => $_[1]);
}

##--------------------------------------------------------------------------------------------------------------------##
sub cron_ns
{
    return _add_watcher(start => 0, cron => $_[0], cb => $_[1]);
}

1;

__END__

=pod

=head1 NAME

EV::Cron - Add crontab watcher into EV.

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

    use 5.010;
    use EV;
    use EV::Cron;
    
    my @watchers;

    push @watchers, EV::cron     '*  * * * *', sub { say                           'Every minute.'; };
    push @watchers, EV::cron     '5  0 * * *', sub { say 'Five minutes after midnight, every day.'; };
    push @watchers, EV::cron_ns '15 14 1 * *', sub { say  'At 2:15pm on the first of every month.'; };
    
    EV::run;

=head1 DESCRIPTION

This module extends L<EV> by adding an easy way to specify event schedules using a crontab line format.

=head1 METHODS

=head2 EV::cron($cronspec, $callback)

Calls the callback when the event schedules using a crontab line format occurs.

=over

=item I<Parameters>

C<$cronspec> - SCALAR - The string in crontab line format L<crontab(5)>.

C<$callback> - CODEREF - The callback.

=item I<Return value>

The newly created watcher.

=back
    
=head2 EV::cron_ns($cronspec, $callback)

The C<cron_ns> variant doesn't start (activate) the newly created watcher.

=head1 SEE ALSO

L<EV>

=head1 TODO

Add some tests for version 0.02

=head1 AUTHOR

LoE<iuml>c TROCHET E<lt>losyme@gmail.comE<gt>

Repository available at L<https://github.com/losyme/EV-Cron>.

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2012 by LoE<iuml>c TROCHET.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut

####### END ############################################################################################################
