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

sub parse {
    my $self  = shift;
    my $input = shift;

    return unless my @captures = $input =~ m{
        ^               # start of line
        (3\.2\.\d+) [ ] # version
        ([\d\-]+)   [ ] # points
        ([\d\-]+)   [ ] # deathdnum
        ([\d\-]+)   [ ] # deathlev
        ([\d\-]+)   [ ] # maxlvl
        ([\d\-]+)   [ ] # hp
        ([\d\-]+)   [ ] # maxhp
        (\d+)       [ ] # deaths
        (\d+)       [ ] # deathdate
        (\d+)       [ ] # birthdate
        (\d+)       [ ] # uid
        ([A-Z])         # role
        ([MF])      [ ] # gender
        ([^,]+)     # name
        ,           # literal comma
        (.*)        # death
        $           # end of line
        }x;

    my %output;
    @output{qw/version points deathdnum deathlev maxlvl hp maxhp deaths
               deathdate birthdate uid role gender name death/}
        = @captures;

    return \%output;
}

my @dungeons = (
    "The Dungeons of Doom",
    "Gehennom",
    "The Gnomish Mines",
    "The Quest",
    "Sokoban",
    "Fort Ludios",
    "Vlad's Tower",
    "Endgame",
);
sub canonicalize_dungeon {
    my $self = shift;
    my $dnum = shift;

    return $dungeons[$dnum];
}

my %roles = (
    A => 'archeologist',
    B => 'barbarian',
    C => 'caveman',
    E => 'elf',
    H => 'healer',
    K => 'knight',
    P => 'priest',
    R => 'rogue',
    S => 'samurai',
    T => 'tourist',
    V => 'valkyrie',
    W => 'wizard',
);
sub canonicalize_role {
    my $self   = shift;
    my $letter = shift;

    return $roles{$letter};
}

my %genders = (
    M => 'male',
    F => 'female',
);
sub canonicalize_gender {
    my $self   = shift;
    my $letter = shift;

    return $gender{$letter};
}

__PACKAGE__->meta->make_immutable;
no Moose;
no Moose::Util::TypeConstraints;

1;
