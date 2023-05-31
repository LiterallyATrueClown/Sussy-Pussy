repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer
for i,v in pairs(game.Workspace:GetChildren()) do
	if v.Name == "Script" then
		v:Destroy()
	end
end
local function tableremove(arr, value) for i = #arr, 1, -1 do if arr[i] == value then table.remove(arr, i)end end end
local LightingSaves = Instance.new("Folder", game:GetService("RobloxReplicatedStorage"))

local themes = {
    Background = Color3.fromRGB(24, 24, 24), 
    Glow = Color3.fromRGB(0, 255, 255), 
    Accent = Color3.fromRGB(0, 0, 0), 
    LightContrast = Color3.fromRGB(30, 30, 30), 
    DarkContrast = Color3.fromRGB(0, 0, 0),  
    TextColor = Color3.fromRGB(0, 255, 255)
}

local lightpro = {
    Ambient = Color3.fromRGB(170, 170, 170),
    Brightness = 2,
    ColorShift_Bottom = Color3.new(0, 0, 0),
    ColorShift_Top = Color3.new(0, 0, 0),
    EnvironmentDiffuseScale = 0.3,
    OutdoorAmbient = Color3.fromRGB(128, 128, 128),
    ShadowSoftness = 0.2,
    GeographicLatitude = 66,
    FogColor = Color3.fromRGB(147, 185, 255)
}

for i,v in pairs(game:GetService("Lighting"):GetChildren()) do
    if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("Folder") or v:IsA("Atmosphere") or v:IsA("Sky") then
        v:Clone().Parent = LightingSaves
    end
end

local library = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/LiterallyATrueClown/ClownThingies/main/CheeseHubVenyxGuiLib.lua", true))()
local chezhub = library.new("Cheese Hub - Blox Fruit - Version 1.0", 5013109572)

--[[

Cheese Hub Blox Fruit Features:
    + Fake màu chiêu thức, vũ khí
    + Fake hiệu ứng chiêu thức, vũ khí
    + Fake trái ác quỷ
    + Fake hiệu ứng tộc v4 100%
    + RTX cực đẹp cực mượt
    + Aimbot
    + ESP
    + Dịch chuyển khắp nơi
    + Mở khoá portal rip_indra
    + Show items
    + Track stat ram
    + Low cpu
    + Không hồi chiêu Soru
    + Không hồi chiêu Geppo
    + Không hồi chiêu lướt
    + Thuấn thân - Loạn (Soru/ Tốc biến trong Blox Fruit nhưng bấm nút là nó soru loạn hết cả lên trong 3 giấy rồi tự tắt, thời gian huỷ chiêu có thể điều chỉnh được)

]]

local clientside = chezhub:addPage("Client Stuffs", 5012544693)
local fakeskill = clientside:addSection("Faking Skill Color")
local uni = clientside:addSection("UwU")
local rtx = clientside:addSection("RTX")
local esp = clientside:addSection("ESP")
local skillcolor = Color3.fromRGB(255,0,0)
local espcolor = Color3.fromRGB(255,0,0)
local espstate = false

local aimbot = chezhub:addPage("Aimbot", 5012544693)
local aim = aimbot:addSection("Aimbot'ing")
local plrlist = {}
local nearestplr = nil
local chosenplr = nil
local nearestradius = math.huge
local aimstate = false
local aimingmethod = nil
local aimpos = nil

local mics = chezhub:addPage("Mics", 5012544693)
local buff = mics:addSection("Buff")
local antistun1, antistun2
local antimover1, antimover2
local agil
local ncdsoru, ncddash, ncdgeppo

local debug = chezhub:addPage("Debug", 5012544693)
local dbaim = debug:addSection("Debug Aimbot'ing")
local dbnrt = dbaim:addButton("")
local dbnrtmag = dbaim:addButton("")
local dbcho = dbaim:addButton("")
local dbchomag = dbaim:addButton("")

local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"
local _place = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false

