package NetHack::Logfile::Util;
use MooseX::Attributes::Curried (
    field => {
        is       => 'ro',
        isa      => 'Str',
        required => 1,
    },
);

1;

