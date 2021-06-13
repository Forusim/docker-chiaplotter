
#!/bin/bash

source plotter.cfg

if [[ -v n ]]; then CMD+="-n ${n}"; fi

if [[ -v r ]]; then CMD+="-r ${r}"; fi

if [[ -v u ]]; then CMD+="-u ${u}"; fi

if [[ -v t ]]; then CMD+="-t ${t}"; fi

if [[ -v t2 ]]; then CMD+="-2 ${t2}"; fi

if [[ -v d ]]; then CMD+="-d ${d}"; fi

if [[ -v p ]]; then CMD+="-p ${p}"; fi

if [[ -v f ]]; then CMD+="-f ${f}"; fi

./chia_plot $CMD
