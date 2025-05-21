-- Universal Script Hub by ChatGPT (Blue Theme, Advanced UI)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "UniversalHubUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Particle-Like Background (Fake using frames)
for i = 1, 30 do
	local particle = Instance.new("Frame")
	particle.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
	particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
	particle.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
	particle.BackgroundTransparency = 0.4
	particle.BorderSizePixel = 0
	particle.Parent = ScreenGui

	-- Animate particle movement
	local goal = {Position = UDim2.new(math.random(), 0, math.random(), 0)}
	TweenService:Create(particle, TweenInfo.new(8 + math.random(), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), goal):Play()
end

-- Main Frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Header
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(30, 60, 90)
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Header)
Title.Text = "🌌 Universal Script Hub"
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(230, 240, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Exit + Minimize
local function createTopButton(text, xOffset)
	local btn = Instance.new("TextButton", Header)
	btn.Text = text
	btn.Size = UDim2.new(0, 30, 0, 30)
	btn.Position = UDim2.new(1, -xOffset, 0.5, -15)
	btn.BackgroundColor3 = Color3.fromRGB(50, 90, 130)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	return btn
end

local closeBtn = createTopButton("X", 40)
local minBtn = createTopButton("-", 80)

closeBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

minBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

-- Footer
local Footer = Instance.new("Frame", MainFrame)
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.BackgroundColor3 = Color3.fromRGB(20, 40, 60)
Footer.BorderSizePixel = 0
Instance.new("UICorner", Footer).CornerRadius = UDim.new(0, 6)

local FooterText = Instance.new("TextLabel", Footer)
FooterText.Text = "Made with ❤️ by ChatGPT"
FooterText.Size = UDim2.new(1, 0, 1, 0)
FooterText.BackgroundTransparency = 1
FooterText.TextColor3 = Color3.fromRGB(200, 220, 255)
FooterText.TextSize = 12
FooterText.Font = Enum.Font.Gotham
FooterText.TextTransparency = 0.2

-- Panel Buttons
local PanelHolder = Instance.new("Frame", MainFrame)
PanelHolder.Position = UDim2.new(0, 0, 0, 40)
PanelHolder.Size = UDim2.new(0, 120, 1, -70)
PanelHolder.BackgroundColor3 = Color3.fromRGB(25, 45, 65)
PanelHolder.BorderSizePixel = 0

Instance.new("UICorner", PanelHolder).CornerRadius = UDim.new(0, 6)

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Position = UDim2.new(0, 125, 0, 45)
ContentFrame.Size = UDim2.new(1, -130, 1, -90)
ContentFrame.BackgroundColor3 = Color3.fromRGB(20, 35, 50)
ContentFrame.BorderSizePixel = 0
Instance.new("UICorner", ContentFrame).CornerRadius = UDim.new(0, 6)

-- Tab System
local Panels = {}

local function createTab(name, callback)
	local button = Instance.new("TextButton", PanelHolder)
	button.Size = UDim2.new(1, -10, 0, 35)
	button.Position = UDim2.new(0, 5, 0, 5 + (#PanelHolder:GetChildren() - 1) * 40)
	button.Text = name
	button.TextColor3 = Color3.fromRGB(220, 230, 255)
	button.Font = Enum.Font.Gotham
	button.TextSize = 14
	button.BackgroundColor3 = Color3.fromRGB(35, 60, 85)
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 4)

	local panel = Instance.new("Frame", ContentFrame)
	panel.Size = UDim2.new(1, 0, 1, 0)
	panel.BackgroundTransparency = 1
	panel.Visible = false

	Panels[name] = panel

	button.MouseButton1Click:Connect(function()
		for _, p in pairs(ContentFrame:GetChildren()) do
			if p:IsA("Frame") then p.Visible = false end
		end
		panel.Visible = true
	end)

	callback(panel)
end

-- 🧩 Add Feature Tabs
createTab("ESP", function(frame)
	local label = Instance.new("TextLabel", frame)
	label.Text = "ESP Loaded"
	label.Size = UDim2.new(1, 0, 0, 30)
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
end)

createTab("Movement", function(frame)
	local wsBtn = Instance.new("TextButton", frame)
	wsBtn.Text = "Increase WalkSpeed"
	wsBtn.Size = UDim2.new(0, 160, 0, 40)
	wsBtn.Position = UDim2.new(0, 10, 0, 10)
	wsBtn.BackgroundColor3 = Color3.fromRGB(40, 80, 120)
	wsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	wsBtn.Font = Enum.Font.GothamBold
	wsBtn.TextSize = 14
	Instance.new("UICorner", wsBtn).CornerRadius = UDim.new(0, 6)

	wsBtn.MouseButton1Click:Connect(function()
		local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
		if hum then hum.WalkSpeed = 32 end
	end)
end)

-- Set first tab as active
for _, v in pairs(Panels) do
	v.Visible = false
end
Panels["ESP"].Visible = true

-- Toggle with RightShift
UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.RightShift then
		MainFrame.Visible = not MainFrame.Visible
	end
end)

