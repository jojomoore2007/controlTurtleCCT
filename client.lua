sha256 = require 'sha256'
peripheral.find('modem',rednet.open)
print('password:')
passwd = read("*")
code = fs.open('code.lua','r')
payload = code.readAll()
code.close()
rednet.broadcast(sha256(passwd..payload..string.format('%d',math.floor(os.epoch()/1000)+os.computerID()))..payload,'control')
