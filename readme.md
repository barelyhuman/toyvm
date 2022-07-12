# toy-vm

Things accomplished.

1. Wanted to practice a bit of C, so wrote this in C first.
2. Hated how much work it is to split a string by delimeter in C, so rewrote the
   entire thing in Nim to feel good about other languages.
3. Create a simple stack based register
4. Wrote notes in the code for anyone else to understand what on earth does the
   code do.


## Usage 
Not very functional but you can run the demo `.reaper` file like so 
```
./toyvm prog.reaper
```

You will need `toyvm` which will need building. 

## Build
Make sure you have nim installed on your system. 
- [Nim Lang Install](https://nim-lang.org)

That's it, that's all we need. 

```sh
# if you also installed nimble 
nimble build 
# if not 
nim c -o:toyvm src/toyvm.nim
```


