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

Runs all actions (`run` or `check`) in a given `.als` file and returns JSON from the solver.  
Example usage

-------------------------------------------------------------------------------

## Installation

(See also the [upstream docs](https://github.com/motemen/kt-alloy-cli) for details about native installation.)

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

See the [Installation](#installation) section for details about native install, but recommended usage is with docker:

```bash 

# Use image on dockerhub
$ docker run eloengineering/alloy-cli -v `pwd`:/workspace -w /workspace tests/knights-satisfiable.als

# Or Build/run from this repo
$ make build
$ docker run alloy-cli -v `pwd`:/workspace -w /workspace tests/knights-satisfiable.als
```

**When the solver is successful,** output is JSON:

```json 

{"Run Puzzle for 10": [[
  {
    "tuple": {"atom": {"label": "Knave$0"}},
    "types": {"type": {"ID": 5}},
    "label": "$Puzzle_A",
    "ID": 7
  },
  {
    "tuple": {"atom": {"label": "Knight$0"}},
    "types": {"type": {"ID": 5}},
    "label": "$Puzzle_B",
    "ID": 8
  }
]]}

```

**In case the solver is unsuccessful,** invocation throws code 2 and output like this:

```bash

$ docker run --rm -v `pwd`:/workspace -w /workspace \
  alloy-cli tests/knights-unsatisfiable.als

---OUTCOME---
Unsatisfiable.

Exception in thread "main" API usage error:
This solution is unsatisfiable.
	at edu.mit.csail.sdg.alloy4compiler.translator.A4SolutionWriter.writeInstance(A4SolutionWriter.java:210)
	at edu.mit.csail.sdg.alloy4compiler.translator.A4Solution.writeXML(A4Solution.java:1134)
	at edu.mit.csail.sdg.alloy4compiler.translator.A4Solution.writeXML(A4Solution.java:1111)
	at edu.mit.csail.sdg.alloy4compiler.translator.A4Solution.writeXML(A4Solution.java:1098)
	at MainKt.main(main.kt:54)
```

See also the [smoke-test target](Makefile).

-------------------------------------------------------------------------------

## Releases 

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

This is a fork of [motemen/kt-alloy-cli](https://github.com/motemen/kt-alloy-cli), which returns results compatible with [test-anything protocol](https://testanything.org/).

### Official Docs 

* https://alloy.readthedocs.io
* http://alloytools.org/documentation/alloy-api/index.html
* http://alloy.mit.edu/alloy/


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

-------------------------------------------------------------------------------

