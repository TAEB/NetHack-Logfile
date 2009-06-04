# Load the Module::Install bundled in ./inc/
use inc::Module::Install;

# Define metadata
name     'NetHack-Logfile';
all_from 'lib/NetHack/Logfile.pm';
githubmeta;

requires 'Moose'                       => 0.78;
requires 'MooseX::Attributes::Curried' => 0.02;
requires 'Sub::Exporter'               => 0.01;
WriteAll;

