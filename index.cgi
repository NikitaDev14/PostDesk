#!"C:\xampp\perl\bin\perl.exe"

use CGI qw(:cgi-lib:escapeHTML:unescapeHTML);
use warnings;
use CGI::Carp qw(fatalsToBrowser);
use strict;
use Data::Dumper;

use config;
use Controllers::Router;
use Views::View;
use Models::Interfaces::Database;
use Models::Interfaces::Http;

print "Content-type:text/html;encoding=utf-8\n\n";

print Dumper(Models::Interfaces::Http->instance()->readForm()->getParams());

Controllers::Router->instance()->start()->run();

Views::View->new()->show();