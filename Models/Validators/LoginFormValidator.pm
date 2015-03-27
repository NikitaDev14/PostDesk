package Models::Validators::LogInFormValidators.pm;

use strict;

my $self;

sub instance ($;)
{
	my $class = ref($_[0])||$_[0];

	$self ||= bless();

	return $self;
	
}
sub SetParams ($$;)
{
	my ($Login,$Password) = @_;
	$self->{Login} = $Login;
	$self->{Last} = $Password;
	return $self;
}


sub getPassword ($;)
{
	my ($self) = @_;
	
	if($self->{Password}=~/!|@|#|$|%|^|&|*|-|+|=/)
		{
			 $rezult = 1;
		}
	else
		{
			$rezult = $self->{Password};
		}
	return $rezult;
}

sub getLogin ($;)
{
	my ($self) = @_;
	
	if($self->{Login}=~/[0-9a-z_]+@[0-9a-z_]+\\.[a-z]{1,5}/)
		{
			 $rezult = 1;
		}
	else
		{
			$rezult = $self->{Login};
		}
	return $rezult;
}

sub isValidForm ($;)#?????????? ?????????? ?????, ?????????? 0 1
{
	my ($self) = @_;

	return (
				$self->getLogin &&
				$self->getPassword &&			
			);
}
1;