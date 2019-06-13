use v6.c;
use Sound::Tina::Vector8bit;

class Sound::Tina::Vector32bit {

has $.x1;
has $.x2;
has $.x3;
has $.x4;

method BUILD($y1 = 1000000.rand,$y2 = 10000000.rand,$y3 = 1000000.rand,$y4 = 1000000.rand) {
	$.x1 = $y1;
	$.x2 = $y2;
	$.x3 = $y3;
	$.x4 = $y4;
}

method asArray {
	return ($.x1, $.x2, $.x3, $.x4);
};

method from0tobit8 {
	return Vector8bit.new($.x1);
}

method from8tob16 {
	return Vector8bit.new($.x2);
}

method from16tobit24 {
	return Vector8bit.new($.x3);
}

method from24tobit32 {
	return Vector8bit.new($.x4);
}

method dotp ($v) {
		return $v.x1 * $.x1 +
		$v.x2 * $.x2 +
		$v.x3 * $.x3 +
		$v.x4 * $.x4;
}
}
