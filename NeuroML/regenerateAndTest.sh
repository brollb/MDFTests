python alias name="#statement"#!/bin/bash
set -ex

run_gui_examples=true

if [[ ($# -eq 1) && ($1 == '-nogui') ]]; then
    run_gui_examples=false
fi

####  Generate and run jNeuroML version of the network from NeuroMLlite definition
python ABCD.py -jnml
####  Test running the jNeuroML version standalone (using https://github.com/NeuroML/pyNeuroML)
pynml LEMS_SimABCD.xml -nogui

####  Generate PsyNeuLink version of the network from NeuroMLlite definition
python ABCD.py -pnl
####  Load in PsyNeuLink version & run


## Todo: fix failing!
##### python test_bids_import.py


####  Generate MDF version of the network from NeuroMLlite definition
python ABCD.py -mdf

####  Generate a graph depicting the structure & *dynamics* of the network from the LEMS description
pynml LEMS_SimABCD.xml -lems-graph

if [ "$run_gui_examples" == true ]; then
    ####  Generate a graph depicting the structure of network from NeuroMLlite
    python ABCD.py -graph2

fi


####  Generate and run jNeuroML version of the network from NeuroMLlite definition
python FN.py -jnml
####  Generate PsyNeuLink version of the network from NeuroMLlite definition
python FN.py -pnl


####  Generate a graph depicting the structure of the network from the LEMS description
pynml LEMS_SimFN.xml -lems-graph

echo "Successfully ran all tests"
