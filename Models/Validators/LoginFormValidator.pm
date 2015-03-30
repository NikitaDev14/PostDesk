package Models::Validators::LoginFormValidator;

use strict;
use Models::Interfaces::Database;
use config;
use Data::Dumper;

my $self;

sub instance ($;)
{
	my $class = ref($_[0])||$_[0];

	$self ||= bless({}, $class);

	return $self;
}
sub setParams ($$;)
{
	my ($self, $form) = @_;

	$self->{email} = $form->{email};
	$self->{pass} = $form->{password};

	return $self;
}
sub isValidForm ($;)
{
	my ($self) = @_;
	
	return Models::Interfaces::Database->new(%config::config)->connect()->getUser($self->{email}, $self->{pass});
}
1;