use strict;
use warnings;
use utf8;
package Lingua::Boolean::French;
BEGIN {
  $Lingua::Boolean::French::VERSION = '0.001';
}
# ABSTRACT: provides French rules to Lingua::Boolean



sub new {
    my $class = shift;

    my $LANG = 'fr';
    my $LANGUAGE = 'Français';

    my $match;
    $match->{True}  = [qr{^oui$}i, qr{^ok$}i, qr{^vraie?$}i, qr{^[1-9]$}];
    $match->{False} = [qr{^n(?:on?)?$}i, qr{^faux$}i, qr{^0$}];

    my $self = {
        LANG => $LANG,
        LANGUAGE => $LANGUAGE,
        match => $match,
    };
    bless $self, $class;
    return $self;
}


1;



=pod

=head1 NAME

Lingua::Boolean::French - provides French rules to Lingua::Boolean

=head1 VERSION

version 0.001

=head1 DESCRIPTION

This module provides rules for French to L<Lingua::Boolean>.

=head1 METHODS

=head2 new

C<new()> creates a new C<Lingua::Boolean::French> object. This is
intended for consumption by L<Lingua::Boolean> only.

=head1 SEE ALSO

L<Lingua::Boolean>

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see L<http://search.cpan.org/dist/Lingua-Boolean/>.

The development version lives at L<http://github.com/doherty/Lingua-Boolean>
and may be cloned from L<git://github.com/doherty/Lingua-Boolean>.
Instead of sending patches, please fork this project using the standard
git and github infrastructure.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://github.com/doherty/Lingua-Boolean/issues>.

=head1 AUTHOR

Mike Doherty <doherty@cs.dal.ca>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2010 by Mike Doherty.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut


__END__
