package Views::Pallets::ProfilePallet;

our @ISA = qw(BasePallet);

use strict;
use config;
use Data::Dumper;

use Views::Pallets::BasePallet;
use Models::Interfaces::Database;
use Models::Interfaces::Session;

sub new ($$$;)
{
	my ($proto, $template, $user) = @_;

	my $class = ref($proto) || $proto;
	my $this->{template} = $template;

	$this->{user} = $user;

	return bless($this, $class);
}

my $createList = sub ($;)
{
	my ($this) = @_;

	my $postList = Models::Interfaces::Database->new(%config::config)->connect()->getPostsOfProfile($this->{user});
	my $list;

	foreach(@{$postList})
	{
		$list .= '<li>' . $_->{Text} . ' Hidden' . $_->{isHidden} . '</li>';
	}
	
	#print Dumper($postList);
	
	return $list;
};

sub change ($;)
{
	my ($this) = @_;
	
	my $profile = Models::Interfaces::Database->new(%config::config)->connect()->getProfile($this->{user});
	my $session = Models::Interfaces::Session->instance()->getParams();
	
	#print Dumper($post->[0]);

	my %hash = (
		'FirstName' => $profile->[0]{FirstName},
		'Surname' => $profile->[0]{SurName},
		'Phone' => $profile->[0]{Phone},
		'Email' => $profile->[0]{Email},
		'posts' => $this->$createList(),
		'IdSession' => $session->id()
	);

	$this->{template} =~ s/%(\w+)%/$hash{$1}/ge;

	#$this->$createList('<li>');

	return $this->{template};
}

1;