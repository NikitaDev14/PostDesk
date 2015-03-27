package Models::Validators::SignupFormValidator;

use strict;

my $self;

sub instance ($;)
{
	my $class = ref($_[0])||$_[0];

	$self ||= bless();

	return $self;
	
}
sub SetParams ($$$$$$;)
{
	my ($self,$Name, $LastName, $Email, $Phone, $Password,$RepeatPassword) = @_;
	$self->{Name} = $Name;
	$self->{Last} = $LastName;
	$self->{Email} = $Email;
	$self->{Phone} = $Phone;
	$self->{Password} = $Password;
	$self->{RepeatPassword} = $RepeatPassword;
	return $self;
}


sub getName ($;)
{
	my ($self) = @_;
	
	if($self->{Name}=~/[A-Za-z\-]{3,}/)
		{
			 $rezult = 1;
		}
	else
		{
			$rezult = $self->{Name};
		}
	return $rezult;
}

sub getLastName ($;)
{
	my ($self) = @_;
	
	if($self->{LastName}=~/[A-Za-z\-]{3,}/)
		{
			 $rezult = 1;
		}
	else
		{
			$rezult = $self->{LastName};
		}
	return $rezult;
}

sub getEmail ($;)
{
	my ($self) = @_;
	my $rezult;
	if($self->{Email}=/~[0-9a-z_]+@[0-9a-z_]+\\.[a-z]{1,5}/)
		{
			 $rezult = 1;
		}
	else
		{
			$rezult = $self->{Email};
		}
	return $rezult;
}

sub getPassword($;)
{   
	my ($self) = @_;
	my $rezult;
	if($self->{Passsword}=~/!|@|#|$|%|^|&|*|-|+|=/) {
		$rezult = 0;
		}
	else
	{
		$rezult=$self->{Passsword};
	}
		
	return $rezult;
	
}

sub getRepeatPassword($;)
{
	my ($self) = @_;
	my $rezult;
	if($self->{RepeatPassword}==$self->{Passsword})
		{
			$rezult = 1;
		}
	else
		{
			$rezult=$self->{RepeatPassword};
		}
	return $rezult;
}

sub getPhone($;)
{
	my ($self) = @_;
	my $rezult;	
	if($self->{Phone}=~/\\+?[0-9]{12}/)
		{
			$rezult = 1;
		}
	else
		{
			$rezult=$self->{Phone};
		}
	return $rezult;
}
sub isValidForm ($;)#определяет валидность формы, возвращает 0 1
{
	my ($self) = @_;

	return (
				$self->getName &&
				$self->getLastName &&
				$self->getEmail &&
				$self->getPassword &&
				$self->getRepeatPassword &&
				$self->getPhone &&			
			);
}
1;