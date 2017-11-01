# 
# csv2cliboard.pl
#
# das ding soll ein obscures dateiformat gerade biegen
#
use utf8;
use Encode;
use Win32::Clipboard;
$CLIP = Win32::Clipboard();

#print join(/,/,@ARGV);

my $s;

while (my $z=<>) {
	$z= decode('utf8',$z);
	chomp $z;

	my @f = split(",",$z);
	my @zf;

	foreach (@f) {
		my $s=$_;

		if ($_ =~ m/^(-?\d*)\.(\d+)$/ ) {
			$s=$1.",".$2;
		}

		if ($_ =~ m/^(\d{1,2})\.(\d{1,2})\.(\d{4})/) {
			$s=$2.".".$1.".".$3;
		}


		push(@zf,$s);
	}

	$s .= join("\t",@zf)."\n";
}

$s= encode('latin1',$s);

$CLIP->Set($s);
