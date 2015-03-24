package Views::Pallets::FirstPallet;

use strict;

sub new ($$;)
{
	my ($proto, $template) = @_;

	my $class = ref($proto) || $proto;
	my $this->{template} = $template;

	return bless($this, $class);
}

sub change ($;)
{
	my ($this) = @_;

	my %hash = (
		'abc' => 'index',
		'def' => 'page'
		);

	$this->{template} =~ s/%(\w+)%/$hash{$1}/ge;

	return $this->{template};
}

1;