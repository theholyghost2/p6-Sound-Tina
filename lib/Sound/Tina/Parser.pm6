use v6.c;

use Sound::Tina::Vector32bit;
##use Perl6::Slurp;

class Sound::Tina::WAVParser {


	method BUILD {
	}

	method fileparse($filename) {
		my @buffer;

		### read in several WAV type filenames

		@buffer = slurp $filename, {raw=>1};

		return @buffer;
	}
}
