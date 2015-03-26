package Views::Pallets::IndexPallet;

our @ISA = qw(BasePallet);

use strict;
use Views::Pallets::BasePallet;
#use Models::Interfaces::Database;
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

my $createList = sub ($;)
{
	my ($this) = @_;

	my $catList = Models::Interfaces::Database->new(%config::config)->connect()->getCategories();
	my $list;

	foreach(@{$catList})
	{
		$list .= '<li><a href="/~user10/perl/PostDesk/cat/'.$_->{Name}.'">' . $_->{Name} . '</a></li>';
	}
	
	return $list;
};

sub change ($;)
{
	my ($this) = @_;

	my %hash = (
		'abc' => 'index',
		'def' => 'page',
		#'categories' => $this->$createList()
	);

	$this->{template} =~ s/%(\w+)%/$hash{$1}/ge;

	#$this->$createList('<li>');

	return $this->{template};
}



1;