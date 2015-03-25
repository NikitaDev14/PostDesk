package Views::Substitutor;

use strict;

use Views::Pallets::FirstPallet;

sub new ($$;)
{
	my ($proto, $template) = @_;

	my $class = ref($proto) || $proto;
	my $this->{template} = $template;

	return bless($this, $class);
}

sub substitute ($;)
{
	my ($this) = @_;

	my $template = Views::Pallets::FirstPallet->new($this->{template})->change();

	return $template;
}

1;