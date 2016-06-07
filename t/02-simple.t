use Test::More;
use Test::Warnings;

use TimeSeries::AdaptiveFilter qw/filter/;

ok filter(), "constructed with defaults";

# my birthday. Why not? :)
my $base_time = 413683200;


subtest "startup" => sub {
  my $build_up_count = 10;
  my $f = filter({build_up_count => $build_up_count});
  for my $idx (0 .. $build_up_count - 1) {
    ok($f->($base_time + $idx, rand() * 1000), "input data $idx passes as it is build_time");
  }
};

subtest "constant stream" => sub {
  my $f = filter();
  for my $idx (0 .. 100) {
    ok($f->(1 + $idx / 10, 1), "input data $idx passes");
  }
};

subtest "tiny disturbance" => sub {
  my $f = filter();
  my $base = 1000;
  my $delta = 0.1;
  for my $idx (0 .. 100) {
    ok($f->($base_time + $idx / 10, $base + $delta * rand()), "input data $idx passes");
  }
};

subtest "large disturbance" => sub {
  my $f = filter();
  my $floor = 6;
  my $build_up_count = 10;
  my $f = filter({floor => $floor});
  my $delta = 0.1;
  for my $idx (0 .. 61) {
    my ($epoch, $value) = ($base_time + $idx, 100 + $delta * rand());
    ok($f->($epoch, $value), "input data ($epoch // $value ) $idx passes");
  }
  ok $f->($base_time + 62, 100 + $delta * rand()), "manual tick with small disturbance";
  ok !$f->($base_time + 62, 1000), "large spot disturbance shall not pass";
};

done_testing;
