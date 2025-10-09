#!/usr/bin/perl
# liveforever.pl
use strict; use warnings;

# set target number, check it is less than 100
die "Usage: liveforever.pl \n" unless (@ARGV == 1);
my ($target) = @ARGV;
die "Target integer must be less than 100\n" if ($target >= 100);

for (my $i = 0; $i < 100; $i++){

  # count up to 100
  print "$i\n";

  # print special message when $i reaches target number
  print "$target was your magic number!\n" if ($i == $target);

}
