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
	
	($this->{params} eq undef)? $this->{cnt} = $this->{sth}->execute() : $this->{cnt} = $this->{sth}->execute($this->{params});
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

	$this->{query} = "SELECT Name FROM categories;";
	
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
		"SELECT COUNT(idUser) FROM users WHERE Email= ? AND Password = ?";
	$this->{params} = ();
	
	push(@{$this->{params}}, $useremail);
	push(@{$this->{params}}, $userpassword);
	
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
sub getAllCategories ($;)
{
	my ($this) = @_;
	
	$this->{query} =
	"SELECT 
		categories.idCategory, categories.Name as cat_name,
		GROUP_CONCAT( DISTINCT subcategories.idSubcategory) AS idsub,
		GROUP_CONCAT( DISTINCT subcategories.Name) AS subcat_name
	FROM categories
		INNER JOIN subcategories ON categories.idCategory = subcategories.idCategory
	GROUP BY categories.idCategory";
	
	$this->$execute();
	
	my @temp = ($this->$getResult())[0];
	my $n  = @temp;
	my @result;
	
	#print Dumper($n);
	
	foreach(@temp)
	{
		print Dumper($_);
		#push(@result, $_{cat_name});
		
		#foreach my $subcat($cat)
		#{
		#	print Dumper($subcat);
	#	}
	}
	
	#print Dumper(@result);
}

1;