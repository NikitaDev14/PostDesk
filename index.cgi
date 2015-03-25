#!/usr/bin/perl

use CGI qw(:cgi-lib:escapeHTML:unescapeHTML);
use CGI::Carp qw(fatalsToBrowser);
use strict;
use warnings;
use Data::Dumper;

use Controllers::Router;
use Views::View;

Controllers::Router->instance()->start()->run();

Views::View->new()->show();