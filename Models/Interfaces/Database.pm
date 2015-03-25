package Models::Interfaces::Database;

use strict;
use DBI;

sub new
{
	my ($proto, %params) = @_;
	my $class = ref($proto) || $proto;
	my $this = {
		'host' => $params{DB_HOST},
		'db' => $params{DB_NAME},
		'user' => $params{DB_USER},
		'pass' => $params{DB_PASS},
		'result'=> []
	};

	return bless($this, $class);
}
sub connect
{
	my ($this) = @_;
	$this->{connection} = DBI->connect("DBI:mysql:$this->{db}:$this->{host}", $this->{user}, $this->{pass});
	#print($this->{connection});

	return $this;
}
sub getResult
{
	my ($this) = @_;
	my $ref;

	while($ref = $this->{sth}->fetchrow_hashref())
	{
		push(@{$this->{result}}, $ref);
	}

	return $this->{result};
}
sub execute
{
	my ($this) = @_;

	$this->{sth} = $this->{connection}->query($this->{query});

	return $this;
}
sub DESTROY
{
	my ($this) = @_;
	$this->{connection}->disconnect();
}

sub setUser
{
	my ($this, $id, $name, $second_name,  $password, $email, $phone, $adress) = @_;
	my $query = "call insert_new_user($id, $name, $second_name, $password, $email, $phone, $adress)";
	$this->{query} = $query;
	return 1;
}

sub setPost
{
	my ($this, $id, $user_id, $category_id, $sub_category_id, $title, $description, $price) = @_;
	my $query = "call insert_new_post($id, $user_id, $category_id, $sub_category_id, $title, $description, $price)";
	$this->{query} = $query;
	return 1;
}

sub getAllCategoryPosts
{
	my ($this, $idCat) = @_;
	my $query = "call select_all_posts_category($idCat)";
	$this->{query} = $query;
	return 1;
}

sub getOnePost
{
	my ($this, $idPost) = @_;
	my $query = "call select_one_post($idPost)";
	$this->{query} = $query;
	return 1;
}

sub getCategories
{
	my ($this) = @_;
	my $query = "CALL getCategories()";

	$this->{query} = $query;

	return $this;
}

sub getAllSubCategories
{
	my ($this, $idMainCat) = @_;
	my $query = "call select_sub_category($idMainCat)";
	$this->{query} = $query;
	return 1;
}


1;