package NetHack::Logfile::Entry;
use Moose;
use Moose::Util::TypeConstraints 'enum';
use NetHack::Logfile::Util;

field version => (
    isa => 'Str',
);

sub new_from_line {
    my $self = shift;
    my $line = shift;

    my ($version) = $line =~ /^([\d\.]+) /;
    confess "Unable to determine NetHack version from the log line '$version'"
        if !$version;

    my $original_version = $version;

    $version =~ tr/.//;
    while ($version) {
        my $package = "NetHack::Logfile::Entry::$version";
        if (eval { Class::MOP::load_class($package); 1 }) {
            return $package->_parse_and_construct($line);
        }
        warn $@ if $@ !~ /^Can't locate NetHack/;

        chop $version;
    }

    confess "This version of NetHack::Logfile cannot handle NetHack version $original_version log entries.";
}

sub _parse_and_construct {
    my $self = shift;
    my $line = shift;

    my $fields = $self->parse($line);
    confess "Unable to parse NetHack log entry $line" if !$fields;

    my $parameters = $self->_canonicalize($fields);

    return $self->new($parameters);
}

sub _canonicalize {
    my $self   = shift;
    my $fields = shift;

    for my $key (keys %$fields) {
        my $method = "canonicalize_$key";
        next unless $self->can($method);
        my $value = $fields->{$key};

        my $canonicalized = $self->$method($value, $fields);
        confess "Unable to canonicalize NetHack log field '$key' value '$value"
            unless defined $canonicalized;

        $fields->{$key} = $canonicalized;
    }

    return $fields;
}

__PACKAGE__->meta->make_immutable;

1;

