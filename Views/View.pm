package Views::View;

use strict;

use Models::Utilities::DataContainer;
use Models::Utilities::File;
use Views::Substitutors::IndexSubstitutor;

sub new ($;)
{
	my $class = ref($_[0])||$_[0];

	return bless({}, $class);
}

sub show ($;)
{
	my ($this) = @_;

	my $dataContainer = Models::Utilities::DataContainer->instance()->getParams();
	my $templateFile = 'Resources/html/'.$dataContainer->{nextPage}.'.html';

	my $fileOperator = Models::Utilities::File->instance($templateFile);
	my $htmlString = $fileOperator->loadTemplate();

	print "Content-type:text/html;encoding=utf-8\n\n";

	#$| = 1;

	#ReadParse();

	print Views::Substitutors::IndexSubstitutor->new($htmlString)->substitute();
}

1;