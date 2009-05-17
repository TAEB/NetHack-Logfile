package NetHack::Logfile::Util;
use MooseX::Attributes::Curried (
    field => sub {
        return { } if /^\+/;

        return {
            is       => 'ro',
            isa      => 'Str',
            required => 1,
        }
    },
);

1;

