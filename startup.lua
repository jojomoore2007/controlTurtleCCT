-- open rednet on all modems by abusing filter
peripheral.find("modem",rednet.open)
run = true
local oldpull = os.pullEvent
os.pullEvent = os.pullEventRaw
sha256 = require 'sha256'
local p = fs.open('passwd','r')
local passwd = p.readAll()
p.close()
function verify(msg,id)
    return (sha256(passwd..string.sub(msg,65)..string.format('%d',id))==string.sub(msg,1,64)),string.sub(msg,65)
end
while run do
    id,msg = rednet.receive("control")
    print(string.format("got msg from computer %d, verifying integrity...",id))
    check,x = verify(msg,id+math.floor(os.epoch(ingame)/1000))
    if check then
        print("verification successful!")
        print("writing code...")
        h=fs.open("code.lua","w")
        h.write(x)
        h.close()
        print("running code...")
        shell.run("code.lua")
        print("done!")
    else
        print("VERIFICATION FAILED!")
        print("This incident has been logged.")
        h=fs.open(string.format('/failed/%d.lua',os.epoch()),'w')
        h.write(x)
        h.close()
    end
end
os.pullEvent=oldpull
