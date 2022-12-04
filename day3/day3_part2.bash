# open the file into xargs, which will read the lines
# three at a time.
# then do a three way string intersection in python.

# logic is exactly the same as part 1 after this.

cat $1 | xargs -L 3 echo \
     | python3 -c 'import sys; [ print("".join(set(x.split()[0]).intersection(x.split()[1]).intersection(x.split()[2]))) for x in sys.stdin ]' \
     | sed -e "s/^/\\\'/" \
     | xargs -I@ printf "%s\t%d\n" @ @ \
     | cut -c 2- \
     | awk '{ if ($1 ~ /[A-Z]/) { print (($2 - 64) + 26) } else { print ($2 - 96) }}' \
     | awk 'BEGIN {sum = 0} { sum += $1 } END { print sum }'
