package Controllers::PageControllers::SignupController;

our @ISA = qw(BaseController);

use strict;
use Controllers::PageControllers::BaseController;
use Models::Utilities::DataContainer;

sub new ($;)
{
	my ($proto, $page) = @_;

	my $class = ref($proto) || $proto;

	return bless({}, $class);
}

sub run ($;)
{
	my ($this) = @_;

	my $dataContainer = Models::Utilities::DataContainer->instance();

	$dataContainer->setParams({'nextPage' => 'signup', 'content' => 'signup'});
}

1;