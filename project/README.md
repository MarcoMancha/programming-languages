# Guess Who!

Prolog application to guess a heroe/villain.

## Tools

* Swi-prolog
* Java > 8.0
* [JPL](https://code.google.com/archive/p/javanaproche/wikis/HowToJPL.wiki)(Library to communicate prolog with java)
* Python 2.7

## Installing JPL

It's a little bit annoying to install JPL, you can follow [this](https://www.youtube.com/watch?v=cu8HxEpmrQU&t=465s) tutorial with the link I provide bellow.

Also you have to create the following environment variables, to tell prolog where are executables jpl needs:
```bash

# Path to libjvm.so
export LD_LIBRARY_PATH=/usr/lib/jvm/java-12-oracle/lib/server/${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# Path to java
export JAVA_HOME=/usr/lib/jvm/java-12-oracle

# Path to libswipl.so
export LD_PRELOAD=/usr/lib/libswipl.so

# Path to prolog
export SWIPL=/usr/lib/swi-prolog
```

## Running the app

To run the prolog app using Java and JPL

`$ swipl -q -t start akijava.pl`

To run just the prolog app

`$ swipl -q -t start akinator_prolog.pl`

And follow the instructions of the game.

