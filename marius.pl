#!/usr/bin/perl
use v5.14;

use Encode;
use File::Slurp;
use JSON::MaybeXS;

# Stupid regex solution; split emojis by keywords, then repeatedly
# find the longest prefix of the input line that is a keyword, print a
# random emoji for that keyword, and remove the found prefix from the
# input line. If no prefix matches the input, remove the first
# character of the input.
#
# Prints output as HTML to STDOUT and prints a list of emoji tags
# identified (one per line) to STDERR

my $file = read_file 'emoji.json';
my @emojis = @{decode_json $file};

my %emojis;

for my $e (@emojis) {
	my $ch = chr hex substr $e->{code}, 2;
	for my $k (@{$e->{keywords}}) {
		$emojis{lc $k} //= [];
		push @{$emojis{lc $k}}, $ch;
	}
}

my @keywords= map { "\Q$_\E" }
  # Schwartzian transform
  map { $_->[0] } sort { $b->[1] <=> $a->[1] or $a->[0] cmp $b->[0] } map { [$_, length] }
  keys %emojis;

my $an_emoji_keyword = join '|', @keywords;

sub get_rand {
	my ($aref) = @_;
	my $idx = int rand @$aref;
	$aref->[$idx]
}

say <<'EOF';
<!DOCTYPE html>
<meta charset="utf-8">
<title>Emoji Translator</title>
<style>
body
{
 font-size: 4em;
}
</style>
EOF

for my $line (<>) {
	chomp $line;
	$line = lc $line;
	while ($line) {
		my ($word) = $line =~ /^($an_emoji_keyword|\s+|.)/;
		$line = substr $line, length $word;
		next unless $emojis{$word};
		say STDERR $word;
		print encode 'UTF-8', get_rand $emojis{$word}
	}
}
