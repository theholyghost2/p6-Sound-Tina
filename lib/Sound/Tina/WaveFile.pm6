use v6.c;

class Sound::Tina::WaveFile {
	has $.maindata; ### riffChunk
	has $.format; ### fmtChunk
	has $.fact; ### factChunk
	has $.data; ### dataChunk
}
