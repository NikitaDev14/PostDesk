package Views::View;

use strict;
use Data::Dumper;

use Models::Utilities::DataContainer;
use Models::Utilities::File;
use Views::Substitutor;

sub new ($;)
{
	my $class = ref($_[0])||$_[0];

	return bless({}, $class);
}

sub show ($;)
{
	my ($this) = @_;

	my $dataContainer = Models::Utilities::DataContainer->instance()->getParams();
	my $headerFile = 'Resources/html/HeaderLoggedOut.html';

	my $templateFile = 'Resources/html/'.$dataContainer->{nextPage}.'.html';

	my $fileOperator = Models::Utilities::File->instance($headerFile);
	my $header = $fileOperator->loadTemplate();

	$fileOperator = Models::Utilities::File->instance($templateFile);

	my $template = $fileOperator->loadTemplate();

	#print "Content-type:text/html;encoding=utf-8\n\n";

	print Dumper($dataContainer);

	$| = 1;

	#ReadParse();

	print $header;
	print Views::Substitutor->new($template, $dataContainer->{nextPage}, $dataContainer->{content})->substitute();
}

1;