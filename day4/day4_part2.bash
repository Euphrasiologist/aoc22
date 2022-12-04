# This was slightly simpler than the first part! 

awk -F, '{ split($1, x, "-"); split($2, y, "-"); { print ( y[2] >= x[1], x[2] >= y[1] )} }' $1 \
    | awk '{print $1 + $2}' \
    | grep -c "2"