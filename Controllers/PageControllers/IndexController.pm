package Controllers::PageControllers::IndexController;

our @ISA = qw(BaseController);

use strict;
use Controllers::PageControllers::BaseController;

sub new
{
	my $class = ref($_[0])||$_[0];
	my $this->{var} = 4;
	#my $this->{var} = $obj->get();

	return bless($this, $class);
}

1;