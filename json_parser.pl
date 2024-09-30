#!/usr/bin/perl
use strict;
use warnings;

our $tree_level = 0;
our $json_file;
our $current_line;

print "tree level: $tree_level\n";

if (defined($ARGV[0])) {
    $json_file = $ARGV[0];
    print "Argument provided:  $json_file\n";
} else {
    $json_file = "./penguins.json";
    print "No argument provided. Using $json_file\n";
}

open(current_line, "$json_file") or die "$json_file cannot be opened.\n";
while(<current_line>) {
    line_parser($current_line);
}
close;

sub line_parser {
    $current_line = $_;
    if ($current_line =~ /^\{/) {
        tree_descension();
    }

    if ($current_line =~ /^\}/) {
        tree_ascension();
    }

    if ($current_line =~ /"([^"]+)"\s*:\s*"([^"]+)"/) {
        print "Key-value pair: $1 => $2\n";
    }

    if ($current_line =~ /"([^"]+)"/) {
        print "Array value: $1\n";
    }
}

sub tree_descension {
    print "tree_descension\n";
    $tree_level++;
    print "$tree_level\n";
}

sub tree_ascension {
    print "tree_ascension\n";
    $tree_level--;
    print "$tree_level\n";
}
