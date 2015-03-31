package Controllers::PageControllers::AddPostController;

our @ISA = qw(BaseController);

use strict;

use Controllers::PageControllers::BaseController;
use Models::Utilities::DataContainer;
use Models::Interfaces::Database;
use Models::Interfaces::Http;
use Models::Interfaces::Session;
use Models::Validators::SessionValidator;
use config;
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
	my $session = Models::Interfaces::Session->instance()->sessionStart(undef, undef, $params->{IdSession});
	my $user = $session->getParams()->{_DATA}{user};
	
	#print Dumper($session);
	
	my ($nextPage, $content);

	if($params->{subcategory} eq undef || $params->{text} eq undef)
	{
		$nextPage = 'addpost';
		$content = $user;
	}
	else
	{
		my $validator = Models::Validators::SessionValidator->instance();

		my $result = $validator->isValidSession();
		
		if (!$result)
		{
			$nextPage = 'login';
			$content = 'login';
		}
		else
		{
			Models::Interfaces::Database->new(%config::config)->connect()->addPost($user, $params->{subcategory}, $params->{text});
			$nextPage = 'profile';
			$content = $user;
		}
	}

	$dataContainer->setParams({'nextPage' => $nextPage, 'content' => $content});
}

1;