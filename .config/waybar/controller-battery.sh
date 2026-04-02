#!/bin/sh

ICON=" "
PERC=$(dualsensectl battery | awk '{ print $1 }')
STATUS=$(dualsensectl battery | awk '{ print $2 }')

OUTPUT="$ICON $PERC%"

# If no device connected, then echo nothing
if [ -z "$PERC" ]; then
    echo -n ""
    exit 0
fi

echo -n $OUTPUT
