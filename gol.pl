use strict;
use warnings;

use constant ALIVE => '*';
use constant DEAD => '.';

my @grid = ();
my $rows = 0;
while(<DATA>) {
    chomp;
    my $cols = 0;                                                                         
    my @cells = split('', $_);
    foreach(@cells) {
        $grid[$rows][$cols] = $_;
        $cols++;
    }
    $rows++;
}
print cycle();
sub _grid_as_string {
	my $string;
	foreach my $row (@grid) {
		my @cols = @$row;
		$string .= $_ foreach @cols;
		$string .= "\n";
	}
	return $string;
}

sub cycle {
    for (my $r = 0; $r < scalar @grid; $r++) {
        for (my $c = 0; $c < scalar @{$grid[$r]}; $c++) {       
			#print "$r,$c\n";
			#print "current state of $r, $c: " . @$grid[$r]->[$c] . "\n";
			my $new_state = new_state($r,$c);
			$grid[$r]->[$c] = $new_state;
        }
    }
	return _grid_as_string();
}

sub new_state {
    my ($row, $column) = @_;
    my $living_neighbours_count = 0;
    
    my $current_state;
	if($grid[$row]->[$column] eq ALIVE) {
		$current_state = ALIVE;
	}
	elsif ($grid[$row]->[$column] eq DEAD) {
		$current_state = DEAD;
	}
	else {
		print "what's " . $grid[$row]->[$column] . "\n";
	}

    has_up_nb($row, $column) && $living_neighbours_count++;
    has_down_nb($row, $column) && $living_neighbours_count++;
    has_left_nb($row, $column) && $living_neighbours_count++;
    has_right_nb( $row, $column) && $living_neighbours_count++;
    has_down_left_diag_nb($row, $column) && $living_neighbours_count++;
    has_down_right_diag_nb($row, $column) && $living_neighbours_count++;
    has_up_left_diag_nb($row, $column) && $living_neighbours_count++;
    has_up_right_diag_nb($row, $column) && $living_neighbours_count++;
    ##1. Any live cell with fewer than two live neighbours
    ## dies, as if caused by underpopulation.
    ##2. Any live cell with more than three live neighbours
    ## dies, as if by overcrowding.
    ## 3. Any live cell with two or three live neighbours
    ## lives on to the next generation.
    ## 4. Any dead cell with exactly three live neighbours
    ## becomes a live cell.
    if ($current_state eq ALIVE) {
        if($living_neighbours_count == 2 || $living_neighbours_count == 3) {
			print "living neighbour was $living_neighbours_count - return alive\n";
            return ALIVE;
        }
        if ($living_neighbours_count < 2 || $living_neighbours_count > 3) {
			print "living neighbours: $living_neighbours_count - return dead\n";
            return DEAD;
        }
    }

    if($current_state eq DEAD) {
        if($living_neighbours_count == 3) {
			print "lving neighburs is $living_neighbours_count - magic! return alive\n";
            return ALIVE;
        }
		else {
			return DEAD;
		}
    }
	print "lving neighbours was $living_neighbours_count - returning false\n";
	return 0;
}

sub has_up_nb {
    my ($r, $c) = @_;  
    return is_alive($grid[$r -1]->[$c]) if ($r - 1 >= 0);
    return 0;
}

sub has_down_nb {
    my ($r, $c) = @_;
    return $grid[$r +1] ?  is_alive($grid[$r +1]->[$c]) : 0;
}

sub has_left_nb {
    my ($r, $c) = @_;
    return is_alive($grid[$r]->[$c -1]) if ($c -1 >= 0);
}

sub has_right_nb {
    my ($r, $c) = @_;
    return $grid[$r]->[$c +1] ? is_alive($grid[$r]->[$c +1]) : 0;
}
sub has_down_left_diag_nb {
    my ($r, $c) = @_;
    if ($grid[$r + 1]) {
        if ($grid[$r + 1]->[$c - 1]) { 
            return is_alive($grid[$r + 1]->[$c - 1]);
        }   
    }  
}

sub has_down_right_diag_nb {
    my ($r, $c) = @_;
    if ($grid[$r + 1]) {
        if ($grid[$r + 1]->[$c + 1]) { 
            return is_alive($grid[$r + 1]->[$c + 1]);
        }   
    }  
}

sub has_up_left_diag_nb {
    my ($r, $c) = @_;
    if ($grid[$r - 1]) {
        if ($grid[$r - 1]->[$c - 1]) {
            return is_alive($grid[$r - 1]->[$c - 1]);
        }
    }
}

sub has_up_right_diag_nb {
    my ($r, $c) = @_;
    if ($grid[$r - 1]) {
        if ($grid[$r - 1]->[$c + 1]) {
            return is_alive($grid[$r - 1]->[$c + 1]); 
        }
    }  
}



sub is_alive {
    my $cell = shift;
    return $cell eq ALIVE;
}

1;

__DATA__
........
....*...
...**...
........
