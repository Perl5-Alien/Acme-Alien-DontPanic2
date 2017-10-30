use Test2::V0 -no_srand => 1;
use Test::Alien 0.05;
use Acme::Alien::DontPanic2;

alien_ok 'Acme::Alien::DontPanic2';

my $xs = do { local $/; <DATA> };

xs_ok { xs => $xs, verbose => 1 }, with_subtest {
  my($module) = @_;
  plan 1;
  is $module->answer, 42, 'answer is 42';
};

run_ok('dontpanic')
  ->success
  ->out_like(qr{the answer to life the universe and everything is 42})
  ->note;

done_testing;

__DATA__

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <libdontpanic.h>

MODULE = TA_MODULE PACKAGE = TA_MODULE

int answer(class)
    const char *class;
  CODE:
    RETVAL = answer();
  OUTPUT:
    RETVAL
