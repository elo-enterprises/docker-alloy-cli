<table width=100%>
  <tr>
    <td colspan=2><strong>
    alloy-cli
      </strong>&nbsp;&nbsp;&nbsp;&nbsp;
      <small><small>
      </small></small>
    </td>
  </tr>
  <tr>
    <td width=15%><img src=img/icon.png style="width:150px"></td>
    <td>
      A fork of <a href=https://github.com/motemen/kt-alloy-cli>alloy-cli</a> with small changes for JSON output, plus added dockerization.
    </td>
  </tr>
</table>

-------------------------------------------------------------------------------

## Overview 

Command line interface for [Alloy Analyzer][alloy].

Runs all actions (`run` or `check`) in a given .als file and prints their results.
Outputs are in the format of [Test Anything Protocol][tap].

-------------------------------------------------------------------------------

## Installation

See also the [upstream docs](https://github.com/motemen/kt-alloy-cli) for details about native installation.  

```bash 
$ ./gradelw distTar
```

Then extract ./build/distributions/kt-alloy-cli.tar somewhere and place a file named `alloy-run` under PATH with its contents:

```
#!/bin/bash
exec path/to/bin/kt-alloy-cli "$@"
```

Or, to use the docker-container:

```bash
$ docker pull ...
```

-------------------------------------------------------------------------------

## Usage 


```bash 

$ alloy-run [-V] <file.als>
```

For example:

```
    % alloy-run alloy-sketches/oauth2/oauth2.als
    1..3
    ok 1 - Run show for 6 but 1 AuthorizationServer, 1 Client
    ok 2 - Run allUserAgentsAreEventuallyAuthorized for 6 but exactly 1 AuthorizationServer, exactly 1 Client, 2 UserAgent
    not ok 3 - Check userAgentsAreProperlyAuthorized for 6 but exactly 1 AuthorizationServer, exactly 1 Client, 2 UserAgent
```

If `-V` option is given, shows graphical representations of found counterexamples.

To use the docker-container run commands like this:

```bash 

$ docker run ...
```

See [dockerhub for releases](https://hub.docker.com/r/eloengineering/alloy-cli/tags).


-------------------------------------------------------------------------------

## Development

```bash

# build the docker container 
make build

# run smoke-tests for container
make test

# drop into debugging shell inside the container
make shell
```

-------------------------------------------------------------------------------

## Other Resources 

### Official Docs 

* https://alloy.readthedocs.io
* http://alloytools.org/documentation/alloy-api/index.html
* http://alloy.mit.edu/alloy/

### Upstream of this fork

* https://github.com/motemen/kt-alloy-cli

### Running the alloy analyzer GUI from docker

See also:

* https://gist.github.com/sorny/969fe55d85c9b0035b0109a31cbcb088
* https://gist.github.com/cschiewek/246a244ba23da8b9f0e7b11a68bf3285
* https://gist.github.com/paul-krohn/e45f96181b1cf5e536325d1bdee6c949
* https://jessitron.com/2020/04/17/run-alloy-on-windows-in-docker/ and 

```bash
docker run -v `pwd`:/workspace -e DISPLAY=host.docker.internal:0 jessitron/alloy:5.1
```
### Misc 

* https://hustleplay.wordpress.com/2010/02/18/jpype-tutorial/
* https://jpype.readthedocs.io/en/latest/install.html
* https://testanything.org/

-------------------------------------------------------------------------------

