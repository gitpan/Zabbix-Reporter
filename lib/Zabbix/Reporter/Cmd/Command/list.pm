package Zabbix::Reporter::Cmd::Command::list;
{
  $Zabbix::Reporter::Cmd::Command::list::VERSION = '0.06';
}
BEGIN {
  $Zabbix::Reporter::Cmd::Command::list::AUTHORITY = 'cpan:TEX';
}
# ABSTRACT: list all triggers from the CLI

use 5.010_000;
use mro 'c3';
use feature ':5.10';

use Moose;
use namespace::autoclean;

# use IO::Handle;
# use autodie;
# use MooseX::Params::Validate;
# use Carp;
# use English qw( -no_match_vars );
# use Try::Tiny;
use Data::Dumper;

# extends ...
extends 'Zabbix::Reporter::Cmd::Command';
# has ...
# with ...
# initializers ...

# your code here ...
sub execute {
    my $self = shift;

    my $triggers = $self->zr()->triggers();
    print Dumper($triggers);

    # TODO not yet implemented

    return 1;
}

sub abstract {
    return 'List all triggers';
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Zabbix::Reporter::Cmd::Command::list - list all triggers from the CLI

=head1 METHODS

=head2 execute

List all triggers.

=head2 abstract

Workaround.

=head1 NAME

Zabbix::Reporter::Cmd::Command::list - list all triggers from the CLI

=head1 AUTHOR

Dominik Schulz <dominik.schulz@gauner.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Dominik Schulz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
