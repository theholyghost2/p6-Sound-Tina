use v6.c;

use Sound::Tina::Vector32bit;
use Sound::Tina::File32Parser;

class Sound::Tina::WAVParser is Sound::Tina::FileParser { 

	has $.channel08bits;
	has $.channel18bits;
	has $.channel28bits;
	has $.channel38bits;

	has $.chunkID;
	has $.chunkSize;
	has $.format;

	has $.subchunk1ID;
	has $.subchunk1Size;
	has $.audioformat;
	has $.numchannels;
	has $.samplerate;
	has $.byterate;
	has $.blockalign;
	has $.bitspersample;

	has $.subchunk2ID;
	has $.subchunk2Size;

	method BUILD {
		$.channel08bits = \();	
		$.channel16bits = \();	
		$.channel24bits = \();	
		$.channel32bits = \();	
	};

	method get1stchannels {
		return $.channel08bits;
	}

	method get2ndchannels {
		return $.channel16bits;
	}

	method getwooferchannels {
		return $.channel24bits;
	}

	method getflowchannels {
		return $.channel32bits;
	}

	### main method for parsing 16,24,32 bit WAV files
	method fill-buffers($buffer) {
		self.readheader($buffer);

		given $.bitspersample {
		       when 16 { 
		       		self.fill16bitwavbuffers($*buffer.elems, $*buffer);
		 	}		
		       when 24 { 
		       		self.fill24bitwavbuffers($*buffer.elems, $*buffer);
		 	}		
		       when 32 { 
		       		self.fill32bitwavbuffers($*buffer.elems, $*buffer);
		 	}
			default {
				say "WAVParser fillbuffers : Unrecognized bits per sample rate";
			}
		}
	}

	### parse 16 bit WAV file
	method fill16bitwavbuffers($filelength, $buffer) {

		my $i = 44; ### header offset 

		$*buffer = $*buffer[44..$filelength];

		loop (; $i < $filelength; $i++) {
			push($*.channel08bits, $*buffer[$i++]); 
			push($*.channel16bits, $*buffer[$i]); 
		}
	}

	### parse 24 bit WAV file
	method fill24bitwavbuffers($filelength, $buffer) {

		my $i = 44; ### header offset

		$*buffer = $*buffer[44..$filelength];

		loop (; $i < $filelength; $i++) {
			push($*.channel08bits, $*buffer[$i++]); 
			push($*.channel16bits, $*buffer[$i++]); 
			push($*.channel24bits, $*buffer[$i]); 
		}
	}

	### parse 32 bit WAV file
	method fill32bitwavbuffers($filelength, $buffer) {

		my $i = 44; ### header offset  

		$*buffer = $*buffer[44..$filelength];

		loop (; $i < $filelength; $i++) {
			push($*.channel08bits, $*buffer[$i++]); 
			push($*.channel16bits, $*buffer[$i++]); 
			push($*.channel24bits, $*buffer[$i++]); 
			push($*.channel32bits, $*buffer[$i]); 
		}
	}



	method readRIFFheader($buffer) {
		my @buf = @$buffer[0..^12];
		@buf = split('', join(",", @buf));
	
		$.format = @buf[8..^12];

		if (not join(",", $.format) == "WAVE") {
			say "WAVE header unrecognised\n";
			exit;
		} else {
			say "WAVE format parsing .. \n";
		}

	}

	method readfmtheader($buffer) {
		my @buf = @$buffer[12..^36];
		@buf = split('', join(",", @buf));
	
		$.numchannels = @buf[22..^24];
		$.samplerate = @buf[24..^28];
		$.byterate = @buf[28..^32];
		$.bitspersample = @buf[34..^36];
	}

	method readdataheader($buffer) {
		my @buf = @$buffer[36..^44];
		@buf = split('', join(",", @buf));
	
	}

	method readheader($buffer) {

		### 8-bit stereo byte array
		### 8-bit mono byte array
		### 16-bit mono byte array

		self.readRIFFheader($buffer);		
		self.readfmtheader($buffer);
		self.readdataheader($buffer);

		return 44; ### skip woofer channel and flow channel
	}


method transformtodata {

}

}

