package Models::Performers::User;

use strict;

my $self;

sub instance
{
	my $class = ref($_[0])||$_[0];
	$self ||= bless({}, $class);

	return $self;
}

sub start
{
	my ($self) = @_;

	return $ENV{'REQUEST_URI'};
}

1;