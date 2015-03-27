package Models::Validators::CreatePostValidation.pm;

use strict;

my $self;

sub instance ($;)
{
	my $class = ref($_[0])||$_[0];

	$self ||= bless();

	return $self;
	
}
sub SetParams ($$;)
{
	my ($TitlePost,$SubCategory,$PostOfContents) = @_;
	$self->{TitlePost} = $TitlePost;
	$self->{SubCategory} = $SubCategory;
	$self->{PostOfContents} = $PostOfContents;
	return $self;
}


sub getTitlePost ($;)
{
	my ($self) = @_;
	
	if($self->{TitlePost}=~/[A-Za-z\-]{3,}/)
		{
			 $rezult = 1;
		}
	else
		{
			$rezult = $self->{TitlePost};
		}
	return $rezult;
}

sub getSubCategory ($;)
{
	my ($self) = @_;
	
	if($self->{SubCategory}=~/[A-Za-z\-]{3,}/)
		{
			 $rezult = 1;
		}
	else
		{
			$rezult = $self->{SubCategory};
		}
	return $rezult;
}

sub getPostOfContents ($;)
{
	my ($self) = @_;
	
	if($self->{PostOfContents}=~/[A-Za-z\-]{3,}/)
		{
			 $rezult = 1;
		}
	else
		{
			$rezult = $self->{PostOfContents};
		}
	return $rezult;
}
sub isValidForm ($;)#?????????? ?????????? ?????, ?????????? 0 1
{
	my ($self) = @_;

	return (
				$self->getTitlePost &&
				$self->getSubCategory &&			
				$self->getPostOfContents &&			
			);
}
1;