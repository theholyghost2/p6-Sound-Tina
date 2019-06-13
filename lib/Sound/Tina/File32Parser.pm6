use v6.c;

use Sound::Tina::Vector32bit;
use Sound::Tina::Parser;

### NOTE : File32Parser is not a FileXYParser

class Sound::Tina::File32Parser is Sound::Tina::Parser {

	method get1stchannels {
		return Nil;	
	}

	method get2ndchannels {
		return Nil;	
	}

	method getwooferchannels {
		return Nil;	
	}

	method getflowchannels {
		return Nil;	
	}

}

method transformtodata {
	
}

}

