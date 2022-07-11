import strutils
import os

var program:seq[string] = @[]
var stack:seq[string] = @[]
var ip = 0;
var running = true;

proc getInstruction():string =
  return program[ip]

proc processInstruction(instr:string) =
  case instr:
      of "SHOVE":
        ip+=1
        stack.add(program[ip])
      of "RET":
        stack.add("\n")
      of "COMB":
        let a = stack.pop()
        let b = stack.pop()
        stack.add(b&a)
      of "REAP":
        echo stack.pop()
      of "HALT":
        running = false
  

proc main()=

  var nargv =  newSeq[string](paramCount())
  var x = 0
  while x < paramCount():
    nargv[x] = paramStr(x+1) 
    x += 1

  for line in lines nargv[0]:
    var lineSplits = line.split({';'})
  
    for i in lineSplits:
      var norml = i.replace("\n")
      for action in norml.split({' '},1):
        program.add(action.replace("\"",""))
  
  while(running):
    processInstruction(
      getInstruction()
    )
    ip+=1
    

when isMainModule:
  main()
