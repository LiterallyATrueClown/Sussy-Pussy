spawn(function()
game.Players.LocalPlayer.PlayerGui.BubbleChat.Right:Destroy()
end)
wait()
local cac = require(game:GetService("Players").LocalPlayer.PlayerGui.Main.UIController.Inventory)
local Inventory = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")
local Items = {}
local RaityLevel = {"Mythical","Legendary","Rare","Uncommon","Common"}
local RaityColor =  {
    ["Common"] = Color3.fromRGB(179, 179, 179),
    ["Uncommon"] = Color3.fromRGB(92, 140, 211),
    ["Rare"] =  Color3.fromRGB(140, 82, 255),
    ["Legendary"] = Color3.fromRGB(213, 43, 228) ,
    ["Mythical"] =  Color3.fromRGB(238, 47, 50)
}
function GetRaity(color)
    for k,v in pairs(RaityColor) do 
        if v==color then return k end
    end
end

for k,v in pairs(Inventory) do 
    Items[v.Name] = v
end

function GetXY(vec) 
    return vec*100
end

local tvk = Instance.new("UIListLayout")
tvk.FillDirection = Enum.FillDirection.Vertical
tvk.SortOrder = 2
tvk.Padding = UDim.new(0,0)

local Right = Instance.new("Frame",game.Players.LocalPlayer.PlayerGui.BubbleChat)
Right.BackgroundTransparency = 1
Right.Size = UDim2.new(0.5,0,1,0) 
Right.Position = UDim2.new(.55,0,0,0)
Right.Name = "Right"
tvk:Clone().Parent = Right
local bucac

local MeleeG = Instance.new("Frame",Right)
MeleeG.BackgroundTransparency = 1
MeleeG.Size = UDim2.new(1,0,3,0) 
MeleeG.LayoutOrder = table.find(RaityLevel,k)
MeleeG.AutomaticSize = 2
MeleeG.LayoutOrder = 100
local tvk = Instance.new("UIGridLayout",MeleeG)
tvk.CellPadding = UDim2.new(0.01,0,0,0)
tvk.CellSize =  UDim2.new(0,175,0,175)
tvk.FillDirectionMaxCells = 500
tvk.FillDirection = Enum.FillDirection.Horizontal
local ListHuhu = {
    ["Superhuman"] = Vector2.new(3,2),
    ["DeathStep"] = Vector2.new(4,3),
    ["ElectricClaw"] = Vector2.new(2,0),
    ["SharkmanKarate"] = Vector2.new(0,0),
    ["DragonTalon"] = Vector2.new(1,5),
    ["Godhuman"] = "rbxassetid://10338473987"
}
local listarg = {
	"Superhuman",
	"Death Step",
	"Electric Claw",
	"Sharkman Karate",
	"Dragon Talon",
	"Godhuman",
}

local nguu = {}

function EquipWeapon()
	for i,v in pairs (listarg) do
		local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(v)
		if tool then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
		end
	end
end
local plr = game:GetService("Players").LocalPlayer
for i,v in pairs(ListHuhu) do
    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buy"..i) == 1 then
	EquipWeapon()
	local clone = plr.PlayerGui.Main.Skills:Clone()
	for g,h in pairs(clone:GetChildren()) do
		if h.Name == "Title" or h.Name == "Level" then
		else h:Destroy()
		end
	end
	clone.Parent = MeleeG
	clone.BackgroundTransparency = 1
    end
end