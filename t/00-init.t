use strict;
use warnings;
use utf8;
use Test::More 0.75 tests => 3;

BEGIN {
    use_ok('Lingua::Boolean', qw(boolean));
}

my @should_have_codes = (
    'en',
    'fr',
);

my @should_have_names = (
    'English',
    'Français',
);

subtest 'oo' => sub {
    plan tests => 4;
    my $bool = new_ok('Lingua::Boolean');
    can_ok($bool, qw(boolean langs languages _looks_true _looks_false _trim));
    {   # Language codes
        my @has = $bool->langs();
        is_deeply(\@has, \@should_have_codes, 'Available language codes OK');
    }

    {   # Languages names
        my @has = $bool->languages();
        is_deeply(\@has, \@should_have_names, 'Available language names OK');
    }
};

subtest 'func' => sub {
    plan tests => 2;
    {   # Language codes
        my @has = Lingua::Boolean::langs();
        is_deeply(\@has, \@should_have_codes, 'Available language codes OK');
    }

    {   # Language names
        my @has = Lingua::Boolean::languages();
        is_deeply(\@has, \@should_have_names, 'Available language names OK');
    }
};
