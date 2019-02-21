import asyncnet, asyncdispatch
import strutils, unicode

var clients {.threadvar.}: seq[AsyncSocket]

proc fizzBuzz(num: int): string = 
  if num mod 15 == 0:
    result = "FizzBuzz"
  elif num mod 3 == 0:
    result = "Fizz"
  elif num mod 5 == 0:
    result = "Buzz"
  else:
    result = "not Fizz and Buzz"

proc processClient(client: AsyncSocket) {.async.} =
  while true:
    let line = await client.recvLine()
    if line.len == 0: break
    if line.isAlphaNumeric and not line.isAlpha :  # num = (alpha + num) - alpha      
      let fb: string = fizzBuzz(line.parseInt)
      for c in clients:
        await c.send(line & " is " & fb & "\c\L")
    else:
      await client.send(line & " is'nt a number.\c\L")


proc server() {.async.} =
  clients = @[]
  var server = newAsyncSocket()
  server.setSockOpt(OptReuseAddr, true)
  server.bindAddr(Port(8946))
  server.listen()

  while true:
    var c = await server.accept()
    clients.add(c)

    asyncCheck processClient(c)
  
when isMainModule:
  asyncCheck server()
  runForever()