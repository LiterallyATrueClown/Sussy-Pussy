_G.FastAttack = true
_G.AutoClick = true

require(game.ReplicatedStorage.Util.CameraShaker):Stop()
local CMBTFramework = getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))[2] -- module combat láy tầng thứ 2
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function() -- dùng render stepped nên đùng dùng kèm script hạn chế fps không là nó chạy nhanh như seahub đấy
			pcall(function()
				if _G.FastAttack == true then
					CMBTFramework.activeController.hitboxMagnitude = 150 -- tầm đánh hit box
					CMBTFramework.activeController.timeToNextAttack = -math.huge
					CMBTFramework.activeController.attacking = false
					CMBTFramework.activeController.increment = 4
					CMBTFramework.activeController.blocking = false
					CMBTFramework.activeController.focusStart = 0	
					CMBTFramework.activeController.currentAttackTrack = 0
					CMBTFramework.activeController.timeToNextBlock = 0
					game.Players.LocalPlayer.Character.Humanoid.Sit = false	 -- bỏ đòn 1 lấy đòn 2
				end
				if _G.AutoClick == true then
					game:GetService'VirtualUser':CaptureController()
    				game:GetService'VirtualUser':Button1Down(Vector2.new(0,1,0,1))
    			end
			end)
		end)
	end)