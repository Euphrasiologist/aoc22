# BASH solution to day 3, leaning heavily on awk but maybe with some interesting bits.

# first awk splits each line into two equal halves, using the length command, and then
# substr to select the halves.

# the python bit finds the common letter between the two halves using sets. Doing this in BASH 
# would have been significantly harder.

# things start getting a bit weird now.
# to pre-format the intersected letters, we prepend this -> \'
# this is so the printf statement will work

# xargs passes the previously computed letters with \' prepended
# to the printf statement. We need to use each letter (e.g. \'A) twice
# hence the -I@ argument, and the two @'s later.

# next we want to get rid of the apostrophes at the start of each letter
# that's the cut.

# now we pass this table to awk, and subtract the correct amount from the 
# ASCII representation of the value (upper-case letters are before lower in the ASCII tables)
# and then account for the AoC scheme (+ 26 for uppercase letters.)

# lastly, use awk to sum this column.

awk '{ print substr( $0, 1, length / 2 ), substr( $0, length / 2 + 1 ) }' $1 \
  | python3 -c 'import sys; [ print("".join(set(x.split()[0]).intersection(x.split()[1]))) for x in sys.stdin ]' \
  | sed -e "s/^/\\\'/" \
  | xargs -I@ printf "%s\t%d\n" @ @ \
  | cut -c 2- \
  | awk '{ if ($1 ~ /[A-Z]/) { print (($2 - 64) + 26) } else { print ($2 - 96) }}' \
  | awk 'BEGIN {sum = 0} { sum += $1 } END { print sum }'
