package Models::Interfaces::Email;

use strict;

use Models::Interfaces::Database;
use Models::Email::MIME;
use Models::Email::Valid;
use Models::Sender::lib::Email::Sender::Simple qw(sendmail);
sub instance
{
	my $class = ref($_[0])||$_[0];
	$self ||= bless({}, $class);

	return $self;
}

sub sendMessage
{
	my ($self, $mailFrom, $text, $userId) = @_;
	my $mailTo = Models::Interfaces::Database->getUserMail($userId);
	
	if(Models::Email::Valid>address("$mailFrom") && (length $text) > 15 && $mailTo)
	{
		my $message =  Models::Email::MIME->create(
			header_str => [
				From    => "$mailFrom",
				To      => "$mailTo",
			],
			attributes => {
				encoding => 'quoted-printable',
				charset  => 'UTF-8',
			},
			body_str => "$message",
		);
		sendmail($message);
		return 1;
	}
	else
	{
		return undef;
	}
}

1;