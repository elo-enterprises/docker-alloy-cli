#FROM python:3.8
FROM debian:bookworm

RUN \
    --mount=type=cache,target=/var/cache/apt \
    apt-get update && apt-get install -y gcc g++ openjdk-17-jdk-headless git tree
RUN echo cache-bust 
COPY . /opt/alloy-cli
RUN cd /opt/alloy-cli && bash ./gradlew distTar && tar -xvf ./build/distributions/alloy-cli.tar
RUN echo '#!/bin/bash' > /bin/alloy-run && echo 'exec /opt/alloy-cli/alloy-cli/bin/alloy-cli "$@"' >> /bin/alloy-run
RUN chmod o+x /bin/alloy-run
ENTRYPOINT ["/bin/alloy-run"]

