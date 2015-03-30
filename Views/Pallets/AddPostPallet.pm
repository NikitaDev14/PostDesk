package Views::Pallets::AddPostPallet;

our @ISA = qw(BasePallet);

use strict;
use Views::Pallets::BasePallet;
use Models::Interfaces::Database;
use config;
use Data::Dumper;

sub new ($$$;)
{
	my ($proto, $template, $post) = @_;

	my $class = ref($proto) || $proto;
	my $this->{template} = $template;

	$this->{post} = $post;

	return bless($this, $class);
}

my $createList = sub ($;)
{
	my ($this) = @_;

	my $catList = Models::Interfaces::Database->new(%config::config)->connect()->getAllSubcategories();
	my $list;

	foreach(@{$catList})
	{
		$list .= '<option>' . $_->{Name} . '</option>';
	}
	
	return $list;
};

sub change ($;)
{
	my ($this) = @_;
	#print Dumper($post->[0]);

	my %hash = (
		'subcat' => $this->$createList()
	);

	$this->{template} =~ s/%(\w+)%/$hash{$1}/ge;

	#$this->$createList('<li>');

	return $this->{template};
}

1;