package Controllers::PageControllers::LoginController;

our @ISA = qw(BaseController);

use strict;

use Controllers::PageControllers::BaseController;
use Models::Utilities::DataContainer;
use Models::Interfaces::Session;
use Data::Dumper;

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

	Models::Interfaces::Session->instance()->sessionDestroy();

	$dataContainer->setParams({'nextPage' => 'index', 'content' => 'index'});
}

1;