package NetHack::Logfile::Entry::32;
use Moose;
use Moose::Util::TypeConstraints 'enum';
use NetHack::Logfile::Util;
extends 'NetHack::Logfile::Entry';

field score => (
    isa => 'Int',
);

field dungeon => (
    isa => (enum [
       "The Dungeons of Doom",
       "Gehennom",
       "The Gnomish Mines",
       "The Quest",
       "Sokoban",
       "Fort Ludios",
       "Vlad's Tower",
       "Endgame",
    ]),
);

field current_depth => (
    isa => 'Int',
);

field deepest_depth => (
    isa => 'Int',
);

field current_hp => (
    isa => 'Int',
);

field maximum_hp => (
    isa => 'Int',
);

field deaths => (
    isa => 'Int',
);

field birth_date => (
    isa => 'Str',
);

field death_date => (
    isa => 'Str',
);

field uid => (
    isa => 'Int',
);

field role => (
    isa => (enum [qw/archeologist barbarian caveman elf healer knight priest rogue samurai tourist valkyrie wizard/]),
);

field gender => (
    isa => (enum [qw/male female/]),
);

field name => (
    isa => 'Str',
);

field death => (
    isa => 'Str',
);

__PACKAGE__->meta->make_immutable;
no Moose;
no Moose::Util::TypeConstraints;

1;
