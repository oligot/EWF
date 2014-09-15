#!/bin/sh
docker run -ti --rm -v $(pwd):/eiffel/EWF -w /eiffel/EWF/examples/filter oligot/eiffel ecb -config filter-safe.ecf -c_compile -finalize
