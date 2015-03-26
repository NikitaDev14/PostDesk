package Models::Interfaces::Http;

use strict;
use CGI qw(param);
use Data::Dumper;

my $self;

sub instance ($;)
{
	my $class = ref($_[0])||$_[0];

	$self ||= bless({}, $class);

	return $self;
}

sub readForm ($;)
{
	my ($self) = @_;

	foreach (param)
	{
		$self->{form}{$_} = param($_);
	}

	return $self;
}

sub getParams ($;)
{
	my ($self) = @_;

	return $self->{form};
}

1;