package Models::Validators::EmailFormValidator;

use strict;

my $self;

sub instance ($;)
{
	my $class = ref($_[0])||$_[0];

	$self ||= bless({}, $class);

	return $self;
}
sub SetParams ($$;)
{
	my ($TextMassege,$EmailFrom) = @_;
	$self->{TextMassege} = $TextMassege;
	$self->{EmailFrom} = $EmailFrom;
	return $self;
}


sub getTextMassege ($;)
{
	my ($self) = @_;
	
	my $result;
	
	if($self->{TextMassege}=~/[A-Za-z\-]{3,}/)
		{
			 $result = '';
		}
	else
		{
			$result = $self->{TextMassege};
		}
	return $result;
}

sub getEmailFrom ($;)
{
	my ($self) = @_;
	
	my $result;
	
	if($self->{EmailFrom}=~/[0-9a-z_]+@[0-9a-z_]+\\.[a-z]{1,5}/)
		{
			 $result = 1;
		}
	else
		{
			$result = $self->{EmailFrom};
		}
	return $result;
}

sub isValidForm ($;)#?????????? ?????????? ?????, ?????????? 0 1
{
	my ($self) = @_;

	return (
				$self->getTextMassege &&
				$self->getEmailFrom		
			);
}
1;