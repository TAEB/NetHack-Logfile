package NetHack::Logfile::Entry;
use Moose;
use Moose::Util::TypeConstraints 'enum';
use NetHack::Logfile::Util;

field version => (
    isa => 'Str',
);

__PACKAGE__->meta->make_immutable;

1;

