package Models::Interfaces::Email;

use strict;
use CGI;
use Email::MIME;
use Email::Valid;
use Email::Sender::Simple qw(sendmail);
use Models::Interfaces::Database;

sub instance
{
	my $class = ref($_[0])||$_[0];
	$self ||= bless({}, $class);

	return $self;
}

sub sendMessage
{
	my $cgi = new CGI;
	my $mailFrom = $cgi->param('email_address');
	my $feedback = $cgi->param('feedback');
	my $userid = $cgi->param('userid');
	my $mailTo = Models::Interfaces::Database->getUserMail($userid);
	
	if(Email::Valid->address("$mailFrom") && (length $feedback) > 15 && $mailTo)
	{
		my $message = Email::MIME->create(
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