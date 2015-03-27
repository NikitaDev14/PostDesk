package Views::Pallets::SignupresPallet;

our @ISA = qw(BasePallet);

use strict;
use Views::Pallets::BasePallet;
use Models::Validators::SignupFormValidator;

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
	
	my $validator = Models::Validators::SignupFormValidator->instance();

	my %hash = (
		'mess' => $validator->getMessage(),
		'name' => $validator->getName(),
		'lastName' => $validator->getLastName(),
		'email' => $validator->getEmail(),
		'phone' => $validator->getPhone(),
		'pass' => $validator->getPass(),
	);

	$this->{template} =~ s/%(\w+)%/$hash{$1}/ge;

	return $this->{template};
}

1;