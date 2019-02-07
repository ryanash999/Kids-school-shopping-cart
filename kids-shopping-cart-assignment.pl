#!/usr/bin/perl -w
#
use strict;
use warnings;
use v5.16.1;
use Data::Dumper;
use List::Util 'shuffle';

print "Content-type: text\\html \n\n";

my %products = (
  "Apple airpods" => {
    "category" => "Electronics",
    "price" => 159.99,
    "discount" => '.10',
    "count" => 1
  },
  "Hot wheels" => {
    "category" => "Toys",
    "price" => 30.99,
    "discount" => '.50',
    "count" => 1
  },
  "Honey well 4 speed" => {
    "category" => "Home",
    "price" => 21.99,
    "discount" => '.62',
    "count" => 1
  },
  "Oreo" => {
    "category" => "Misc",
    "price" => 3.41,
    "discount" => '.08',
    "count" => 1
  },
  "Video rocker gamer chair" => {
    "category" => "Furniture",
    "price" => 35.49,
    "discount" => '.40',
    "count" => 1
  },
  "tv" => {
    "category" => "Electronis",
    "price" => 159.99,
    "discount" => '.10',
    "count" => 1
  },
  "logitech mouse" => {
    "category" => "Electronics",
    "price" => 42.16,
    "discount" => '.10',
    "count" => 1
  },
  "Fidget spinner" => {
    "category" => "Toys",
    "price" => 9.99,
    "discount" => '.50',
    "count" => 1
  },
  "altoids" => {
    "category" => "Misc",
    "price" => .99,
    "discount" => '.08',
    "count" => 1
  },
  "toothpick" => {
    "category" => "Home",
    "price" => 1.97,
    "discount" => '.62',
    "count" => 1
  },
  "floss" => {
    "category" => "Health",
    "price" => .99,
    "discount" => '.35',
    "count" => 1
  }
);

my $total = 0;
my $c = 0;

while ($total != 500) {
  $c++;
  alter_cart($total);
  $total = calc_total();
  say "<p>Trying: $total</p>";
  exit if ($c > 100000);
}

say "<p>SUCCESS: total = $total</p>";
say "<p>Calculations done: $c</p>";
#say Dumper \%products;
say "\n<p>Final product count information:</p>";

foreach my $name (keys %products) {
  my $ltotal += sprintf("%.2f", (($products{$name}{price} * $products{$name}{count}) * (1 - $products{$name}{discount}) * 1.09));
  say "\t<p>$name ($products{$name}{category}): $products{$name}{price} x $products{$name}{count} ($ltotal)</p>";
}
 
say "<p>This includes tax!</p>";

##############################

sub alter_cart {
  my ($total) = @_;
  foreach my $name (shuffle keys %products) {
    if ($total > 500) {
      next if ($products{$name}{count} == 1);
      #say "Decrementing: $name";
      $products{$name}{count}--;
    }elsif($total < 500) {
      #say "Incrementing: $name";
      $products{$name}{count}++;
    }
    last;
  }
}

sub calc_total {
  my $ltotal = 0; 
  foreach my $name (keys %products) {
    $ltotal += sprintf("%.2f", (($products{$name}{price} * $products{$name}{count}) * (1 - $products{$name}{discount}) * 1.09));
    #say $ltotal;
  }

  return $ltotal;
}


