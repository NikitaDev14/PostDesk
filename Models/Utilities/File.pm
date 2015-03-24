package Models::Utilities::File;

use strict;

my $self;

sub instance ($$;)
{
	my ($proto, $fileName) = @_;
	my $class = ref($proto) || $proto;

	$self ||= bless({}, $class);
	$self->{fileName} = $fileName;

	return $self;
}

sub loadTemplate ($;)
{
	my ($self) = @_;

	local $/ = undef;

	open my $fh, "<$self->{fileName}";

	my $html = <$fh>;

	close $fh;

	return $html;
}

1;