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

__PACKAGE__->meta->make_immutable;

1;

