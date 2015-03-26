package Views::Pallets::CategoryPallet;

our @ISA = qw(BasePallet);

use strict;
use Views::Pallets::BasePallet;
use Models::Interfaces::Database;
use config;
use Data::Dumper;

sub new ($$$;)
{
	my ($proto, $template, $category) = @_;

	my $class = ref($proto) || $proto;
	my $this->{template} = $template;

	$this->{category} = $category;

	return bless($this, $class);
}

my $createList = sub ($;)
{
	my ($this) = @_;

	my $catList = Models::Interfaces::Database->new(%config::config)->connect()->getSubcategories($this->{category});
	my $list;

	foreach(@{$catList})
	{
		$list .= '<li><a href="/~user10/perl/PostDesk/subcat/'.$_->{Name}.'">' . $_->{Name} . '</a></li>';
	}
	
	return $list;
};

sub change ($;)
{
	my ($this) = @_;

	my %hash = (
		'abc' => 'index',
		'def' => 'page',
		'subcategories' => $this->$createList()
	);

	$this->{template} =~ s/%(\w+)%/$hash{$1}/ge;

	#$this->$createList('<li>');

	return $this->{template};
}

1;