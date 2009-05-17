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

field 'birth_date';

field 'death_date';

field uid => (
    isa => 'Int',
);

field role => (
    isa => (enum [qw/archeologist barbarian caveman elf healer knight priest rogue samurai tourist valkyrie wizard/]),
);

field gender => (
    isa => (enum [qw/male female/]),
);

field 'player';

field 'death';

my @fields = qw/version score dungeon current_depth deepest_depth current_hp
                maximum_hp deaths death_date birth_date uid role gender player
                death/;
sub parse {
    my $self  = shift;
    my $input = shift;

    return unless my @captures = $input =~ m{
        ^             # start of line
        ([\d\.]+) [ ] # version
        ([\d\-]+) [ ] # score
        ([\d\-]+) [ ] # dungeon
        ([\d\-]+) [ ] # current_depth
        ([\d\-]+) [ ] # deepest_depth
        ([\d\-]+) [ ] # current_hp
        ([\d\-]+) [ ] # maximum_hp
        (\d+)     [ ] # deaths
        (\d+)     [ ] # death_date
        (\d+)     [ ] # birth_date
        (\d+)     [ ] # uid
        ([A-Z])       # role
        ([MF])    [ ] # gender
        ([^,]+)       # player
        ,             # literal comma
        (.*)          # death
        $             # end of line
    }x;

    my %parsed;
    @parsed{@fields} = @captures;

    return \%parsed;
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

    return $genders{$letter};
}


sub ascended { shift->death eq 'ascended' }

my %dungeon_number = (
    "The Dungeons of Doom" => 0,
    "Gehennom"             => 1,
    "The Gnomish Mines"    => 2,
    "The Quest"            => 3,
    "Sokoban"              => 4,
    "Fort Ludios"          => 5,
    "Vlad's Tower"         => 6,
    "Endgame"              => 7,
);
sub dungeon_number {
    my $self    = shift;
    my $dungeon = $self->dungeon || shift;

    return $dungeon_number{$dungeon};
}

sub abbreviate_cg {
    my $self   = shift;
    my $method = shift;

    return ucfirst substr($self->$method, 0, 1);
}

__PACKAGE__->meta->make_immutable;
no Moose;
no Moose::Util::TypeConstraints;

1;