buff:addButton("Anti Stunning", false, function(state)
    if state == true then
        antistun1 = game.Players.LocalPlayer.Character.Stun:GetPropertyChangedSignal("Value"):Connect(function()
            if game.Players.LocalPlayer.Character.Stun.Value == 1 then
                game.Players.LocalPlayer.Character.Stun.Value = 0
            end
        end)
        antistun2 = game.Players.LocalPlayer.Character.Busy:GetPropertyChangedSignal("Value"):Connect(function()
            if game.Players.LocalPlayer.Character.Busy.Value == true then
                game.Players.LocalPlayer.Character.Busy.Value = false
            end
        end)
    else
        if antistun1 ~= nil and antistun2 ~= nil then
            antistun1:Disconnect()
            antistun2:Disconnect()
            antistun1 = nil
            antistun2 = nil
        end
    end
end)

buff:addButton("Preventing Body Movers", function()
        game.Players.LocalPlayer.Character.PrimaryPart.Anchored = false
        antimover1 = game.Players.LocalPlayer.Character.PrimaryPart:GetPropertyChangedSignal("Anchored"):Connect(function()
            if game.Players.LocalPlayer.Character.PrimaryPart.Anchored == true then
                game.Players.LocalPlayer.Character.PrimaryPart.Anchored = false
            end
        end)
        antimover2 = game.Players.LocalPlayer.Character.PrimaryPart.ChildAdded:Connect(function(child)
            wait()
            if child:IsA("BodyPosition") or child:IsA("BodyVelocity") then
                child:Destroy()
            end
        end)
end)

buff:addToggle("Mink V3 Agility", false, function(state)
    if state == true then
        agil = Instance.new("Part", game.Players.LocalPlayer.Character.PrimaryPart)
        agil.Name = "Agility"
    else
        if agil then
            agil:Destroy()
            agil = nil
        end
    end
end)

buff:addSlider("Set Jump Power", game.Players.LocalPlayer.Character.Humanoid.JumpPower, 10, 300, function(val)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = val
end)

buff:addButton("No cooldown soru", function()
        for i, v in pairs(getgc()) do 
            if type(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character:WaitForChild("Soru") then 
                for i2,v2 in pairs(getupvalues(v)) do
                    spawn(function()
                        if type(v2) == 'table' then 
                            ncdsoru = game:GetService("RunService").RenderStepped:Connect(function() 
                                if v2.LastUse then 
                                    setupvalue(v, i2, {LastAfter = 0,LastUse = 0}) 
                                end
                            end)
                        end
                    end)
                end
            end
        end
end)

buff:addButton("No cooldown dash", function()
        for i = 1,2,1 do
            for i, v in pairs(getgc()) do 
                if type(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character:WaitForChild("Dodge") then 
                    for i2,v2 in next, getupvalues(v) do
                        spawn(function()
                            ncddash = game:GetService("RunService").RenderStepped:Connect(function() 
                                if tostring(v2) == "0.4" then
                                    setupvalue(v,i2,0/0)
                                end
                            end)
                        end)
                        end
                    end
                end
            end
end)

buff:addButton("No cooldown geppo", function()
        for i = 1,2,1 do
            for i, v in pairs(getgc()) do 
                if type(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character:WaitForChild("Skyjump") then 
                    for i2,v2 in next, getupvalues(v) do
                        spawn(function()
                            ncdgeppo = game:GetService("RunService").RenderStepped:Connect(function() 
                                if tostring(v2) == "0" then
                                    setupvalue(v,i2,0/0)
                                end
                            end)
                        end)
                        end
                    end
                end
            end
end)

function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. _place .. '/servers/Public?sortOrder=Asc&limit='..tostring(lim)))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. _place .. '/servers/Public?sortOrder=Asc&limit='..tostring(lim)..'&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                pcall(function()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(_place, ID, game.Players.LocalPlayer)
                end)
            end
        end
    end
end

function Teleport(lim)
    while wait(0.5) do
        pcall(function()
            TPReturner(lim)
            if foundAnything ~= "" then
                TPReturner(lim)
            end
        end)
    end
end

