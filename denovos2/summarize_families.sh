#!/bin/bash

source params.sh

tmpdir=$(mktemp -d)

echo $tmpdir

cat ${OUTDIR}/denovos_chr*_bylength.all_mutations.tab | grep -v chrom | \
    awk -v"pthresh=${PTHRESH}" '($7>=pthresh)' > ${tmpdir}/all_denovos.tab

# By family
cat ${tmpdir}/all_denovos.tab | cut -f 4 | sort | uniq -c | \
    sed -e 's/ *//' -e 's/ /\t/' | \
    awk '{print $2 "\t" $1}' | sort -k2 -n > ${OUTDIR}/denovos_bylength_byfamily.tab

# By child
cat ${tmpdir}/all_denovos.tab | cut -f 4,5,6 | sort | uniq -c | \
    sed -e 's/ *//' -e 's/ /\t/' | \
    awk '{print $2 "\t" $3 "\t" $4 "\t" $1}'  > ${OUTDIR}/denovos_bylength_bychild.tab