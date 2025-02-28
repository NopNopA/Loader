Nexus_Version = 104

local FileName, Success, Error, Function = 'ic3w0lf22.Nexus.lua'

if isfile and readfile and isfile(FileName) then -- Execute ASAP, update later.
	Function, Error = loadstring(readfile(FileName), 'Nexus')

	if Function then
		Function()

		if Nexus then Nexus:Connect() end
	end
end

for i=1, 10 do
	Success, Error = pcall(function()
		local Response = (http_request or (syn and syn.request)) { Method = 'GET', Url = 'https://raw.githubusercontent.com/ic3w0lf22/Roblox-Account-Manager/master/RBX%20Alt%20Manager/Nexus/Nexus.lua' }

		if not Response.Success then error(('HTTP Error %s'):format(Response.StatusCode)) end

		Function, Error = loadstring(Response.Body, 'Nexus')

		if not Function then error(Error) end

		if isfile and not isfile(FileName) then
			writefile(FileName, Response.Body)
		end
		
		if not Nexus then -- Nexus was already ran earlier, this will update the existing file to the latest version instead of re-creating Nexus
			Function()
			Nexus:Connect()
		end
	end)
	
	if Success then break else task.wait(1) end
end

if not Success and Error then
	(messagebox or print)(('Nexus encountered an error while launching!\n\n%s'):format(Error), 'Roblox Account Manager', 0)
end
