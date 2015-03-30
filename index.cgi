#!/usr/bin/perl -w

use CGI qw(:cgi-lib:escapeHTML:unescapeHTML);
use warnings;
use CGI::Carp qw(fatalsToBrowser);
use strict;
use Data::Dumper;

use config;
use Controllers::Router;
use Views::View;

#use Models::Interfaces::Email;

print "Content-type:text/html;encoding=utf-8\n\n";

#print Dumper(Models::Interfaces::Http->instance()->readForm()->getParams());

#Models::Interfaces::Database->new(%config::config)->connect()->getAllCategories();

Controllers::Router->instance()->start()->run();

Views::View->new()->show();

#Models::Interfaces::Email->instance()->sendMessage('mykytababych1989@hmail.com', 'qwe', 1);