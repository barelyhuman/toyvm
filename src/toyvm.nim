import strutils
import os

# define globals to track the VM's instructions
# `program` refers to the sequence of instructions 
# passed to the vm.
var program:seq[string] = @[]
# `stack` refers to the current execution stack and 
# can be added to based on instructions 
# eg: SHOVE 1 would push 1 into the stack and 
# REAP 1 would pop it out.
var stack:seq[string] = @[]
# `ip` points to the current instruction that's being processed
var ip = 0;
# `running` whether the program is currently running or has stopped due to an error or the `HALT` instruction
var running = true;

# returns the current active instruction
proc getInstruction():string =
  return program[ip]

# process the instruction 
proc processInstruction(instr:string) =
  case instr:
      # push the 2nd key of `SHOVE hello` to the stack
      of "SHOVE":
        ip+=1
        stack.add(program[ip])
      # push `\n` to the stack
      of "RET":
        stack.add("\n")
      # combine the last 2 elements from the stack
      of "COMB":
        let a = stack.pop()
        let b = stack.pop()
        stack.add(b&a)
      # pop out the last element in the stack and print it
      of "REAP":
        echo stack.pop()
      # stop the execution of the program
      of "HALT":
        running = false
  

proc main()=

  # get the args passed to the vm cli
  var nargv =  newSeq[string](paramCount())
  var x = 0
  while x < paramCount():
    nargv[x] = paramStr(x+1) 
    x += 1

  # the vm expects the first arg to be a file and 
  # reads it line by line to generate a program for you
  # this is all you'd need to change this to make it 
  # a toy interpreted vm, instead of it collecting the 
  # syntax into a `program` vairable, 
  # you could just process each line as it gets read
  for line in lines nargv[0]:
    var lineSplits = line.split({';'})
  
    for i in lineSplits:
      var norml = i.replace("\n")
      for action in norml.split({' '},1):
        program.add(action.replace("\"",""))
  
  # the program execution loop
  while(running):
    processInstruction(
      getInstruction()
    )
    ip+=1
    

when isMainModule:
  main()
