use v6.c;

class Sound::Tina::Vector8bit {

has $.x1;

method BUILD($y1 = 1000000.rand) { ### 0-255 bits
	$.x1 = $y1;
}

method asArray {
	return \($.x1);
}

};
