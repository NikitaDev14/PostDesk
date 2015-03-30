package Models::Interfaces::Session;

use strict;
use CGI::Session;
use CGI;
use Models::Interfaces::Database;

my $self;

sub instance
{
	my $class = ref($_[0])||$_[0];
	$self ||= bless(
	{
		'params' => undef
	}, $class);

	return $self;
}
sub sessionStart
{
	my ($self, $user, $ip) = @_;

	my $cgi = new CGI;
	my $session = new CGI::Session(undef, $cgi, {Directory=>'/tmp'});
	
	if ($session->param("~logged-in"))
	{
        return 1;  # if logged in, don't bother going further
    }

    my $user_mail = $cgi->param("user_mail ") or return;
    my $user_pass = $cgi->param("user_pass") or return;

    # if we came this far, user did submit the login form
    # so let's try to load his/her profile if name/psswds match
    if ( my $profile = _load_profile($user_mail, $user_pass))
    {
        $session->param("~profile", $profile);
        $session->param("~logged-in", 1);
        return 1;
    }
}
sub getParams
{
	my ($self) = @_;

	return $self->{params};
}
sub load_profile
{
    my ($user_mail, $user_pass) = @_;

	$query = Models::Interfaces::Database->getUser($user_mail, $user_pass);
	unless($query)
	{
		return undef;
	}
	else
	{
		return 1;
	}
}
sub sessionDestroy
{
	my $session = CGI::Session->load() ;
	$session->clear(["~logged-in"]);
	#$session->delete();  или это или то
}

1;