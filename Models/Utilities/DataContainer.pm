package Models::Utilities::DataContainer;

use strict;

my $self;

sub instance ($;)
{
	my $class = ref($_[0])||$_[0];

	$self ||= bless(
		{'params' => {}
		}, $class);

	return $self;
}

sub setParams ($$;$)
{
	my ($self, $params) = @_;

	$self->{params} = $params;

	return $self;
}

sub getParams ($;)
{
	my ($self) = @_;

	return $self->{params};
}

1;