package Views::Substitutor;

use strict;

sub new ($$$$;)
{
	my ($proto, $template, $page, $content) = @_;

	my $class = ref($proto) || $proto;
	my $this->{template} = $template;
	$this->{page} = $page;
	$this->{content} = $content;

	return bless($this, $class);
}

sub substitute ($;)
{
	my ($this) = @_;

	#my $template = Views::Pallets::FirstPallet->new($this->{template})->change();

	#return $template;
	
	opendir (DIR, "Views/Pallets/");

	my @files = grep{/^$this->{page}Pallet.pm$/i} readdir(DIR);
	
	my $pallet = 'Views/Pallets/'.substr($files[0], 0, -3);

	require $pallet.'.pm';

	$pallet =~ s/\//'::'/ge;
	
	my $template = $pallet->new($this->{template}, $this->{content})->change();
	
	return $template;
}

1;