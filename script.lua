-- // Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- // ScreenGui Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BlueModsUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame (ScrollingFrame)
local mainFrame = Instance.new("ScrollingFrame")
mainFrame.Size = UDim2.new(0, 300, 0, 260)
mainFrame.AnchorPoint = Vector2.new(0.5, 0)
mainFrame.Position = UDim2.new(0.5, 0, 0, 50) -- Center top
mainFrame.CanvasSize = UDim2.new(0, 0, 0, 450) -- enough scroll space
mainFrame.ScrollBarThickness = 6
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.4
mainFrame.Visible = true
mainFrame.Parent = screenGui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 0, 30)
title.Position = UDim2.new(0, 40, 0, 0) -- beside logo
title.Text = "BlueMods"
title.TextColor3 = Color3.fromRGB(0, 170, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextScaled = true
title.BackgroundTransparency = 1
title.Parent = mainFrame

-- Logo
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 30, 0, 30)
logo.Position = UDim2.new(0, 5, 0, 0)
logo.BackgroundTransparency = 1
logo.Image = "https://bluemods.neocities.org/p/ic_blue.png"
logo.Parent = mainFrame

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 60, 0, 30)
closeBtn.Position = UDim2.new(1, -65, 0, 5)
closeBtn.Text = "Close"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Parent = mainFrame

-- Reopen Button
local reopenBtn = Instance.new("TextButton")
reopenBtn.Size = UDim2.new(0, 120, 0, 30)
reopenBtn.Position = UDim2.new(0, 10, 0, 10)
reopenBtn.Text = "Open BlueMods"
reopenBtn.TextColor3 = Color3.new(1, 1, 1)
reopenBtn.Visible = false
reopenBtn.Parent = screenGui

-- Variables
local infiniteJump = false
local jumpBoostOn = false
local jumpBoostValue = 50
local speedBoostOn = false
local speedBoostValue = 30
local invisible = false

-- Infinite Jump Toggle
local infJumpBtn = Instance.new("TextButton")
infJumpBtn.Size = UDim2.new(1, -20, 0, 30)
infJumpBtn.Position = UDim2.new(0, 10, 0, 40)
infJumpBtn.Text = "Infinite Jump: OFF"
infJumpBtn.TextColor3 = Color3.new(1, 1, 1)
infJumpBtn.Parent = mainFrame

-- Jump Boost Toggle
local jumpBoostBtn = Instance.new("TextButton")
jumpBoostBtn.Size = UDim2.new(1, -20, 0, 30)
jumpBoostBtn.Position = UDim2.new(0, 10, 0, 80)
jumpBoostBtn.Text = "Jump Boost: OFF"
jumpBoostBtn.TextColor3 = Color3.new(1, 1, 1)
jumpBoostBtn.Parent = mainFrame

-- Jump Boost Slider
local jumpSlider = Instance.new("TextButton")
jumpSlider.Size = UDim2.new(1, -20, 0, 20)
jumpSlider.Position = UDim2.new(0, 10, 0, 115)
jumpSlider.Text = "JumpPower: 50"
jumpSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
jumpSlider.TextColor3 = Color3.new(1, 1, 1)
jumpSlider.Parent = mainFrame

-- Speed Boost Toggle
local speedBoostBtn = Instance.new("TextButton")
speedBoostBtn.Size = UDim2.new(1, -20, 0, 30)
speedBoostBtn.Position = UDim2.new(0, 10, 0, 150)
speedBoostBtn.Text = "Speed Boost: OFF"
speedBoostBtn.TextColor3 = Color3.new(1, 1, 1)
speedBoostBtn.Parent = mainFrame

-- Speed Boost Slider
local speedSlider = Instance.new("TextButton")
speedSlider.Size = UDim2.new(1, -20, 0, 20)
speedSlider.Position = UDim2.new(0, 10, 0, 185)
speedSlider.Text = "WalkSpeed: 30"
speedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedSlider.TextColor3 = Color3.new(1, 1, 1)
speedSlider.Parent = mainFrame

-- Invisible Toggle
local invisBtn = Instance.new("TextButton")
invisBtn.Size = UDim2.new(1, -20, 0, 30)
invisBtn.Position = UDim2.new(0, 10, 0, 220)
invisBtn.Text = "Invisible: OFF"
invisBtn.TextColor3 = Color3.new(1, 1, 1)
invisBtn.Parent = mainFrame

-- Logic
UIS.JumpRequest:Connect(function()
	if infiniteJump then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

infJumpBtn.MouseButton1Click:Connect(function()
	infiniteJump = not infiniteJump
	infJumpBtn.Text = "Infinite Jump: " .. (infiniteJump and "ON" or "OFF")
end)

jumpBoostBtn.MouseButton1Click:Connect(function()
	jumpBoostOn = not jumpBoostOn
	if jumpBoostOn then
		humanoid.UseJumpPower = true
		humanoid.JumpPower = jumpBoostValue
	else
		humanoid.JumpPower = 50
	end
	jumpBoostBtn.Text = "Jump Boost: " .. (jumpBoostOn and "ON" or "OFF")
end)

jumpSlider.MouseButton1Click:Connect(function()
	jumpBoostValue = jumpBoostValue + 10
	if jumpBoostValue > 150 then jumpBoostValue = 20 end
	jumpSlider.Text = "JumpPower: " .. jumpBoostValue
	if jumpBoostOn then
		humanoid.JumpPower = jumpBoostValue
	end
end)

speedBoostBtn.MouseButton1Click:Connect(function()
	speedBoostOn = not speedBoostOn
	if speedBoostOn then
		humanoid.WalkSpeed = speedBoostValue
	else
		humanoid.WalkSpeed = 16
	end
	speedBoostBtn.Text = "Speed Boost: " .. (speedBoostOn and "ON" or "OFF")
end)

speedSlider.MouseButton1Click:Connect(function()
	speedBoostValue = speedBoostValue + 5
	if speedBoostValue > 100 then speedBoostValue = 16 end
	speedSlider.Text = "WalkSpeed: " .. speedBoostValue
	if speedBoostOn then
		humanoid.WalkSpeed = speedBoostValue
	end
end)

invisBtn.MouseButton1Click:Connect(function()
	invisible = not invisible
	if invisible then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
				part.Transparency = 1
			end
		end
	else
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
				part.Transparency = 0
			end
		end
	end
	invisBtn.Text = "Invisible: " .. (invisible and "ON" or "OFF")
end)

-- Close / Reopen
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	reopenBtn.Visible = true
end)

reopenBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	reopenBtn.Visible = false
end)
