package NetHack::Logfile::Entry::34;
use Moose;
use Moose::Util::TypeConstraints 'enum';
use NetHack::Logfile::Util;
extends 'NetHack::Logfile::Entry::32';

field '+role' => (
    isa => (enum [qw/archeologist barbarian caveman healer knight monk priest ranger rogue samurai tourist valkyrie wizard/]),
);

field race => (
    isa => (enum [qw/human elf dwarf gnome orc/]),
);

field alignment => (
    isa => (enum [qw/lawful neutral chaotic/]),
);

__PACKAGE__->meta->make_immutable;
no Moose;
no Moose::Util::TypeConstraints;

1;
