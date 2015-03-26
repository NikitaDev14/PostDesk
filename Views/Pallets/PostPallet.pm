package Views::Pallets::PostPallet;

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

sub change ($;)
{
	my ($this) = @_;
	
	my $post = Models::Interfaces::Database->new(%config::config)->connect()->getOnePost($this->{post});
	
	#print Dumper($post->[0]);

	my %hash = (
		'Text' => $post->[0]{Text},
		'FirstName' => $post->[0]{FirstName},
		'Surname' => $post->[0]{SurName},
		'Phone' => $post->[0]{Phone}
	);

	$this->{template} =~ s/%(\w+)%/$hash{$1}/ge;

	#$this->$createList('<li>');

	return $this->{template};
}

1;