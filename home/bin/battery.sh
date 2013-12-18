#!/bin/sh
acpi -b | egrep -o [0-9]+%
