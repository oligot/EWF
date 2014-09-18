#!/bin/sh
cd ../..
compile="ecb -config filter-safe.ecf -target filter_fcgi -c_compile -finalize"
docker run -ti --rm -v $(pwd):/eiffel/EWF -w /eiffel/EWF/examples/filter oligot/ewf $compile
cp examples/filter/EIFGENs/filter_fcgi/F_code/filter examples/filter
cd -
