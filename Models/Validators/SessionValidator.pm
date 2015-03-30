package Models::Validators::SessionValidator;

use strict;
use CGI::Session;
use CGI;
use config;
use Models::Interfaces::Session;

my $self;

sub instance ($;)
{
	my $class = ref($_[0])||$_[0];

	$self ||= bless({}, $class);

	return $self;
}
sub isValidSession ($$$;)
{
	my ($self, $user, $ip) = @_;

	my $session = Models::Interfaces::Session->instance()->getParams();

	return ($session->{user} == $user && $session->{ip} == $ip);
}
1;