################################################################################################
#
#  Copyright notice
#
#  Release 2018-10 First version
#
#  (c) 2018 Copyright: Volker Kettenbach
#  e-mail: volker at kettenbach minus it dot de
#
#  Description:
#  This is an FHEM-Module for the Iluinize LED Stripes,
#
#  Requirements:
#  This module requires:
#  	Perl Module: IO::Socket::INET
#  	Perl Module: IO::Socket::Timeout
#  On a Debian (based) system, these requirements can be fullfilled by:
#   apt-get install install libio-socket-inet6-perl libio-socket-timeout-perl
#
#  Origin:
#  https://gitlab.com/volkerkettenbach/FHEM-Iluminize
#
#################################################################################################

package main;

use strict;
use warnings;

use IO::Socket::INET;
use IO::Socket::Timeout;


my $on =   chr(hex("55")) .
    chr(hex("99")) .
    chr(hex("5e")) .
    chr(hex("bb")) .
    chr(hex("01")) .
    chr(hex("02")) .
    chr(hex("02")) .
    chr(hex("12")) .
    chr(hex("ab")) .
    chr(hex("c2")) .
    chr(hex("aa")) .
    chr(hex("aa"));

my $off=   chr(hex("55")) .
    chr(hex("99")) .
    chr(hex("5e")) .
    chr(hex("bb")) .
    chr(hex("01")) .
    chr(hex("02")) .
    chr(hex("02")) .
    chr(hex("12")) .
    chr(hex("a9")) .
    chr(hex("c0")) .
    chr(hex("aa")) .
    chr(hex("aa"));


sub Iluminize_Initialize($)
{
    my ($hash) = @_;

    $hash->{DefFn}      = "Iluminize_Define";
    #$hash->{ReadFn}     = "Iluminize_Get"; # No get so far
    $hash->{SetFn}      = "Iluminize_Set";
    $hash->{UndefFn}    = "Iluminize_Undefine";
    $hash->{DeleteFn}   = "Iluminize_Delete";
    $hash->{AttrFn}     = "Iluminize_Attr";
    $hash->{AttrList}   = $readingFnAttributes;
}

sub Iluminize_Define($$)
{
    my ($hash, $def) = @_;
    my $name= $hash->{NAME};

    my @a = split( "[ \t][ \t]*", $def );
    return "Wrong syntax: use define <name> Iluminize <hostname/ip> " if (int(@a) != 3);

    Log3 $hash, 3, "Iluminize: $name defined.";

    return undef;
}

# No get so far
sub Iluminize_Get($$) {}


sub Iluminize_Set($$)
{
    my ($hash, $name, $cmd, @args) = @_;
    my $cmdList = "on off";

    return "\"set $name\" needs at least one argument" unless(defined($cmd));

    Log3 $hash, 3, "Iluminize: $name Set <". $cmd ."> called" if ($cmd !~ /\?/);

    my $remote_host = $hash->{HOST};
    my $remote_port = 8899;

    my $socket = IO::Socket::INET->new(PeerAddr => $remote_host,
        PeerPort => $remote_port,
        Proto    => 'tcp',
        Type     => SOCK_STREAM,
        Timeout  => 1 )
        or return "Couldn't connect to $remote_host:$remote_port: $@\n";

    $socket->write($$cmd);

}


sub Iluminize_Undefine($$)
{
    my ($hash, $arg) = @_;
    my $name= $hash->{NAME};
    Log3 $hash, 3, "Iluminize: $name undefined.";
    return;
}



sub Iluminize_Delete {
    my ($hash, $arg) = @_;
    my $name= $hash->{NAME};
    Log3 $hash, 3, "Ilumnize: $name deleted.";
    return undef;
}



sub Iluminize_Attr {
    my ($cmd, $name, $aName, $aVal) = @_;
    my $hash = $defs{$name};
}



