_G.TimeBeforeNextChest = 0.5	   -- Thời gian nhảy sang cái rương khác
_G.ChestCollectedBeforeSuicide = 5 -- Số rương nhặt xong trước khi tự sát (tự sát để ko bị ăn kick)

local thopchest = 0.5 
local dem = 0
local chest = nil
local plr = game.Players.LocalPlayer
local curbeli = plr.Data.Beli.Value

for i,v in pairs(game.Workspace:GetChildren()) do
	if v.Name == "Script" then
		v:Destroy()
	end
end

for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
	if v:IsA("BasePart") then
		v.CanCollide = true
		v.CanTouch = true
		v.CanQuery = true
	end
end

spawn(function()
	while wait() do
		for i,v in pairs(game.Workspace:GetChildren()) do
		    if v.Name:match("Chest") and dem < _G.ChestCollectedBeforeSuicide then
		    	chest = v
		    	firetouchinterest(game.Players.LocalPlayer.Character.Head, v, 0)
	    		firetouchinterest(game.Players.LocalPlayer.Character.PrimaryPart, v, 0)
	    		firetouchinterest(game.Players.LocalPlayer.Character.UpperTorso, v, 0)
	    		firetouchinterest(game.Players.LocalPlayer.Character.LowerTorso, v, 0)
		    elseif dem == _G.ChestCollectedBeforeSuicide then
		    	game.Players.LocalPlayer.Character.Humanoid.Health = 0
		    	repeat wait() until game.Workspace.Characters:WaitForChild(game.Players.LocalPlayer.Name)
		    	repeat wait() until game.Workspace.Characters:WaitForChild(game.Players.LocalPlayer.Name)
				repeat wait() until game.Workspace.Characters:WaitForChild(game.Players.LocalPlayer.Name):WaitForChild("Humanoid")
				repeat wait() until game.Workspace.Characters:WaitForChild(game.Players.LocalPlayer.Name):WaitForChild("Humanoid").Health > 0
				wait(2.5)
		    	dem = 0
	    	end
	    	wait(_G.TimeBeforeNextChest)
		end
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if chest == nil or not chest then return end
	if chest ~= nil and dem < _G.ChestCollectedBeforeSuicide then
	    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(chest.CFrame)
	    firetouchinterest(game.Players.LocalPlayer.Character.Head, chest, 0)
	    firetouchinterest(game.Players.LocalPlayer.Character.PrimaryPart, chest, 0)
	    firetouchinterest(game.Players.LocalPlayer.Character.UpperTorso, chest, 0)
	    firetouchinterest(game.Players.LocalPlayer.Character.LowerTorso, chest, 0)
	    if curbeli < plr.Data.Beli.Value then
		    curbeli = plr.Data.Beli.Value
		    dem = dem + 1
		end
	end
end)