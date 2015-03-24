package Controllers::PageControllers::IndexController;

our @ISA = qw(BaseController);

use strict;
use Controllers::PageControllers::BaseController;
use Models::Utilities::DataContainer;

sub new
{
	my $class = ref($_[0])||$_[0];

	return bless({}, $class);
}

sub run
{
	my ($this) = @_;

	my $dataContainer = Models::Utilities::DataContainer->instance();

	$dataContainer->setParams('index');
}

1;