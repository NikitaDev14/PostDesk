package Models::Interfaces::Database;

use strict;
use DBI;
use Data::Dumper;

sub new
{
	my ($proto, %params) = @_;
	my $class = ref($proto) || $proto;
	my $this = {
		'host' => $params{DB_HOST},
		'db' => $params{DB_NAME},
		'user' => $params{DB_USER},
		'pass' => $params{DB_PASS},
		'params' => [],
		'result'=> []
	};

	return bless($this, $class);
}
sub connect
{
	my ($this) = @_;
	
	$this->{connection} = DBI->connect("DBI:mysql:$this->{db}:$this->{host}", $this->{user}, $this->{pass});

	return $this;
}
my $execute = sub ($;)
{
	my ($this) = @_;
	
	$this->{sth} = $this->{connection}->prepare($this->{query});
	
	(@{$this->{params}})
		?  $this->{sth}->execute(@{$this->{params}})
		: $this->{sth}->execute();
};
my $getResult = sub ($;)
{
	my ($this) = @_;
	
	my $ref;
	
	while($ref = $this->{sth}->fetchrow_hashref())
	{
		push(@{$this->{result}}, $ref);
	}
	
	return $this->{result};
};
sub getCategories ($;)
{
	my ($this) = @_;

	$this->{query} = "SELECT Name FROM categories";
	
	$this->$execute();
	
	return $this->$getResult();
}
sub getSubcategories ($$;)
{
	my ($this, $category) = @_;
	
	$this->{query} = "SELECT Name FROM subcategories WHERE idCategory = (SELECT idCategory FROM categories WHERE Name = ?);";
	$this->{params} = $category;
	$this->$execute();
	
	return $this->$getResult();
}

sub getPosts ($$;)
{
	my ($this, $subcategory) = @_;
	
	$this->{query} = "SELECT posts.idPost, posts.Text FROM posts WHERE isHidden = 0 AND posts.idSubcategory = (SELECT idSubcategory FROM subcategories WHERE Name = ?)";
	$this->{params} = $subcategory;
	$this->$execute();
	
	return $this->$getResult();
}

sub getOnePost ($$;)
{
	my ($this, $Idpost) = @_;
	
	$this->{query} =
		"SELECT posts.idPost, posts.Text, posts.idUser,
					users.FirstName, users.SurName, users.Phone
		FROM posts 
		INNER JOIN users ON posts.idUser = users.idUser
		WHERE posts.idPost = ?";
		
	$this->{params} = $Idpost;
	$this->$execute();
	
	return $this->$getResult();
}

sub getUser ($$$;)
{
	my ($this, $useremail, $userpassword) = @_;
	
	$this->{query} =
		"SELECT idUser FROM users WHERE Email = ? AND Password = ?";
	$this->{params} = ();
	
	push(@{$this->{params}}, $useremail);
	push(@{$this->{params}}, $userpassword);
	
	$this->$execute();
	
	return $this->$getResult();
}

sub getProfile ($$;)
{
	my ($this, $idUser) = @_;

	$this->{query} = 
		"SELECT FirstName, SurName, Phone, Email FROM users WHERE idUser = ?";

	$this->{params} = ();
	
	push(@{$this->{params}}, $idUser);
	
	$this->$execute();
	
	return $this->$getResult();
}

sub getPostsOfProfile ($$;)
{
	my ($this, $idUser) = @_;

	$this->{query} = 
		"SELECT Text, isHidden FROM posts WHERE idUser = ?";

	$this->{params} = ();
	
	push(@{$this->{params}}, $idUser);
	
	$this->$execute();
	
	return $this->$getResult();
}

sub addUser ($$$$$$;)
{
	my ($this, $firstName, $surName, $phone, $email, $pass) = @_;
	
	$this->{query} = "INSERT INTO users(FirstName, SurName, Phone, Email, Password)
		VALUES(?, ? ,? ,?, ?)";
		
	$this->{params} = ();
	
	push(@{$this->{params}}, $firstName);
	push(@{$this->{params}}, $surName);
	push(@{$this->{params}}, $phone);
	push(@{$this->{params}}, $email);
	push(@{$this->{params}}, $pass);
	
	$this->$execute();
	
	return $this->$getResult();
}
sub getAllSubcategories ($;)
{
	my ($this) = @_;
	
	$this->{query} =
	"SELECT Name FROM subcategories";
	
	$this->$execute();

	return $this->$getResult();
}

1;