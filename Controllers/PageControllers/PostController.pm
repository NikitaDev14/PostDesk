package Controllers::PageControllers::PostController;

our @ISA = qw(BaseController);

use strict;
use Controllers::PageControllers::BaseController;
use Models::Utilities::DataContainer;

sub new ($$;)
{
	my ($proto, $post) = @_;

	my $class = ref($proto) || $proto;
	my $this->{post} = $post;

	return bless($this, $class);
}

sub run ($;)
{
	my ($this) = @_;

	my $dataContainer = Models::Utilities::DataContainer->instance();

	$dataContainer->setParams({'nextPage' => 'post', 'content' => $this->{post}});
}

1;