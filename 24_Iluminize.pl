#package main;

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


my $remote_host = "led2.wi.kettenbach-it.de";
my $remote_port = 8899;

my $socket = IO::Socket::INET->new(PeerAddr => $remote_host,
    PeerPort => $remote_port,
    Proto    => 'tcp',
    Type     => SOCK_STREAM,
    Timeout  => 1 )
    or return "Couldn't connect to $remote_host:$remote_port: $@\n";

$socket->write($on);

