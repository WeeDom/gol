use strict;
use warnings 'all';
use Test::Simple qw(no_plan);
use Data::Dumper;
require "/Users/dominic.pain/gol/gol.pl";
ok(1 eq 1);
ok( is_alive('*'), 'a star (*) is alive' );
ok( !is_alive('.'), 'a dot (.) is dead' );
my @lonely_test_grid = (
    ['.', '.', '.'],
    ['.', '*', '.'],
    ['.', '.', '.']
);
my @happy_medium_grid = (
    ['*', '*', '.'],
    ['.', '*', '.'],
    ['.', '.', '.']
);
my @overpopulated_grid = (
    ['*', '*', '*'],
    ['.', '*', '*'],
    ['.', '.', '.']
);
my @resurrect_grid = (
    ['.', '*', '*'],
    ['.', '.', '*'],
    ['.', '.', '.']
);
ok( !has_up_nb(\@lonely_test_grid,0,0), 'lonely: upstairs neighbour does not exist');
ok( !has_up_nb(\@lonely_test_grid,1,1), 'lonely: upstairs neighbour is dead');
ok( has_up_nb(\@happy_medium_grid ,1,1), 'happy medium: upstairs neighbour is alive');
ok( has_up_nb(\@overpopulated_grid,1,1), 'overpopulated: upstairs neighbour is alive');
# check what happens if we try to check on a neighbour which doesn't exist
ok( !has_up_nb(\@lonely_test_grid,0,1), 'lonely: upstairs neighbour doesn\'t exists');

ok( !has_down_nb(\@lonely_test_grid,1,1), 'lonely: downstairs neighbour is dead');
ok( !has_down_nb(\@happy_medium_grid ,1,1), 'happy medium: downstairs neighbour is dead');
ok( !has_down_nb(\@overpopulated_grid,1,1), 'overpopulated: downstairs neighbour is dead');
ok( !has_down_nb(\@overpopulated_grid,2,1), 'overpopulated: downstairs neighbour does not exist');

ok( !has_left_nb(\@lonely_test_grid,1,1), 'lonely: left neighbour is dead');
ok( !has_left_nb(\@happy_medium_grid ,1,1), 'happy medium: left neighbour is dead');
ok( !has_left_nb(\@overpopulated_grid,1,1), 'overpopulated: left neighbour is dead');
ok( !has_left_nb(\@overpopulated_grid,1,0), 'overpopulated: left neighbour does not exist');

ok( !has_right_nb(\@lonely_test_grid,1,1), 'lonely: right neighbour is dead');
ok( !has_right_nb(\@happy_medium_grid ,1,1), 'happy medium: right neighbour is dead');
ok( has_right_nb(\@overpopulated_grid,1,1), 'overpopulated: right neighbour is alive');

ok( !has_down_left_diag_nb(\@lonely_test_grid,1,1), 'lonely: down_left_diag neighbour is dead');
ok( !has_down_left_diag_nb(\@happy_medium_grid ,1,1), 'happy medium: down_left_diag neighbour is dead');
ok( !has_down_left_diag_nb(\@overpopulated_grid,1,1), 'overpopulated: down_left_diag neighbour is dead');

ok( !has_down_right_diag_nb(\@lonely_test_grid,1,1), 'lonely: down_right_diag neighbour is dead');
ok( !has_down_right_diag_nb(\@happy_medium_grid ,1,1), 'happy medium: down_right_diag neighbour is dead');
ok( !has_down_right_diag_nb(\@overpopulated_grid,1,1), 'overpopulated: down_right_diag neighbour is dead');
ok( !has_down_right_diag_nb(\@overpopulated_grid,1,2), 'overpopulated: down_right_diag neighbour does not exist');

ok( !has_up_left_diag_nb(\@lonely_test_grid,1,1), 'lonely: up_left_diag neighbour is dead');
ok( has_up_left_diag_nb(\@happy_medium_grid ,1,1), 'happy medium: up_left_diag neighbour is alive');
ok( has_up_left_diag_nb(\@overpopulated_grid,1,1), 'overpopulated: up_left_diag neighbour is alive');
ok( !has_up_left_diag_nb(\@overpopulated_grid,0,0), 'overpopulated: up_left_diag neighbour does not exist');

ok( !has_up_right_diag_nb(\@lonely_test_grid,1,1), 'lonely: up_right_diag neighbour is dead');
ok( !has_up_right_diag_nb(\@happy_medium_grid ,1,1), 'happy medium: up_right_diag neighbour is alive');
ok( has_up_right_diag_nb(\@overpopulated_grid,1,1), 'overpopulated: up_right_diag neighbour is alive');
ok( !has_up_right_diag_nb(\@overpopulated_grid,0,2), 'overpopulated: up_right_diag neighbour does not exist');

ok( new_state(\@lonely_test_grid,1,1) eq '.', 'lonely cells die' );
ok( new_state(\@happy_medium_grid,1,1) eq '*', 'happy_medium cells live');
ok( new_state(\@overpopulated_grid,1,1) eq '.', 'overpopulated cells die' );
ok( new_state(\@resurrect_grid,1,1) eq '*', 'dead  cells resurrect with 3 neighbours' );
#my @neighbourly_grid = (
    #['*','*','*'],
    #['.','*','*'],
    #['.','.','.']
#);
#ok( new_state(\@neighbourly_grid,1,1) eq '.', 'overcrowded cells die' );
#my @survivor_grid = (
    #['.','*','*'],
    #['.','*','*'],
    #['.','.','.']
#);
#ok( new_state(\@survivor_grid,1,1) eq '*',
    #'living cells with good neighbours stay alive' );

