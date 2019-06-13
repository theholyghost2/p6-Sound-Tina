use v6.c;

use Sound::Tina::Vector32bit;
use Sound::Tina::PatternLib;

class Sound::Tina::PatternChannelLib {

	has $!patterns1; ### array of full file of 8 bit patterns (xth channel)
	has $!patterns2; ### array of full file of 8 bit patterns (xth channel)
	has $!patterns3; ### array of full file of 8 bit patterns (xth channel)
	has $!patterns4; ### array of full file of 8 bit patterns (xth channel)
	
	method BUILD(:$wavparser) { ### array with multiple 1st channel Vector8bit (Vector32bit->fromxtoybit)
			$!patterns1 = $($wavparser.get1stchannels());
			$!patterns2 = $($wavparser.get2ndchannels());
			$!patterns3 = $($wavparser.getwooferchannels());
			$!patterns4 = $($wavparser.getflowchannels());
	}

	### search for a frame in a channel, 8-bit number in WAV
	multi method simple-search($channelnumber, $bit8pattern) { # array with multiple 1st channel Vector8bit (Vector32bit.fromxtoybit)


		my $patterns;
		given $channelnumber {
			when 1 {
				$patterns = $!patterns1;
			}
			when 2 {
				$patterns = $!patterns2;
			}
			when 3 {
				$patterns = $!patterns3;
			}
			when 4 {
				$patterns = $!patterns4;
			}
			default { return Nil; }
		}


		loop (my $i = 0; $i < len($patterns); $i++) {
			if ($bit8pattern == $patterns[$i]) {
				print "found an 8bit pattern in channel " ~ $channelnumber;
					return $i;
			}
				
		}

	}

	### Search for multiple consecutive frames, several 8-bit patterns
	multi method simple-search-multiple-8bit-sample($channelnumber, @bit8patterns) { # array with multiple 1st channel Vector8bit (Vector32bit.fromxtoybit)


		my $patterns;
		given $channelnumber {
			when 1 {
				$patterns = $!patterns1;
			}
			when 2 {
				$patterns = $!patterns2;
			}
			when 3 {
				$patterns = $!patterns3;
			}
			when 4 {
				$patterns = $!patterns4;
			}
			default { return Nil; }
		}

		loop (my $i = 0; $i < len($patterns); $i++) {
			loop (my $j = 0; $j < @bit8patterns.elems; $j++) {
				if (@bit8patterns[$j] == $patterns[$i+$j]) {
					next;
				}
				if ($j == @bit8patterns.elems - 1) {
					print "found an 8bit pattern in channel " ~ $channelnumber;
					return ($i, $j);
				}		

				$i += $j;
			}
				
		}
	
	}

	method matrixinterpolation() {
		my $m = Matrix32bit.new;

		my @arrayofvectors;

		loop (my $i = 0; $i < $!patterns1.elems; $i++) {
			push(@arrayofvectors, 
			multiplyLayersWithVector(Vector32bit.new(
					$!patterns1[$i],
					$!patterns2[$i],
					$!patterns3[$i],
					$!patterns4[$i])));
				
		}
		return @arrayofvectors;
	}	
		
} 
		
