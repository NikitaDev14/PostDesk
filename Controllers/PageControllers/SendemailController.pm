package Controllers::PageControllers::SendemailController;

our @ISA = qw(BaseController);

use strict;
use Controllers::PageControllers::BaseController;
use Models::Utilities::DataContainer;
use Models::Validators::EmailFormValidator;
use Models::Interfaces::Email;

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
	my $params = Models::Interfaces::Http->instance()->readForm()->getParams();
	my $validator = Models::Validators::EmailFormValidator->instance()->setParams($params->{content}, $params->{emailFrom});
	
	my ($nextPage, $content);
	
	if($validator->isValid())
	{
		$nextPage = 'index';
		
		my $res = Models::Interfaces::Email->instance()->sendMessage($params->{emailFrom}, $params->{content}, $this->{user});
		
		if($res === 1)
		{
			$content = 'The message is sent successfully.';
		}
		else
		{
			$content = 'Error occured.';
		}
	}
	else
	{
		$nextPage = 'sendemail';
		$content = $this->{user};
	}

	$dataContainer->setParams({'nextPage' => $nextPage, 'content' => $content});
}

1;