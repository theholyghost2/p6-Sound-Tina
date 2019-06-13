use v6.c;

use Sound::Tina::Vector32bit;

class Sound::Tina::PatternLib {

	has @!patterns; ### system buffer vector
	has $!threshold;

	method BUILD(:$t) {
		$!threshold = $t;
	}

	method thresholdp($v, $index) {
		if (my $value = @!patterns[$index].dotp($v) < $!threshold) {
			return $value;
		} else {
			return Nil;
		}
	}
} 
		
