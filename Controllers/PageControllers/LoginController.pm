package Controllers::PageControllers::LoginController;

our @ISA = qw(BaseController);

use strict;

use Controllers::PageControllers::BaseController;
use Models::Utilities::DataContainer;
use Models::Interfaces::Database;
use Models::Interfaces::Http;
use Models::Validators::LoginFormValidator;
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
	my $validator = Models::Validators::LoginFormValidator->instance();
	my $params = Models::Interfaces::Http->instance()->readForm()->getParams();

	my ($nextPage, $content);

	if($params->{email} eq undef || $params->{password} eq undef)
	{
		$nextPage = 'login';
		$content = 'login';
	}
	else
	{
		$validator->setParams($params);

		my $result = $validator->isValidForm();

		if($result eq undef)
		{
			$nextPage = 'login';
			$content = 'login';
		}
		else
		{
			Models::Interfaces::Session->instance()->sessionStart($result, $ENV{REMOTE_ADDR});
			$nextPage = 'profile';
			$content = $result;
		}
	}

	$dataContainer->setParams({'nextPage' => $nextPage, 'content' => $content});
}

1;