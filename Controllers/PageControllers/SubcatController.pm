package Controllers::PageControllers::SubcatController;

our @ISA = qw(BaseController);

use strict;
use Controllers::PageControllers::BaseController;
use Models::Utilities::DataContainer;

sub new ($$;)
{
	my ($proto, $subcategory) = @_;

	my $class = ref($proto) || $proto;
	my $this->{subcategory} = $subcategory;

	return bless($this, $class);
}

sub run ($;)
{
	my ($this) = @_;

	my $dataContainer = Models::Utilities::DataContainer->instance();

	$dataContainer->setParams({'nextPage' => 'subcategory', 'content' => $this->{subcategory}});
}

1;