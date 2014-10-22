package Lingua::Boolean::English;
# ABSTRACT: provides English rules to Lingua::Boolean
use strict;
use warnings;
use utf8;
our $VERSION = '0.006'; # VERSION



sub new {
    my $class = shift;

    my $LANG = 'en';
    my $LANGUAGE = 'English';

    my $match;
    $match->{True}  = [qr{^y(?:es)?$}i, qr{^on$}i, qr{^ok$}i, qr{^true$}i, qr{^[1-9]$}];
    $match->{False} = [qr{^no?$}i, qr{^off$}i, qr{not ?ok$}i, qr{^false$}i, qr{^0$}];

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

=encoding utf-8

=head1 NAME

Lingua::Boolean::English - provides English rules to Lingua::Boolean

=head1 VERSION

version 0.006

=head1 DESCRIPTION

This module provides rules for English to C<Lingua::Boolean>.

=head1 METHODS

=head2 new

C<new()> creates a new C<Lingua::Boolean::English> object. This is
intended for consumption by L<Lingua::Boolean> only.

=head1 SEE ALSO

L<Lingua::Boolean>

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see L<http://search.cpan.org/dist/Lingua-Boolean/>.

The development version lives at L<http://github.com/doherty/Lingua-Boolean>
and may be cloned from L<git://github.com/doherty/Lingua-Boolean.git>.
Instead of sending patches, please fork this project using the standard
git and github infrastructure.

=head1 SOURCE

The development version is on github at L<http://github.com/doherty/Lingua-Boolean>
and may be cloned from L<git://github.com/doherty/Lingua-Boolean.git>

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<https://github.com/doherty/Lingua-Boolean/issues>.

=head1 AUTHOR

Mike Doherty <doherty@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Mike Doherty.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
