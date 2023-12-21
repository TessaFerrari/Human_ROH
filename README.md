Calling ROH pipeline, in order:
---

makeTpedTfam.sh
  - create .tped and .tfam files from HG38 data

make_submit_garlic.sh
  - call ROH using GARLIC

splitROHperIndiv.sh
  - split .bed files by each individual

ABCsumROHlength.sh
  - create summary file with the family and # of ROHs (of length A, B, and C) for each individual
