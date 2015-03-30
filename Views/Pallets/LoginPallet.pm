package Views::Pallets::LoginPallet;

our @ISA = qw(BasePallet);

use strict;
use Views::Pallets::BasePallet;

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

	my $catList = Models::Interfaces::Database->new(%config::config)->connect()->getPostsOfProfile($this->{user});
	my $list;
	
	#print Dumper($catList);

	foreach(@{$catList})
	{
		$list .= '<li>' . $_->{Text} . '</li>';
	}
	
	return $list;
};

sub change ($;)
{
	my ($this) = @_;

	my $profile = Models::Interfaces::Database->new(%config::config)->connect()->getProfile($this->{user});

	my %hash =
	(
		'FirstName' => $profile->[0]{FirstName},
		'Surname' => $profile->[0]{SurName},
		'Phone' => $profile->[0]{Phone},
		'Email' => $profile->[0]{Email},
		'posts' => $this->$createList()
	);

	$this->{template} =~ s/%(\w+)%/$hash{$1}/ge;

	return $this->{template};
}

1;