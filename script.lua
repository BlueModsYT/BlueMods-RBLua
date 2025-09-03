-- // BlueMods Roblox GUI // --
-- Put this in LocalScript (StarterGui)

-- Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 300)
MainFrame.Position = UDim2.new(0.5, -150, 0, 50) -- Center top
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.4
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BackgroundTransparency = 0.3
TitleBar.Parent = MainFrame

-- Logo
local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0, 30, 0, 30)
Logo.Position = UDim2.new(0, 5, 0, 5)
Logo.BackgroundTransparency = 1
Logo.Image = "https://bluemods.neocities.org/p/ic_blue.png"
Logo.Parent = TitleBar

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 40, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "BlueMods"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.TextSize = 24
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 60, 1, 0)
CloseBtn.Position = UDim2.new(1, -60, 0, 0)
CloseBtn.Text = "Close"
CloseBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.Parent = TitleBar

-- Reopen Button (hidden at first)
local ReopenBtn = Instance.new("TextButton")
ReopenBtn.Size = UDim2.new(0, 120, 0, 40)
ReopenBtn.Position = UDim2.new(0.5, -60, 0, 50)
ReopenBtn.Text = "Open BlueMods"
ReopenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ReopenBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ReopenBtn.BackgroundTransparency = 0.4
ReopenBtn.Visible = false
ReopenBtn.Parent = ScreenGui

-- Scrollable container
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -50)
ScrollFrame.Position = UDim2.new(0, 10, 0, 45)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
ScrollFrame.ScrollBarThickness = 8
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.Parent = MainFrame

-- UIListLayout for buttons
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ScrollFrame

-- Utility: Create button
local function CreateButton(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Text = name
    btn.Parent = ScrollFrame
    return btn
end

-- Utility: Create slider
local function CreateSlider(name, min, max, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 50)
    frame.BackgroundTransparency = 1
    frame.Parent = ScrollFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.5, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 18
    label.Text = name .. ": " .. tostring(default)
    label.Parent = frame

    local slider = Instance.new("TextButton")
    slider.Size = UDim2.new(1, 0, 0.5, 0)
    slider.Position = UDim2.new(0, 0, 0.5, 0)
    slider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    slider.Text = ""
    slider.Parent = frame

    local amount = default
    local dragging = false

    slider.MouseButton1Down:Connect(function()
        dragging = true
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
            amount = math.floor(min + (max - min) * rel)
            label.Text = name .. ": " .. tostring(amount)
        end
    end)

    return function() return amount end, label
end

-- Features
local infJump = false
local jumpBoost = false
local speedBoost = false
local invisible = false

-- Buttons & sliders
local InfJumpBtn = CreateButton("Infinite Jump: OFF")
local JumpBoostBtn = CreateButton("Jump Boost: OFF")
local GetJumpAmount, JumpLabel = CreateSlider("JumpPower", 50, 200, 120)

local SpeedBoostBtn = CreateButton("Speed Boost: OFF")
local GetSpeedAmount, SpeedLabel = CreateSlider("WalkSpeed", 16, 100, 50)

local InvisBtn = CreateButton("Invisible: OFF")

-- Infinite Jump loop
UIS.JumpRequest:Connect(function()
    if infJump and humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Toggles
InfJumpBtn.MouseButton1Click:Connect(function()
    infJump = not infJump
    InfJumpBtn.Text = "Infinite Jump: " .. (infJump and "ON" or "OFF")
end)

JumpBoostBtn.MouseButton1Click:Connect(function()
    jumpBoost = not jumpBoost
    JumpBoostBtn.Text = "Jump Boost: " .. (jumpBoost and "ON" or "OFF")
    if not jumpBoost then
        humanoid.UseJumpPower = true
        humanoid.JumpPower = 50
    end
end)

SpeedBoostBtn.MouseButton1Click:Connect(function()
    speedBoost = not speedBoost
    SpeedBoostBtn.Text = "Speed Boost: " .. (speedBoost and "ON" or "OFF")
    if not speedBoost then
        humanoid.WalkSpeed = 16
    end
end)

InvisBtn.MouseButton1Click:Connect(function()
    invisible = not invisible
    InvisBtn.Text = "Invisible: " .. (invisible and "ON" or "OFF")
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = invisible and 1 or 0
        end
    end
end)

-- Loops for boosts
game:GetService("RunService").RenderStepped:Connect(function()
    if jumpBoost then
        humanoid.UseJumpPower = true
        humanoid.JumpPower = GetJumpAmount()
    end
    if speedBoost then
        humanoid.WalkSpeed = GetSpeedAmount()
    end
end)

-- Close / Reopen logic
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ReopenBtn.Visible = true
end)
ReopenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ReopenBtn.Visible = false
end)
