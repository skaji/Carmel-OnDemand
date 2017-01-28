[![Build Status](https://travis-ci.org/skaji/Carmel-OnDemand.svg?branch=master)](https://travis-ci.org/skaji/Carmel-OnDemand)

# NAME

Carmel::OnDemand - load artifacts from the Carmel centoral repository on demand

# SYNOPSIS

    > perl -MCarmel::OnDemand scirpt.pl

Or, you can use `PERL5OPT`:

    > export PERL5OPT=-MCarmel::OnDemand
    > perl script.pl

# DESCRIPTION

[Carmel](https://metacpan.org/pod/Carmel) is a next generation CPAN module manager,
which keeps the distribution builds (artifacts) in a central repository.

Carml uses `./.carmel/MySetup.pm` to pin module verions to be used.

Sometimes, you may just want to use the modules in artifacts without pinning module versions.
Then use Carmel::OnDemand.

# TODO

What if Carmel::OnDemand generates `./.carmel/MySetup.pm` or `cpanfile`/`cpanfile.snapshot`?

# DEBUGGING

Set `PERL_CARMEL_ONDEMAND_DEBUG=1`.

# AUTHOR

Shoichi Kaji <skaji@cpan.org>

# COPYRIGHT AND LICENSE

Copyright 2017 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
