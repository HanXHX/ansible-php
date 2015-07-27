#!/usr/bin/perl

use strict;
use warnings;

use LWP::Simple;
use Data::Dumper;

use constant {
	PREFIX_KEY => 'php_'
};

my $html = get('http://xdebug.org/docs/all_settings');

my @inis = ();

my $y = 0;
my $ini;

foreach(split("\n", $html))
{
	chomp;
	if($y)
	{
		$y = 0;
		/<span class='default'>(.+?)<\/span>/;
		$ini->{default} = $1;
	}
	if(/class='name'>(.+)</)
	{
		$ini = {};
		my $a = $1;
		$a =~ s/\./_/g;
		$ini->{php_key} = $a;
		$ini->{key} = sprintf('%s%s', PREFIX_KEY, $a);
		$ini->{var} = sprintf('{{ %s }}', $ini->{key});
		push(@inis, $ini);
		$y = 1;
	}
}

print STDERR "============ defaults/main.yml ===============\n";
foreach my $p (@inis)
{
	printf("%s: '%s'\n", $p->{key}, $p->{default});
}

print STDERR "============ xdebug.ini.j2 ===============\n";
foreach my $p (@inis)
{
	printf("%s=%s\n", $p->{php_key}, $p->{var});
}
