package Controllers::PageControllers::AddPostController;

our @ISA = qw(BaseController);

use strict;

use Controllers::PageControllers::BaseController;
use Models::Utilities::DataContainer;
use Models::Interfaces::Database;
use Models::Interfaces::Http;
#use Models::Interfaces::Session;
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
	my $params = Models::Interfaces::Http->instance()->readForm()->getParams();
	my ($nextPage, $content);

	if($params->{subcategory} eq undef || $params->{text} eq undef)
	{
		$nextPage = 'addpost';
		$content = 'addpost';
	}
	else
	{
		my $validator = Models::Validators::LoginFormValidator->instance();
		
		$validator->setParams($params);

		my $result = $validator->isValidForm();
		

		if (!@$result)
		{
			$nextPage = 'addpost';
			$content = 'addpost';
		}
		else
		{
			#Models::Interfaces::Session->instance()->sessionStart($result, $ENV{REMOTE_ADDR});
			$nextPage = 'addpost';
			$content = 'addpost';
		}
	}


	$dataContainer->setParams({'nextPage' => $nextPage, 'content' => $content});
}

1;