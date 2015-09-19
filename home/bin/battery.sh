#!/bin/sh
acpi -b | egrep -o [0-9]+% | sed '{:q;N;s/\n/ /g;t q}'
