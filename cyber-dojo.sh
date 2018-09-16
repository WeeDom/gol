#perl gol.pl 
HARNESS_DEBUG=1
perl -MTest::Harness -wle 'runtests @ARGV' *.t

