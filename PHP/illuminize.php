<?php
$ip="led2.wi.kettenbach-it.de";
$on =	chr(hexdec("55")) . 
	chr(hexdec("99")) . 
	chr(hexdec("5e")) .
	chr(hexdec("bb")) .
	chr(hexdec("01")) .
	chr(hexdec("02")) .
	chr(hexdec("02")) .
	chr(hexdec("12")) .
	chr(hexdec("ab")) .
	chr(hexdec("c2")) .
	chr(hexdec("aa")) .
	chr(hexdec("aa"));

$off=	chr(hexdec("55")) . 
	chr(hexdec("99")) . 
	chr(hexdec("5e")) .
	chr(hexdec("bb")) .
	chr(hexdec("01")) .
	chr(hexdec("02")) .
	chr(hexdec("02")) .
	chr(hexdec("12")) .
	chr(hexdec("a9")) .
	chr(hexdec("c0")) .
	chr(hexdec("aa")) .
	chr(hexdec("aa"));

fwrite(fsockopen("tcp://$ip", 8899), ${$argv[1]} );
