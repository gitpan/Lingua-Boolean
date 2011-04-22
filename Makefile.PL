
use strict;
use warnings;

BEGIN { require 5.010001; }

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'comprehensively parse boolean response strings',
  'AUTHOR' => 'Mike Doherty <doherty@cpan.org>',
  'BUILD_REQUIRES' => {
    'File::Find' => '0',
    'File::Temp' => '0',
    'Test::Builder' => '0.94',
    'Test::More' => '0.94'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Lingua-Boolean',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Lingua::Boolean',
  'PREREQ_PM' => {
    'Carp' => '0',
    'Exporter' => '0',
    'Module::Pluggable' => '0',
    'String::Trim' => '0',
    'boolean' => '0.21',
    'utf8' => '0'
  },
  'VERSION' => '0.006',
  'test' => {
    'TESTS' => 't/*.t t/lang/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



