package Views::Pallets::SubcategoryPallet;

our @ISA = qw(BasePallet);

use strict;
use Views::Pallets::BasePallet;
use Models::Interfaces::Database;
use config;
use Data::Dumper;

sub new ($$$;)
{
	my ($proto, $template, $subcategory) = @_;

	my $class = ref($proto) || $proto;
	my $this->{template} = $template;

	$this->{subcategory} = $subcategory;

	return bless($this, $class);
}

my $createList = sub ($;)
{
	my ($this) = @_;

	my $catList = Models::Interfaces::Database->new(%config::config)->connect()->getPosts($this->{subcategory});
	my $list;
	
	#print Dumper($catList);

	foreach(@{$catList})
	{
		$list .= '<li><a href="/~user10/perl/PostDesk/post/'.$_->{idPost}.'">' . $_->{Text} . '</a></li>';
	}
	
	return $list;
};

sub change ($;)
{
	my ($this) = @_;

	my %hash = (
		'abc' => 'index',
		'def' => 'page',
		'posts' => $this->$createList()
	);

	$this->{template} =~ s/%(\w+)%/$hash{$1}/ge;

	#$this->$createList('<li>');

	return $this->{template};
}

1;