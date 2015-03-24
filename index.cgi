#!"C:\xampp\perl\bin\perl.exe"

use CGI qw(:cgi-lib:escapeHTML:unescapeHTML);
use CGI::Carp qw(fatalsToBrowser);
use strict;
use Data::Dumper;

use Controllers::Router;

print "Content-type:text/html;encoding=utf-8\n\n";

$| = 1;

#ReadParse();

sub loadTemplate
{
	my ($fileName) = @_;
	
	local $/ = undef;
	
	open my $fh, "<$fileName";
	
	my $html = <$fh>;
	
	close $fh;
	
	return $html;
}
sub substitutor
{
	my %hash = ('abc' => 'index');
	#print $_[0];
	$_[0] =~ s/%(\w+)%/$hash{$1}/ge;
	
	return $_[0];
}

my $templateFile = 'Resources/html/index.html';
my $htmlString = loadTemplate($templateFile);

print Dumper(Controllers::Router->instance()->start());

print substitutor($htmlString);