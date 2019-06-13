use v6.c;

use Sound::Tina::Vector32bit;

class Sound::Tina::Matrix32bit {

has $!layer1;
has $!layer2;
has $!layer3;
has $!layer4;

method BUILD {

	$!layer1 = Vector32bit.new;	
	$!layer2 = Vector32bit.new;	
	$!layer3 = Vector32bit.new;	
	$!layer4 = Vector32bit.new;	

}

method multiplyLayersWithVector($v) {
	my $retv = Vector32bit.new.asArray;

	my $i = 0;
	for ($v.asArray) {
		$retv[$i] += $v * $!layer1.asArray[$i];
	} 
	$i++;

	for ($v.asArray) {
		$retv[$i] += $v * $!layer2.asArray[$i];
	} 
	$i++;

	for ($v.asArray) {
		$retv[$i] += $v * $!layer3.asArray[$i];
	} 
	$i++;

	for ($v.asArray) {
		$retv[$i] += $v * $!layer4.asArray[$i];
	} 

	return $retv;	
}

}

