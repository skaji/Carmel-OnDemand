package Carmel::OnDemand::INC;
use strict;
use warnings;
use B; # XXX
use Carmel::App;
use Carmel::Repository;

use constant DEBUG => $ENV{PERL_CARMEL_ONDEMAND_DEBUG};

my $SKIP = -t STDERR ? "\e[33mSKIP\e[m" : "SKIP";
my $LOAD = -t STDERR ? "\e[32mLOAD\e[m" : "LOAD";
my $NOTE = -t STDERR ? "\e[34mNOTE\e[m" : "NOTE";

sub new {
    my $class = shift;
    my $app = Carmel::App->new;
    my $repo = Carmel::Repository->new(path => $app->repository_base->child('builds'));
    bless { repo => $repo }, $class;
}

sub Carmel::OnDemand::INC::INC {
    my ($self, $file) = @_;
    my $package = $file;
    $package =~ s/\.pm//; $package =~ s{/}{::}g;
    my @artifact = $self->{repo}->find_all($package, 0);
    if (!@artifact) {
        DEBUG and warn "Carmel::OnDemand: $SKIP $file\n";
        return;
    }
    my $artifact;
    if (@artifact == 1) {
        $artifact = $artifact[0];
    } else {
        DEBUG and do {
            warn "Carmel::OnDemand: $NOTE found multiple artifacts for $file\n";
            warn "Carmel::OnDemand: $NOTE $file in @{[$_->path]}\n" for @artifact;
        };
        ($artifact) = sort { $b->dist_version <=> $a->dist_version } @artifact;
    }
    my @libs = $artifact->nonempty_libs;
    my ($lib) = grep { -f } map { $_->child($file) } @libs;
    if ($lib and open my $fh, "<", $lib) {
        DEBUG and warn "Carmel::OnDemand: $LOAD $file from $lib\n";
        $INC{$file} = $lib->stringify;
        unshift @INC, map { $_->stringify } @libs;
        return $fh;
    } else {
        warn "Carmel::OnDemand internal error, ", $lib ? "$lib: $!" : "can't find $file in @libs";
        return;
    }
}

INIT {
    DEBUG and do {
        warn "Carmel::OnDemand: \@INC (INIT phase):\n";
        warn "Carmel::OnDemand:   $_\n" for @INC;
    }
}

1;
