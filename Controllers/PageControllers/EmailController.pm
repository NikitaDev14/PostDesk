package Controllers::PageControllers::EmailController;

our @ISA = qw(BaseController);

use strict;
use Controllers::PageControllers::BaseController;
use Models::Utilities::DataContainer;

sub new ($$;)
{
	my ($proto, $user) = @_;

	my $class = ref($proto) || $proto;
	my $this->{user} = $user;

	return bless($this, $class);
}

sub run ($;)
{
	my ($this) = @_;

	my $dataContainer = Models::Utilities::DataContainer->instance();

	$dataContainer->setParams({'nextPage' => 'sendemail', 'content' => $this->{user}});
}

1;