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
      CLI runner for the <a href=https://alloy.readthedocs.io>alloy specification language</a>.  
      <br/>Returns JSON for the solver output, and runs from docker so you don't need a java stack.
    </td>
  </tr>
</table>

-------------------------------------------------------------------------------
<img src="https://github.com/elo-enterprises/docker-alloy-cli/actions/workflows/docker-build-push.yml/badge.svg"> [<img src="https://img.shields.io/badge/dockerhub-4.2-blue.svg?logo=Docker">](https://hub.docker.com/r/eloengineering/alloy-cli/tags) <img src="https://img.shields.io/badge/debian-bookworm-orange"> <img src="https://img.shields.io/badge/kotlin-1.6.21-orange">

  * [Overview](#overview)
  * [Usage](#usage)
  * [Output](#output)
    * [On Success](#on-success)
    * [On Error](#on-error)
  * [Releases](#releases)
  * [Development](#development)
    * [For Docker](#for-docker)
    * [Native Installation](#native-installation)
  * [Other Resources](#other-resources)


-------------------------------------------------------------------------------

## Overview 

A CLI for running the [Alloy Analyzer](http://alloytools.org/).

This runs all actions (`run` or `check`) in a given `.als` file and returns JSON from the solver.  

-------------------------------------------------------------------------------

## Usage 

See the [Installation](#installation) section for details about native install, but recommended usage is with docker.  (The examples below use the sample alloy-lang files in the [tests/ folder](tests/).)

```bash 

# Use image on dockerhub
$ docker run  --rm -v `pwd`:/workspace -w /workspace eloengineering/alloy-cli:4.2 tests/knights-satisfiable.als

# Or Build/run from this repo
$ make build
$ docker run  --rm -v `pwd`:/workspace -w /workspace alloy-cli tests/knights-satisfiable.als
```

## Output 

### On Success 

**When the solver is successful,** stderr output is human-friendly: 

```
---INSTANCE---
integers={}
univ={Knight$0, Knave$0}
Int={}
seq/Int={}
String={}
none={}
this/Knight={Knight$0}
this/Knave={Knave$0}
this/Person={Knight$0, Knave$0}
skolem $Puzzle_A={Knave$0}
skolem $Puzzle_B={Knight$0}
```

 Meanwhile stdout is machine-friendly JSON, in case you want to pass it downstream.  

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

### On Error

**In case the solver is unsuccessful,** invocation throws code 2 and output like this:

```bash

$ docker run --rm -v `pwd`:/workspace -w /workspace alloy-cli tests/knights-unsatisfiable.als

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

See also the [smoke-test target in project automation](Makefile).

-------------------------------------------------------------------------------

## Releases 

See [dockerhub for releases](https://hub.docker.com/r/eloengineering/alloy-cli/tags).

-------------------------------------------------------------------------------

## Development

### For Docker 

```bash

# build the docker container 
make build

# run smoke-tests for container
make test

# drop into debugging shell inside the container
make shell
```

### Native Installation

(See also the [upstream docs](https://github.com/motemen/kt-alloy-cli) for details about native installation.)

```bash 
$ ./gradelw distTar
```

Then extract ./build/distributions/kt-alloy-cli.tar somewhere and place a file named `alloy-run` under PATH with its contents:

```
#!/bin/bash
exec path/to/bin/kt-alloy-cli "$@"
```

-------------------------------------------------------------------------------

## Other Resources 

This is a fork of [motemen/kt-alloy-cli](https://github.com/motemen/kt-alloy-cli), which returns results compatible with [test-anything protocol](https://testanything.org/).

See also the [Alloy-lang docs](https://alloy.readthedocs.io), [API docs](http://alloytools.org/documentation/alloy-api/index.html), or [project page](http://alloy.mit.edu/alloy/).

Running the alloy analyzer GUI from docker is also possible, but can be problematic:

```
# https://jessitron.com/2020/04/17/run-alloy-on-windows-in-docker/
docker run -v `pwd`:/workspace -e DISPLAY=host.docker.internal:0 jessitron/alloy:5.1
```


See also [1](https://gist.github.com/sorny/969fe55d85c9b0035b0109a31cbcb088), [2](https://gist.github.com/cschiewek/246a244ba23da8b9f0e7b11a68bf3285), and [3](https://gist.github.com/paul-krohn/e45f96181b1cf5e536325d1bdee6c949) for stuff that might help for MacOS.

See [arby](https://aleksandarmilicevic.github.io/arby/) for an embedding of alloy-lang in ruby.  See [1](https://hustleplay.wordpress.com/2010/02/18/jpype-tutorial/),[2](https://jpype.readthedocs.io/en/latest/install.html) for stuff that might help with python inter-op.

-------------------------------------------------------------------------------

