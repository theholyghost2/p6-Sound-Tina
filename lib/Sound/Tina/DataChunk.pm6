use v6.c;

class DataChunk {

	has $.sChunkID; ### four bytes: "data"
	has $.dwChunkSize; ### length of header
	has $.IFiIlePosition; ### Position of data chunk in file
	has $.dwMinLength; ### length of audio in minutes
	has $.dSecLength; ### length of audio in seconds
	has $.dwNumSamples; ### number of audio frames

}
