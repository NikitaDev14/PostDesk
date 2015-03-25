#!"C:\xampp\perl\bin\perl.exe"

use CGI qw(:cgi-lib:escapeHTML:unescapeHTML);
use warnings;
use CGI::Carp qw(fatalsToBrowser);
use strict;

use config;
use Controllers::Router;
use Views::View;

Controllers::Router->instance()->start()->run();

Views::View->new()->show();