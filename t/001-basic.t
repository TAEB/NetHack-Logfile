use strict;
use warnings;
use Test::More;
use NetHack::Logfile::Entry;

my %values = (
    version       => '3.4.3',
    score         => 106150,
    dungeon       => 'Endgame',
    current_depth => -5,
    deepest_depth => 50,
    current_hp    => 997,
    maximum_hp    => 1083,
    deaths        => 0,
    birth_date    => 20070414,
    death_date    => 20070414,
    uid           => 1031,
    role          => 'healer',
    race          => 'gnome',
    gender        => 'male',
    alignment     => 'neutral',
    name          => 'Conducty1',
    death         => 'ascended',
);

plan tests => scalar keys %values;

my $entry = NetHack::Logfile::Entry->new_from_line("3.4.3 106150 7 -5 50 997 1083 0 20070414 20070414 1031 Hea Gno Mal Neu Conducty1,ascended");

for my $method (sort keys %values) {
    is_deeply($entry->$method, $values{$method}, $method);
}

