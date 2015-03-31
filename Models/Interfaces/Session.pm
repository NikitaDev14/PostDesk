package Models::Interfaces::Session;

use strict;
use lib qw/libs/;
use CGI::Session;
use CGI;
use Models::Interfaces::Database;
use Data::Dumper;

my $self;

sub instance ($;)
{
	my $class = ref($_[0])||$_[0];
	
	$self ||= bless({}, $class);

	return $self;
}

sub sessionStart ($$$;$)
{
	my ($self, $idUser, $ipUser, $idSession)= @_;
	
	my $cgi = new CGI;
	my $session;
	
	if($idSession eq undef)
	{
		$session = CGI::Session->new(undef, $idSession, {'Directory' => '/home/user10/public_html/perl/PostDesk/sessions'});
	}
	#my $s = CGI::Session->load();

	
	
	#print Dumper($session);
	$self->{'session'} = $session;
	
	if($idUser ne undef)
	{
		$self->{'session'}->param("user", $idUser->[0]{idUser});
	}
	if($ipUser ne undef)
	{
		$self->{'session'}->param("ip", $ipUser);
	}
	
	$self->{'session'}->flush();
	
	#print Dumper($self->{session}{_DATA}{user});

	return $self;  # if logged in, don't bother going further
}

sub getParams ($;)
{
	my ($self)=@_;
	
	return $self->{'session'};
}

sub sessionDestroy ($;)
{
	my ($self)=@_;
	
    $self->{'session'}->delete();
	
    return 1;
	
	#my $session = CGI::Session->load() ;
	#$session->clear(["~logged-in"]);
	#$session->delete();  или это или то
}

1;