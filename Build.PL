
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.3601",
    "Test::Builder" => "0.94",
    "Test::More" => "0.94"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "comprehensively parse boolean response strings",
  "dist_author" => [
    "Mike Doherty <doherty\@cpan.org>"
  ],
  "dist_name" => "Lingua-Boolean",
  "dist_version" => "0.007",
  "license" => "perl",
  "module_name" => "Lingua::Boolean",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Carp" => 0,
    "Exporter" => 0,
    "Module::Pluggable" => 0,
    "String::Trim" => 0,
    "boolean" => "0.21",
    "perl" => "5.010001",
    "strict" => 0,
    "utf8" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