uni:addButton("Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)

uni:addButton("Hop Server (Normal Hopping)", function()
    repeat wait() until game:IsLoaded()
    Teleport(500)
end)

uni:addButton("Hop Server (Low Player)", function()
    repeat wait() until game:IsLoaded()
    Teleport(50)
end)

for i,v in pairs(game.Workspace.Characters:GetChildren()) do
    if v and v ~= game.Players.LocalPlayer.Character then
        table.insert(plrlist, v.Name)
    end
end

local targ = aim:addDropdown("Choose Target", plrlist, function(plr)
    chosenplr = plr
end)

aim:addDropdown("Choose Aim'ing Method", {"Chosen Player", "Nearest Player"}, function(method)
    aimingmethod = method
end)

local nrt = aim:addButton("")

aim:addButton("Refresh Target List", function()
    plrlist = {}
    for i,v in pairs(game.Workspace.Characters:GetChildren()) do
        if v and v ~= game.Players.LocalPlayer.Character then
            table.insert(plrlist, v.Name)
        end
    end
    aim:updateDropdown(targ, "Choose Target", plrlist, function(plr)
        chosenplr = plr
    end)
end)

aim:addKeybind("Toggle Aimbot", nil, function()
    if aimstate == true then
        if aimingmethod == nil then
            chezhub:Notify("Cheese Hub", "Bạn chưa chọn phương pháp aimbot")
        elseif chosenplr == nil and aimingmethod ~= "Nearest Player" then
            chezhub:Notify("Cheese Hub", "Bạn chưa chọn mục tiêu")
        elseif nearestplr == nil then
            if #game.Players:GetChildren() == 0 and #game.Workspace.Characters:GetChildren() == 1 then
                chezhub:Notify("Cheese Hub", "Ơ bạn ơi, trong server có ai đâu mà aimbot :<")
            elseif #game.Players:GetChildren() > 0 and #game.Workspace.Characters:GetChildren() == 1 then
                chezhub:Notify("Cheese Hub", "Trong server có "..tostring(#game.Players:GetChildren()).." người chơi\nnhưng vẫn chưa thấy nhân vật của họ xuất hiện :<")
            end
        else
            aimstate = false
            chezhub:Notify("Cheese Hub", "Aimbot disabled")
        end
    elseif aimstate == false then
        aimstate = true
        chezhub:Notify("Cheese Hub", "Aimbot enabled")
    end
end)

local lol = game:GetService("RunService").RenderStepped:Connect(function()
    if nearestplr ~= nil and game.Workspace.Characters:FindFirstChild(nearestplr) then
        local pos = game.Workspace.Characters:FindFirstChild(nearestplr):WaitForChild("HumanoidRootPart").Position
        dbaim:updateButton(dbnrt, "Nearest Player Position: "..tostring(math.floor(pos.X)).." "..tostring(math.floor(pos.Y)).." "..tostring(math.floor(pos.Z)))
        dbaim:updateButton(dbnrtmag, "Nearest Player Meters From Local Player: "..tostring(math.floor((game.Players.LocalPlayer.Character.PrimaryPart.Position - game.Workspace.Characters:FindFirstChild(nearestplr).PrimaryPart.Position).Magnitude * 0.2)).." m")
    else
        dbaim:updateButton(dbnrt, "Nearest Player Position: Not Found :<")
        dbaim:updateButton(dbnrtmag, "Nearest Player Meters From Local Player: Not Found :<")
        nearestplr = nil
    end
    if chosenplr ~= nil and game.Workspace.Characters:FindFirstChild(chosenplr) then
        local pos = game.Workspace.Characters:FindFirstChild(chosenplr):WaitForChild("HumanoidRootPart").Position
        dbaim:updateButton(dbcho, "Chosen Player Position: "..tostring(math.floor(pos.X)).." "..tostring(math.floor(pos.Y)).." "..tostring(math.floor(pos.Z)))
        dbaim:updateButton(dbchomag, "Chosen Player Meters From Local Player: "..tostring(math.floor((game.Players.LocalPlayer.Character.PrimaryPart.Position - game.Workspace.Characters:FindFirstChild(chosenplr).PrimaryPart.Position).Magnitude * 0.2)).." m")
    else
        dbaim:updateButton(dbcho, "Chosen Player Position: Not Found :<")
        dbaim:updateButton(dbchomag, "Chosen Player Meters From Local Player: Not Found :<")
        chosenplr = nil
    end
end)

local lol1 = game:GetService("RunService").RenderStepped:Connect(function()
    for i, v in pairs(game.Workspace.Characters:GetChildren()) do
        spawn(function()
            if v:IsA("Model") and v ~= game.Players.LocalPlayer.Character then
                    if (v.PrimaryPart.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude < nearestradius then
                    nearestplr = v.Name
                    nearestradius = (v.PrimaryPart.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude
                end
            end
        end)
    end
    
    if nearestplr ~= nil then
        if not game.Workspace.Characters:FindFirstChild(nearestplr) then
            nearestplr = nil
            nearestradius = math.huge
        else
            aim:updateButton(nrt, "Nearest Player: "..nearestplr)
        end
    end

    if nearestplr == nil then
        if #game.Players:GetChildren() == 0 and #game.Workspace.Characters:GetChildren() == 1 then
            aim:updateButton(nrt, "Nearest Player: Không có ai trong server cả :<")
        elseif #game.Players:GetChildren() > 0 and #game.Workspace.Characters:GetChildren() == 1 then
            aim:updateButton(nrt, "Nearest Player: ".."Trong server có "..tostring(#game.Players:GetChildren()).." người chơi\nnhưng vẫn chưa thấy nhân vật của họ xuất hiện :<")
        end
    end

    if aimingmethod == "Chosen Player" and chosenplr ~= nil and game.Workspace.Characters:FindFirstChild(chosenplr) then
        aimpos = game.Workspace.Characters:FindFirstChild(chosenplr).PrimaryPart.Position
    elseif aimingmethod == "Nearest Player" and nearestplr ~= nil and game.Workspace.Characters:FindFirstChild(nearestplr) then
        aimpos = game.Workspace.Characters:FindFirstChild(nearestplr).PrimaryPart.Position
    end
end)

local gg = getrawmetatable(game)
local old = gg.__namecall
setreadonly(gg,false)
gg.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
    if aimstate == false or aimingmethod == nil then return old(...) end
        if tostring(method) == "FireServer" then
            if tostring(args[1]) == "RemoteEvent" then
                if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                    if aimstate == true then
                        if aimingmethod ~= nil then
                            args[2] = aimpos
                            return old(unpack(args))
                        end
                    end
                end
            end
        end
    return old(...)
end)

esp:addColorPicker("Choose ESP Color", Color3.fromRGB(255,0,0), function(color3)
    espcolor = color3
end)

local function drawESP(character)
    if not character then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP"
    highlight.Adornee = character
    highlight.OutlineColor = espcolor
    highlight.Parent = character
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "NameLabel"
    billboardGui.AlwaysOnTop = true
    billboardGui.Size = UDim2.new(0, 200, 0, 40)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Adornee = character
    billboardGui.Parent = character
    local textLabel = Instance.new("TextLabel")
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.TextSize = 10
    textLabel.TextColor3 = espcolor
    textLabel.TextStrokeColor3 = espcolor
    textLabel.Parent = billboardGui
    if character then
    	textLabel.Text = "Tên: "..character.Name.." | Khoảng cách: "..tostring(math.floor((game.Players.LocalPlayer.Character.PrimaryPart.Position - character.PrimaryPart.Position).Magnitude * 0.2)).."m"
    end
    spawn(function()
	    while character do wait(1)
	        if espstate == true then
	            textLabel.TextColor3 = espcolor
	            highlight.OutlineColor = espcolor
	            textLabel.TextStrokeColor3 = espcolor
	            textLabel.Text = "Tên: "..character.Name.." | Khoảng cách: "..tostring(math.floor((game.Players.LocalPlayer.Character.PrimaryPart.Position - character.PrimaryPart.Position).Magnitude * 0.2)).."m"
	        end
	    end
	end)
end

local function removeESP(character)
    if not character then return end
    if character:FindFirstChild("ESP") then
        character:FindFirstChild("ESP"):Destroy()
    end
    if character:FindFirstChild("NameLabel") then
        character:FindFirstChild("NameLabel"):Destroy()
    end
end

game.Workspace.Characters.ChildAdded:Connect(function(char)
	wait(1)
    if espstate == true and char ~= game.Players.LocalPlayer.Character then
        drawESP(char)
    end
end)

game.Workspace.Characters.ChildRemoved:Connect(function(char)
	wait(1)
	if char ~= game.Players.LocalPlayer.Character then
    	removeESP(char)
    end
end)

esp:addToggle("Toggle ESP", false, function(state)
    espstate = state
    if espstate == true then
        for _, v in pairs(game.Workspace.Characters:GetChildren()) do
            if v and v ~= game.Players.LocalPlayer.Character then
                drawESP(v)
            end
        end
    else
        for _, v in pairs(game.Workspace.Characters:GetChildren()) do
            if v and v ~= game.Players.LocalPlayer.Character then
                removeESP(v)
            end
        end
    end
end)

fakeskill:addColorPicker("Set Skill Color", Color3.fromRGB(255,0,0), function(color3)
    skillcolor = color3
end)

local childadd = {wrlorg = nil,character = nil,wrkspc = nil,player = nil}

fakeskill:addButton("Change Skill Color", function()
    local plr = game.Players.LocalPlayer
    local char = plr.character
    repeat wait() until skillcolor ~= nil
    for i,v in pairs(childadd) do
        if v ~= nil then
            v:Disconnect()
        end
    end
    for i,v in pairs(game.ReplicatedStorage:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Color = skillcolor
        elseif v:IsA("ParticleEmitter")  or v:IsA("Beam") or v:IsA("Trail") then
            v.Color = ColorSequence.new(skillcolor)
        end
    end
    for i,v in pairs(plr:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Color = skillcolor
        elseif v:IsA("ParticleEmitter")  or v:IsA("Beam") or v:IsA("Trail") then
            v.Color = ColorSequence.new(skillcolor)
        end
    end
    childadd.wrlorg = game:GetService("Workspace")._WorldOrigin.ChildAdded:Connect(function(v)
        if v:IsA("Model") or #v:GetDescendants() >= 1 then
            for a,b in pairs(v:GetDescendants()) do
                if b:IsA("BasePart") then
                    wait(0.01) b.Color = skillcolor
                elseif b:IsA("ParticleEmitter") or b:IsA("Beam") or b:IsA("Trail") then
                    wait(0.01) b.Color = ColorSequence.new(skillcolor)
                end
            end
        else
            if v:IsA("BasePart") then
                wait(0.01) v.Color = skillcolor
            elseif v:IsA("ParticleEmitter")  or v:IsA("Beam") or v:IsA("Trail") then
                wait(0.01) v.Color = ColorSequence.new(skillcolor)
            end
        end
    end)
    childadd.character = char.DescendantAdded:Connect(function(v)
        if v:IsA("BasePart") then
            wait(0.01) v.Color = skillcolor
        elseif v:IsA("ParticleEmitter")  or v:IsA("Beam") or v:IsA("Trail") then
            wait(0.01) v.Color = ColorSequence.new(skillcolor)
        end
    end)
    childadd.wrkspc = game.Workspace.DescendantAdded:Connect(function(v)
        if v:IsA("BasePart") then
            wait(0.01) v.Color = skillcolor
        elseif v:IsA("ParticleEmitter")  or v:IsA("Beam") or v:IsA("Trail") then
            wait(0.01) v.Color = ColorSequence.new(skillcolor)
        end
    end)
    childadd.player = plr.DescendantAdded:Connect(function(v)
        if v:IsA("BasePart") then
            wait(0.01) v.Color = skillcolor
        elseif v:IsA("ParticleEmitter")  or v:IsA("Beam") or v:IsA("Trail") then
            wait(0.01) v.Color = ColorSequence.new(skillcolor)
        end
    end)
end)

local function otx()
    light = game:GetService("Lighting")
    for i,v in pairs(light:GetChildren()) do if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("Folder") or v:IsA("Atmosphere") or v:IsA("Sky") then v:Destroy() end end
    Instance.new("Sky", light)
    Instance.new("ColorCorrectionEffect", light)
    Instance.new("BloomEffect", light)
    Instance.new("BlurEffect", light)
    light.Brightness = 2
    light.ColorShift_Bottom = Color3.fromRGB(0,0,0)
    light.ColorShift_Top = Color3.fromRGB(118,117,101)
    light.Ambient = Color3.fromRGB(112,112,112)
    light.GeographicLatitude = 45
    light.OutdoorAmbient = Color3.fromRGB(141,141,141)
    light.ShadowSoftness = 0.1
    light.Blur.Enabled = true
    light.Blur.Size = 0
    light.EnvironmentSpecularScale = 1
    light.EnvironmentDiffuseScale = 0.343
    light.ExposureCompensation = 0.34
    light.Bloom.Size = 17
    light.Bloom.Intensity = 2
    light.Bloom.Threshold = 1
    light.GlobalShadows = true
    light.ColorCorrection.Brightness = 0
    light.ColorCorrection.Contrast = 0.2
    light.ColorCorrection.Saturation = 1.5
    light.ColorCorrection.TintColor = Color3.fromRGB(255,252,224)
    ray = Instance.new("SunRaysEffect", light)
    ray.Intensity = 0.08
    ray.Spread = 0.05
    light.Sky.SunAngularSize = 4
    atmos = Instance.new("Atmosphere", light)
    atmos.Color = Color3.fromRGB(216,255,250)
    atmos.Decay = Color3.fromRGB(92,60,13)
    atmos.Glare = 0.68
    atmos.Haze = 0.36
    atmos.Density = 0.348
    atmos.Offset = 0.199
end

local uwu, uwu2

rtx:addToggle("Cheese Hub RTX", false, function(state)
    if state == true then
        otx()
        for i, v in pairs(game:GetDescendants()) do if v:IsA("BasePart") then v.Reflectance = 0.1 end end

        spawn(function()
            repeat wait() until game:GetService("Lighting"):FindFirstChild("WaterBlur"):Destroy()
            repeat wait() until game:GetService("Lighting"):FindFirstChild("WaterColorCorrection"):Destroy()
        end)

        uwu = game:GetService("Lighting").Changed:Connect(function()
            otx()
            wait(0.5)
        end)
    else
        uwu:Disconnect()
        game:GetService("Lighting"):ClearAllChildren()
        for i,v in pairs(lightpro) do game:GetService("Lighting")[i] = v end
        for i,v in pairs(LightingSaves:GetChildren()) do v:Clone().Parent = game:GetService("Lighting") end
    end
end)

uni:addButton("Destroy GUI", function()
    spawn(function()
        game.Players.LocalPlayer.PlayerGui.BubbleChat:FindFirstChild("Cheese Hub - Blox Fruit - Version 1.0"):Destroy()
    end)
    lol:Disconnect()
    lol1:Disconnect()
    uwu:Disconnect()
end)

chezhub:SelectPage(chezhub.pages[1], true)

-- bypasses 
if sethiddenproperty then
    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
end

if setfflag then
    setfflag("AbuseReportScreenshot", "False")
    setfflag("AbuseReportScreenshotPercentage", "0")
end

local theme = chezhub:addPage("Ui Changer", 5012544693)
local colors = theme:addSection("Color", 5012544693)
local section1 = theme:addSection("UI")

section1:addKeybind("Toggle Keybind",Enum.KeyCode.RightControl,function()
    chezhub:toggle()
end)

for theme, color in pairs(themes) do
    colors:addColorPicker(theme,color,function(color3)
        chezhub:setTheme(theme, color3)
    end)
end