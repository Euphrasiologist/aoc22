# another good use of awk arrays.
# here we split each field on the dash separator and load
# the min and max into the x/y arrays.
# whichever array has the highest starting value needs to be compared
# to the lower of the array values, hence the if statement.

# otherwise we are simply comparing if the range is nested.

# printing a bool results in an integer in awk, so we are only
# interested where both are true

awk -F, '{ split($1, x, "-"); split($2, y, "-"); if (y[1] >= x[1]) { print ( y[1] >= x[1], y[2] <= x[2] ) } else { print ( x[1] >= y[1], y[2] <= x[2] ) } }' $1 \
    | awk '{print $1 + $2}' \
    | grep -c "2"

# run with:
# bash day4.bash <input.txt>