local netMgr = require "component.net.NetMgr"
local myutils = require("common.utils")
local protoutils = require("component.proto.protoutils")
local debugger = {}

function gm(command)
	local commands = myutils.split(command," ")
	--myutils.print(commands)
	if commands[1] == "login" then
		local users = {
			[1] = "111",
			[2] = "123",
			[3] = "1234",
			[4] = "12345",
		}
		local name = users[tonumber(commands[2])]
		local msg = protoutils.packmsg("login",{id = name , password = name },2)
		netMgr.send(msg)
    elseif commands[1] == "connect" then
        netMgr.connect("123.207.19.86", 8888)		
	elseif commands[1] == "ready" then
		local msg = protoutils.packmsg("ready",nil,2)
		netMgr.send(msg)
	elseif commands[1] == "quickstart" then
		local msg = protoutils.packmsg("quickstart",nil,2)
		netMgr.send(msg)
	elseif commands[1] == "calllandholder" then
		local bCall = (commands[2] ~= nil)
		local msg = protoutils.packmsg("calllandholder",{call = bCall},7)
		netMgr.send(msg)
	elseif commands[1] == "followcard" then
		local bCall = (commands[2] ~= nil)
		local msg = protoutils.packmsg("followcard",{call = bCall},7)
		netMgr.send(msg)	
	end
end