package Controllers::PageControllers::SignupresController;

our @ISA = qw(BaseController);

use strict;

use config;
use Controllers::PageControllers::BaseController;
use Models::Utilities::DataContainer;
use Models::Interfaces::Database;
use Models::Interfaces::Http;
use Models::Validators::SignupFormValidator;

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
	my $validator = Models::Validators::SignupFormValidator->instance();
	my $params = Models::Interfaces::Http->instance()->readForm()->getParams();
	my ($nextPage, $content);
	
	if($validator->isValid())
	{
		$nextPage = 'index';
		$content = $validator->getMessage();
		
		Models::Interfaces::Database->new(%config::config)->addUser($params);
	}
	else
	{
		$nextPage = 'signup';
		$content = 'signupres'
	}

	$dataContainer->setParams({'nextPage' => $nextPage, 'content' => $content});
}

1;