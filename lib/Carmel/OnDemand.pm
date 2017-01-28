package Carmel::OnDemand;
use strict;
use warnings;

our $VERSION = '0.001';

sub import {
    my $path = $ENV{PERL_CARMEL_PATH} || '.';
    if (-e "$path/.carmel/MySetup.pm") {
        require Carmel::Setup;
        Carmel::Setup->import;
        return;
    }
    require Carmel::OnDemand::INC;
    my $inc = Carmel::OnDemand::INC->new;
    unshift @INC, $inc;
}

1;
__END__

=encoding utf-8

=head1 NAME

Carmel::OnDemand - load artifacts from the Carmel centoral repository on demand

=head1 SYNOPSIS

  > perl -MCarmel::OnDemand scirpt.pl

Or, you can use C<PERL5OPT>:

  > export PERL5OPT=-MCarmel::OnDemand
  > perl script.pl

=head1 DESCRIPTION

L<Carmel> is a next generation CPAN module manager,
which keeps the distribution builds (artifacts) in a central repository.

Carml uses C<./.carmel/MySetup.pm> to pin module verions to be used.

Sometims, you may just want to use the modules in artifacts without pinning modules versions.
Then use Carmel::OnDemand.

=head1 TODO

What if Carmel::OnDemand generates C<./.carmel/MySetup.pm> or C<cpanfile>/C<cpanfile.snapshot>?

=head1 DEBUGGING

Set C<PERL_CARMEL_ONDEMAND_DEBUG=1>.

=head1 AUTHOR

Shoichi Kaji <skaji@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2017 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
