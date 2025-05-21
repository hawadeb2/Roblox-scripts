--[[
    Credits to chatgpt
    Features: ESP, WalkSpeed, JumpPower, Teleport, Clean UI
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- UI Creation
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "UniversalHub"

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 320)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 0.05
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Active = true
MainFrame.Draggable = true

-- UICorner for rounded edges
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "🌐 Omega Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextStrokeTransparency = 0.85

-- Tab Buttons
local function createButton(text, posY, callback)
    local Button = Instance.new("TextButton")
    Button.Text = text
    Button.Size = UDim2.new(1, -40, 0, 40)
    Button.Position = UDim2.new(0, 20, 0, posY)
    Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 16
    Button.Parent = MainFrame

    local btnCorner = Instance.new("UICorner", Button)
    btnCorner.CornerRadius = UDim.new(0, 6)

    Button.MouseButton1Click:Connect(callback)
end

-- Features
createButton("Toggle ESP", 50, function()
    local function createESP(player)
        if player.Character and not player.Character:FindFirstChild("ESPBox") then
            local box = Instance.new("BoxHandleAdornment")
            box.Name = "ESPBox"
            box.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
            box.AlwaysOnTop = true
            box.ZIndex = 5
            box.Size = Vector3.new(4, 6, 1)
            box.Color3 = Color3.fromRGB(0, 255, 0)
            box.Transparency = 0.5
            box.Parent = player.Character
        end
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createESP(player)
        end
    end

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            wait(1)
            createESP(player)
        end)
    end)
end)

createButton("WalkSpeed x2", 100, function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 32
    end
end)

createButton("JumpPower x2", 150, function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 100
    end
end)

createButton("Teleport to Player", 200, function()
    local target = Players:GetPlayers()[2] -- Example: 2nd player
    if target and target.Character and LocalPlayer.Character then
        LocalPlayer.Character:MoveTo(target.Character:GetPivot().Position + Vector3.new(2, 0, 0))
    end
end)

-- Toggle keybind: RightShift
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
