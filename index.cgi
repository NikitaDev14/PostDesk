#!/usr/bin/perl -w

use CGI qw(:cgi-lib:escapeHTML:unescapeHTML);
use warnings;
use CGI::Carp qw(fatalsToBrowser);
use strict;
use Data::Dumper;

use config;
use Controllers::Router;
use Views::View;

use Models::Interfaces::Database;

#print "Content-type:text/html;encoding=utf-8\n\n";

Controllers::Router->instance()->start()->run();

Views::View->new()->show();

#print Dumper(Models::Interfaces::Database->new(%config::config)->connect()->getSubcategories('transport'));