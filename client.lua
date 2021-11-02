sha256 = require 'sha256'
peripheral.find('modem',rednet.open)
payload = 'print("hi")'
rednet.broadcast(sha256(passwd..payload..string.format('%d',math.floor(os.epoch()/1000)+os.computerID()))..payload,'control')
