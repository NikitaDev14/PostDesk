package Views::Pallets::SendemailPallet;

our @ISA = qw(BasePallet);

use strict;
use Views::Pallets::BasePallet;
use Models::Interfaces::Database;
use Models::Validators::EmailFormValidator;
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
	
	my $validator = Models::Validators::EmailFormValidator->instance();
	my $post = Models::Interfaces::Database->new(%config::config)->connect()->getOnePost($this->{post});
	
	#print Dumper($post->[0]);

	my %hash = (
		'emailFrom' => $validator->getEmailFrom(),
		'content' => $validator->getTextMassege(),
		'action' => '/~user10/perl/PostDesk/sendemail/' . $post->[0]{idUser}
	);

	$this->{template} =~ s/%(\w+)%/$hash{$1}/ge;

	#$this->$createList('<li>');

	return $this->{template};
}

1;