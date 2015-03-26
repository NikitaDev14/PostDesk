package Views::Pallets::IndexPallet;

our @ISA = qw(BasePallet);

use strict;
use Views::Pallets::BasePallet;
use Models::Interfaces::Database;
use config;
use Data::Dumper;

sub new ($$$;)
{
	my ($proto, $template, $content) = @_;

	my $class = ref($proto) || $proto;
	my $this->{template} = $template;

	$this->{content} = $content;

	return bless($this, $class);
}

my $createList = sub ($$;)
{
	my ($this, $tag) = @_;

	print Dumper(Models::Interfaces::Database->new(%config::config)->connect()->getCategories()->execute()->getResult());
};

sub change ($;)
{
	my ($this) = @_;

	my %hash = (
		'abc' => 'index',
		'def' => 'page',
		'qwe' => 'category',
	);

	$this->{template} =~ s/%(\w+)%/$hash{$1}/ge;

	#$this->$createList('<li>');

	return $this->{template};
}



1;