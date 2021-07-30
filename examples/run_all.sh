#!/bin/bash
set -euo pipefail

for example in woody_hosts recycled_water drained_ponds fungal_mock great_lakes fecal_sequel soil_nematodes endangered_species; do
    echo "========================="
    echo "Running $example"
    echo "========================="
    cd $example
    time ./run.sh
    cd ..
done

echo "========================="
echo "Ran all examples"
echo "========================="
