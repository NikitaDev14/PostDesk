package Controllers::Router;

use strict;
use Data::Dumper;

my $self;

sub instance
{
	my $class = ref($_[0])||$_[0];
	$self ||= bless({}, $class);

	return $self;
}

sub start
{
	my ($self) = @_;

	my @url = split('/', $ENV{'REQUEST_URI'});

	opendir (DIR, "Controllers/PageControllers/");

	my @files = grep{/$url[2]\w+.pm/i} readdir(DIR);

	if(@files == undef || $url[2] == undef) {
		$files[0] = 'IndexController.pm';
	}

	#print Dumper(@files);

	my $controller = 'Controllers/PageControllers/'.substr($files[0], 0, -3);

	closedir DIR;

	require $controller.'.pm';

	$controller =~ s/\//'::'/ge;

	return $controller->new();
}

1;