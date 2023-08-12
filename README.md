Dockerized version of https://github.com/motemen/kt-alloy-cli

```bash
make
```

https://hub.docker.com/r/eloengineering/alloy-cli/tags

https://gist.github.com/sorny/969fe55d85c9b0035b0109a31cbcb088
https://gist.github.com/cschiewek/246a244ba23da8b9f0e7b11a68bf3285
https://gist.github.com/paul-krohn/e45f96181b1cf5e536325d1bdee6c949
https://alloy.readthedocs.io/en/latest/tooling/themes.html
https://docs.github.com/en/actions/publishing-packages/publishing-docker-images#publishing-images-to-docker-hub
https://github.com/motemen/kt-alloy-cli
https://hustleplay.wordpress.com/2010/02/18/jpype-tutorial/
http://alloytools.org/documentation/alloy-api/index.html
https://jpype.readthedocs.io/en/latest/install.html

```
# https://jessitron.com/2020/04/17/run-alloy-on-windows-in-docker/
docker run -v `pwd`:/workspace -e DISPLAY=host.docker.internal:0 jessitron/alloy:5.1
```

# kt-alloy-cli

Command line interface for [Alloy Analyzer][alloy].

Runs all actions (`run` or `check`) in a given .als file and prints their results.
Outputs are in the format of [Test Anything Protocol][tap].

## Usage

    alloy-run [-V] <file.als>

For example:

    % alloy-run alloy-sketches/oauth2/oauth2.als
    1..3
    ok 1 - Run show for 6 but 1 AuthorizationServer, 1 Client
    ok 2 - Run allUserAgentsAreEventuallyAuthorized for 6 but exactly 1 AuthorizationServer, exactly 1 Client, 2 UserAgent
    not ok 3 - Check userAgentsAreProperlyAuthorized for 6 but exactly 1 AuthorizationServer, exactly 1 Client, 2 UserAgent

If `-V` option is given, shows graphical representations of found counterexamples.

## Installation

    ./gradelw distTar

Then extract ./build/distributions/kt-alloy-cli.tar somewhere and place a file named `alloy-run` under PATH with its contents:

    #!/bin/bash
    exec path/to/bin/kt-alloy-cli "$@"

[alloy]: http://alloy.mit.edu/alloy/
[tap]: https://testanything.org/
