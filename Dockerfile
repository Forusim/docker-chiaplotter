# Compiler image
# -------------------------------------------------------------------------------------------------
FROM alpine AS compiler

RUN apk --no-cache add \
    git gcc g++ build-base cmake libsodium-dev libsodium-static 

RUN git clone https://github.com/madMAx43v3r/chia-plotter.git --branch master --recurse-submodules \
 && cd chia-plotter \
 && /bin/sh ./make_devel.sh

# Runtime image
# -------------------------------------------------------------------------------------------------
FROM alpine AS runtime

RUN apk --no-cache add \
    tzdata nano bash

COPY --from=compiler /chia-plotter/build/chia_plot /madmax-plotter/

WORKDIR /madmax-plotter

VOLUME /config

COPY plotter.cfg.default /madmax-plotter/
COPY start.sh /madmax-plotter/

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["bash", "/entrypoint.sh"]
