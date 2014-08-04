# Depy

A simple (silly) dependency manager for C! (Super alpha / exploratory version!)

(The goal is to have depy written in shell to remove the ruby
dependency, but until then...)

## Installation

```
gem install depy
```

## How to Use

- start from a [boilerplate.c project](http://github.com/tjeezy/boilerplate.c).
- create a `Depfile` in the project's root, for example:

```
dep 'uthash'
```

- for other supported dependencies, use `depy list` or `depy search <term>` (ie. `depy search hash`)
- run `depy install`

At this point, `depy` will download all the dependencies' sources into `/deps`
add the appropriate `make` targets to the `/deps/Makefile`, and update
the -I, -L, -l CFLAGS.

With a simple `#include <uthash.h>`, you should be ready to `make` and
use the dependency!

## Goals / TODO

- [ ] support specifying version (git tag) / gitref
- [ ] support dynamic linking
- [ ] allow "recipes" to support other build systems than make (cmake, etc.)
- [ ] if necessary, not depend on github to host the dependency "recipes"
