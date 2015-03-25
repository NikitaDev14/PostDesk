package Controllers::PageControllers::CatController;

our @ISA = qw(BaseController);

use strict;
use Controllers::PageControllers::BaseController;
use Models::Utilities::DataContainer;

sub new ($$;)
{
	my ($proto, $category) = @_;

	my $class = ref($proto) || $proto;
	my $this->{category} = $category;

	return bless($this, $class);
}

sub run ($;)
{
	my ($this) = @_;

	my $dataContainer = Models::Utilities::DataContainer->instance();

	$dataContainer->setParams({'nextPage' => 'categories', 'content' => $this->{category}});
}

1;