package Controllers::Router;

use strict;
use Data::Dumper;

my $self;

sub instance ($;)
{
	my $class = ref($_[0])||$_[0];
	$self ||= bless({}, $class);

	return $self;
}

sub start ($;)
{
	my ($self) = @_;

	my @url = split('/', $ENV{'REQUEST_URI'});

	opendir (DIR, "Controllers/PageControllers/");

	my @files = grep{/^$url[4]Controller.pm$/i} readdir(DIR);

	#!important: on home server $url[2], on GFL server $url[4]

	#print "Content-type:text/html;encoding=utf-8\n\n";

	#print Dumper($files[0]);

	if($files[0] eq undef || $url[4] eq undef) {
		$files[0] = 'IndexController.pm';
	}

	my $controller = 'Controllers/PageControllers/'.substr($files[0], 0, -3);

	closedir DIR;

	require $controller.'.pm';

	$controller =~ s/\//'::'/ge;

	return $controller->new($url[5]);
}

1;