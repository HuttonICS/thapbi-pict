#!/bin/bash
set -eup pipeline

# Intended to remove intermediate files, custom DB, but not summary reports.

for example in woody_hosts recycled_water fungal_mock microalgal_mock great_lakes fecal_sequel endangered_species; do
    echo "========================="
    echo "Cleaning $example"
    echo "========================="
    rm -rf $example/*.sqlite $example/intermediate* $example/tmp_merged
    echo "Done"
done

echo "=============================="
echo "Removed all intermediate files"
echo "=============================="
