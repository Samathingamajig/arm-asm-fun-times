# ARM Assembly Fun Times

Build Docker file

```sh
docker build -t arm-asm-fun-times .
```

Launch temporary Docker container

```sh
docker run -it --rm -v $(pwd)/src:/app/src arm-asm-fun-times bash
```

Compile something

```sh
cd src
gcc -o achoo achoo.s -g -lm -nostdlib # replace achoo as necessary
```

Run something

```sh
./achoo
./achoo foo bar
```

Debug something

```sh
gdb achoo
(gdb) b _start
(gdb) r
# or with arguments
(gdb) r foo bar
# then debug with gdb as normal
```
