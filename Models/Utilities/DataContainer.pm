package Models::Utilities::DataContainer;

use strict;

my $self;

sub instance ($;)
{
	my $class = ref($_[0])||$_[0];

	$self ||= bless(
		{'params' =>
			{
			'nextPage' => undef,
			'errors' => {}
			}
		}, $class);

	return $self;
}

sub setParams ($$;$)
{
	my ($self, $nextPage, $errors) = @_;

	$self->{params}{nextPage} = $nextPage;
	$self->{params}{errors} = $errors;

	return $self;
}

sub getParams ($;)
{
	my ($self) = @_;

	return $self->{params};
}

1;