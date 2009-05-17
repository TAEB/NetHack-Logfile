package NetHack::Logfile::Entry::33;
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

my @fields = qw/version score dungeon current_depth deepest_depth current_hp
                maximum_hp deaths death_date birth_date uid role race gender
                alignment player death/;
sub parse {
    my $self  = shift;
    my $input = shift;

    return unless my @captures = $input =~ m{
        ^                     # start of line
        ([\d\.]+)         [ ] # version
        ([\d\-]+)         [ ] # score
        ([\d\-]+)         [ ] # dungeon
        ([\d\-]+)         [ ] # current_depth
        ([\d\-]+)         [ ] # deepest_depth
        ([\d\-]+)         [ ] # current_hp
        ([\d\-]+)         [ ] # maximum_hp
        (\d+)             [ ] # deaths
        (\d+)             [ ] # death_date
        (\d+)             [ ] # birth_date
        (\d+)             [ ] # uid
        ([A-Z][a-z][a-z]) [ ] # role
        ([A-Z][a-z][a-z]) [ ] # race
        ([MF][ae][lm])    [ ] # gender
        ([A-Z][a-z][a-z]) [ ] # alignment
        ([^,]+)               # player
        ,                     # literal comma
        (.*)                  # death
        $                     # end of line
    }x;

    my %parsed;
    @parsed{@fields} = @captures;

    return \%parsed;
}

my %roles = (
    Arc => 'archeologist',
    Bar => 'barbarian',
    Cav => 'caveman',
    Hea => 'healer',
    Kni => 'knight',
    Mon => 'monk',
    Pri => 'priest',
    Ran => 'ranger',
    Rog => 'rogue',
    Sam => 'samurai',
    Tou => 'tourist',
    Val => 'valkyrie',
    Wiz => 'wizard',
);
sub canonicalize_role {
    my $self   = shift;
    my $letter = shift;

    return $roles{$letter};
}

my %genders = (
    Mal => 'male',
    Fem => 'female',
);
sub canonicalize_gender {
    my $self   = shift;
    my $abbrev = shift;

    return $genders{$abbrev};
}

my %races = (
    Hum => 'human',
    Elf => 'elf',
    Dwa => 'dwarf',
    Gno => 'gnome',
    Orc => 'orc',
);
sub canonicalize_race {
    my $self   = shift;
    my $abbrev = shift;

    return $races{$abbrev};
}

my %alignments = (
    Law => 'lawful',
    Neu => 'neutral',
    Cha => 'chaotic',
);
sub canonicalize_alignment {
    my $self   = shift;
    my $abbrev = shift;

    return $alignments{$abbrev};
}

my @output_methods = qw/version score dungeon_number current_depth
                        deepest_depth current_hp maximum_hp deaths death_date
                        birth_date uid role_three race_three gender_three
                        alignment_three player death/;

sub as_line {
    my $self = shift;

    sprintf '%s %d %d %d %d %d %d %d %d %d %d %s %s %s %s %s,%s',
        map { $self->$_ } @output_methods;
}

sub abbreviate_crga {
    my $self   = shift;
    my $method = shift;

    return ucfirst lc substr($self->$method, 0, 3);
}
sub role_three      { shift->abbreviate_crga('role') }
sub race_three      { shift->abbreviate_crga('race') }
sub gender_three    { shift->abbreviate_crga('gender') }
sub alignment_three { shift->abbreviate_crga('alignment') }

__PACKAGE__->meta->make_immutable;
no Moose;
no Moose::Util::TypeConstraints;

1;
