use strict;
use warnings;

use Test::More tests => 11;

BEGIN {
  use_ok( 'Bio::RNA::SpliceSites::Scoring::MaxEntScan' , qw/ score5 / );
  use_ok( 'Bio::RNA::SpliceSites::Scoring::MaxEntScan' , qw/ score3 / );
  use_ok( 'Bio::RNA::SpliceSites::Scoring::MaxEntScan' , qw/ :all   / );
  use_ok( 'Bio::RNA::SpliceSites::Scoring::SpliceModels::splice5sequences' );
  use_ok( 'Bio::RNA::SpliceSites::Scoring::SpliceModels::me2x5' );
  use_ok( 'Bio::RNA::SpliceSites::Scoring::SpliceModels::me2x3acc' );
};

pass( "Beginning test suite...\n" );

use Bio::RNA::SpliceSites::Scoring::MaxEntScan qw/ :all /; #Import subroutines for testing.

#Test required modules:
require_ok( 'Carp' );

#Subtest to test score5 subroutine:
subtest 'Five prime splice site scoring subtest' => sub { #Test the scoring subroutine using the maxEntScan test5 sequences, also three tests for invalid subroutine calls.
  plan tests => 5;
  my ( $first_sequence , $second_sequence , $invalid_length , $invalid_alphabet ) =
     ( 'acggtaagt' , 'caggtaagt' , 'caggtaag' , 'caggtaagn'  );
  is( score5( \$first_sequence   ) , 11.81 , "First 5'ss test" );
  is( score5( \$second_sequence  ) , 10.86 , "Second 5'ss test" );
  is( score5( $second_sequence   ) , 'invalid_invocation' , "Invalid 5'ss invocation test" );
  is( score5( \$invalid_length   ) , 'invalid_length' , "Invalid 5'ss length test" );
  is( score5( \$invalid_alphabet ) , 'invalid_alphabet' , "Invalid 5'ss alphabet test" );
};

#Subtest to test score3 subroutine:
subtest 'Three prime splice site scoring subtest' => sub { #Test the scoring subroutine using the maxEntScan test3 sequence, also three tests for invalid subroutine calls.
  plan tests => 4;
  my ( $test_sequence , $invalid_length , $invalid_alphabet ) =
     ( 'ctctactactatctatctagatc' , 'ctctactactatctatctagat' , 'ctctactactatctatctagatr' );
  is( score3( \$test_sequence  )   , 6.71 , "First 3'ss test" );
  is( score3( $test_sequence   )   , 'invalid_invocation' , "Invalid 3'ss invocation test" );
  is( score3( \$invalid_length )   , 'invalid_length' , "Invalid 3'ss length test" );
  is( score3( \$invalid_alphabet ) , 'invalid_alphabet' , "Invalid 3'ss alphabet test" );
};

pass( "Test suite complete.\n" );
