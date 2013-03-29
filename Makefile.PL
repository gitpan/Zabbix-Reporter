
use strict;
use warnings;

use 5.010_000;

use ExtUtils::MakeMaker 6.30;

use File::ShareDir::Install;
install_share dist => "share";


my %WriteMakefileArgs = (
  "ABSTRACT" => "The great new Zabbix::Reporter!",
  "AUTHOR" => "Dominik Schulz <dominik.schulz\@gauner.org>",
  "BUILD_REQUIRES" => {
    "Test::More" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "File::ShareDir::Install" => "0.03"
  },
  "DISTNAME" => "Zabbix-Reporter",
  "EXE_FILES" => [
    "bin/zreporter-web.psgi",
    "bin/zreporter.pl",
    "bin/zreporter-web.pl"
  ],
  "LICENSE" => "perl",
  "NAME" => "Zabbix::Reporter",
  "PREREQ_PM" => {
    "Cache::FileCache" => 0,
    "Config::Yak" => 0,
    "Config::Yak::LazyConfig" => 0,
    "Config::Yak::RequiredConfig" => 0,
    "DBI" => 0,
    "File::ShareDir" => 0,
    "Log::Tree" => 0,
    "Log::Tree::Logger" => 0,
    "Log::Tree::RequiredLogger" => 0,
    "Module::Pluggable" => 0,
    "Moose" => 0,
    "MooseX::App::Cmd" => 0,
    "MooseX::App::Cmd::Command" => 0,
    "Plack::Builder" => 0,
    "Plack::Loader" => 0,
    "Plack::Request" => 0,
    "Template" => 0,
    "Try::Tiny" => 0,
    "feature" => 0,
    "mro" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.02",
  "test" => {
    "TESTS" => "t/*.t"
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

{
package
MY;
use File::ShareDir::Install qw(postamble);
}


