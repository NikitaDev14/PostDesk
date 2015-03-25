package Views::Pallets::IndexPallet;

our @ISA = qw(BasePallet);

use strict;
use Views::Pallets::BasePallet;

sub new ($$$;)
{
	my ($proto, $template, $content) = @_;

	my $class = ref($proto) || $proto;
	my $this->{template} = $template;
	$this->{content} = $content;

	return bless($this, $class);
}

sub change ($;)
{
	my ($this) = @_;

	my %hash = (
		'abc' => 'index',
		'def' => 'page',
		'qwe' => 'category',
	);

	$this->{template} =~ s/%(\w+)%/$hash{$1}/ge;

	return $this->{template};
}

1;