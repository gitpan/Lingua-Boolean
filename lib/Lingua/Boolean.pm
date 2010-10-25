use strict;
use warnings;
# use diagnostics;
# use Data::Dumper;
use 5.0100;

package Lingua::Boolean;
BEGIN {
  $Lingua::Boolean::VERSION = '0.002';
}
# ABSTRACT: comprehensively parse boolean response strings
# ENCODING: utf-8

use Carp;
use boolean 0.21 qw(true false);


use Exporter qw(import);
our @EXPORT = qw(boolean);


sub new {
    my $class = shift;
    my $lang  = shift;

    use Module::Pluggable search_path => [__PACKAGE__], require => 1;

    my $objects;
    BUILD: foreach my $plugin ( __PACKAGE__->plugins() ) {
        my $obj = $plugin->new();
        next BUILD if (defined $lang and $obj->{LANG} ne $lang);

        $objects->{ $obj->{LANG} } = $obj;
    }

    my $self = {
        languages => $objects,
        lang      => $lang,
    };
    bless $self, $class;
    return $self;
}


sub _boolean {
    my $self    = shift;
    my $to_test = shift;
    my $lang    = shift || 'en';
    _trim($to_test);

    if ($self->_looks_true($to_test, $lang)) {
        return true;
    }
    elsif ($self->_looks_false($to_test, $lang)) {
        return false;
    }
    else {
        croak "'$to_test' isn't recognizable as either true or false";
    }
}

sub boolean {
    my $self    = ref $_[0] eq __PACKAGE__ ? shift : __PACKAGE__->new($_[1]);
    my $to_test = shift;
    my $lang    = shift || $self->{lang};
    _trim($to_test);

    return $self->_boolean($to_test, $lang);
}


sub languages {
    my $self = ref $_[0] eq __PACKAGE__ ? shift : __PACKAGE__->new();

    my @long_names;
    foreach my $l (keys %{ $self->{languages} }) {
        push @long_names, $self->{languages}->{$l}->{LANGUAGE};
    }
    return @long_names;
}


sub langs {
    my $self = ref $_[0] eq __PACKAGE__ ? shift : __PACKAGE__->new();

    my @lang_codes = keys %{ $self->{languages} };
    return @lang_codes;
}


sub _looks_true {
    my $self    = shift;
    my $to_test = shift;
    my $lang    = shift || 'en';
    _trim($to_test);

    croak "I don't know anything about the language '$lang'" unless exists $self->{languages}->{$lang}->{match}->{True};
    return true if ($to_test ~~ $self->{languages}->{$lang}->{match}->{True});
    return false;
}

sub _looks_false {
    my $self    = shift;
    my $to_test = shift;
    my $lang    = shift || 'en';
    _trim($to_test);

    croak "I don't know anything about the language '$lang'" unless exists $self->{languages}->{$lang}->{match}->{False};
    return true if ($to_test ~~ $self->{languages}->{$lang}->{match}->{False});
    return false;
}

sub _trim { # http://www.perlmonks.org/?node_id=36684
    @_ = $_ if not @_ and defined wantarray;
    @_ = @_ if defined wantarray;
    for (@_ ? @_ : $_) { s/^\s+|\s+$//g }
    return wantarray ? @_ : $_[0] if defined wantarray;
}

1;



=pod

=encoding utf-8

=head1 NAME

Lingua::Boolean - comprehensively parse boolean response strings

=head1 VERSION

version 0.002

=head1 SYNOPSIS

    use Lingua::Boolean;

    # Use functional/procedural interface
    print "Do it? ";
    chomp(my $response = <>);
    if ( boolean $response ) {   # YES, y, OK, 1...
        print "OK, doing it.\n";
    }
    else {                      # no, N, 0...
        print "OK, not doing it.\n";
    }

    # Once more, with feeling
    print "Fait-le? ";
    chomp($response = <>);
    if ( boolean $response, 'fr' ) {    # OUI
        print "OK, on le fait.\n";
    }
    else {                              # non
        print "OK, on ne le fait pas.\n";
    }

    # Or, use OO interface
    my $bool = Lingua::Boolean->new('en');
    print "Do it? ";
    chomp($response = <>);
    if ($bool->boolean($response)) {
        print "OK, doing it!\n";
    }
    else {
        print "OK, not doing it.\n";
    }

=head1 DESCRIPTION

Does that string look like they said "true" or "false"? To know, you
have to check a lot of things. C<Lingua::Boolean> attempts to do that
in a single module, and do so for multiple languages.

=head1 METHODS

C<Lingua::Boolean> provides both a functional/procedural and object-oriented
interfaces. Everything described below is an object method, but can also be
called as a function. C<boolean()> is exported by default, and can be called
that way - everything else requires the fully-qualified name.

    use Lingua::Boolean;
    my @languages = Lingua::Boolean::languages();
    print boolean('yes') . "\n"; # boolean is exported by default

=head2 import

Calling C<import()> will, obviously, import subs into your namespace.
By default, C<Lingua::Boolean> imports the sub C<boolean()>. All other
subs should be accessed with the object-oriented interface, or use
the fully qualified name.

=head2 new

C<new()> creates a new C<Lingua::Boolean> object. You can optionally give it
the code for the language you'll be working with, and only that language will
be loaded. If you do so, you needn't pass the language to every call to
C<boolean()>:

    use Lingua::Boolean qw();
    my $bool = Lingua::Boolean->new('fr');
    print ($bool->boolean('oui') ? "TRUE\n" : "FALSE\n");

Otherwise, C<boolean()> accept the language code as the second parameter:

    use Lingua::Boolean qw();
    my $bool = Lingua::Boolean->new();
    print ($bool->boolean('oui', 'fr') ? "TRUE\n" : "FALSE\n");

=head2 boolean

B<C<boolean()>> tries to determine if the string I<looks> true or I<looks> false, and
returns true or false accordingly. If both tests fail, dies. By default, uses I<en>; pass
a language code as the second parameter to check another language. Croaks if the language
is unknown to C<Lingua::Boolean> (or the C<Lingua::Boolean> object, if used as an object
method).

    use Lingua::Boolean qw();
    my $bool = Lingua::Boolean->new();
    print ($bool->boolean('yes') ? "TRUE\n" : "FALSE\n");

If you specify the language in the constructor, you needn't specify it in the call to C<boolean()>:

    use Lingua::Boolean qw();
    my $bool = Lingua::Boolean->new('fr');
    print ($bool->boolean('OUI') ? "TRUE\n" : "FALSE\n");

This sub is exported by default, and can be used functionally:

    use Lingua::Boolean;
    print (boolean('yes') ? "TRUE\n" : "FALSE\n");

=head2 languages

C<languages()> returns the list of languages that C<Lingua::Boolean> knows about.

    use Lingua::Boolean;
    my @languages = Lingua::Boolean::languages(); # qw(English Français ...)

When called as an object method, returns the languages that B<that object> knows
about:

    use Lingua::Boolean qw();
    my $bool = Lingua::Boolean->new('fr');
    my @languages = $bool->languages(); # qw(Français)

=head2 langs

C<langs()> returns the list of language I<codes> that C<Lingua::Boolean> knows about.

    use Lingua::Boolean;
    my @lang_codes = Lingua::Boolean::langs(); # qw(en fr ...)

When called as an object method, returns the languages that B<that object> knows
about:

    use Lingua::Boolean qw();
    my $bool = Lingua::Boolean->new('fr');
    my @lang_codes = $bool->langs(); # qw(fr)

=head1 EXPORTS

By default, C<Lingua::Boolean> exports C<boolean()>. All other methods
must be fully qualified - or use the object-oriented interface.

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
