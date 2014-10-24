package Zabbix::Reporter::Web::Plugin::History;
{
  $Zabbix::Reporter::Web::Plugin::History::VERSION = '0.07';
}
BEGIN {
  $Zabbix::Reporter::Web::Plugin::History::AUTHORITY = 'cpan:TEX';
}
# ABSTRACT: List all triggers

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
use Template;

# extends ...
extends 'Zabbix::Reporter::Web::Plugin';
# has ...
# with ...
# initializers ...
sub _init_fields { return [qw(limit offset refresh age num)]; }

sub _init_alias { return 'list_history'; }

# your code here ...
sub execute {
    my $self = shift;
    my $request = shift;

    my $refresh  = $request->{'refresh'} || 360;
    my $age      = $request->{'age'}     || 30;
    my $num      = $request->{'num'}     || 100;
    my $triggers = $self->zr()->history($age,$num);

    my $body;
    $self->tt()->process(
        'list_history.tpl',
        {
            'triggers' => $triggers,
            'refresh'  => $refresh,
            'title'    => 'Zabbix Trigger History',
            'age'      => $age,
            'num'      => $num,
        },
        \$body,
    ) or $self->logger()->log( message => 'TT error: '.$self->tt()->error, level => 'warning', );

    return [ 200, [
      'Content-Type', 'text/html',
      'Cache-Control', 'max-age='.($refresh-1).', private',
    ], [$body] ];
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Zabbix::Reporter::Web::Plugin::History - List all triggers

=head1 METHODS

=head2 execute

List all active triggers.

=head1 NAME

Zabbix::Reporter::Web::API::Plugin::History - List all triggers

=head1 AUTHOR

Dominik Schulz <dominik.schulz@gauner.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Dominik Schulz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
