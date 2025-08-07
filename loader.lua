-- ⚔️ LegionX Key System with GUI by ChatGPT
local KEY = "reb_LX" -- Your correct key
local LOADSTRING_URL = "https://raw.githubusercontent.com/Legendbattlehero/legionX-fisch-real-roblox/refs/heads/main/LegionXBOAT.lua"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local plr = Players.LocalPlayer

-- GUI Setup
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "LegionXKeyUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 420, 0, 270)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "🔐 LegionX Key System"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 60, 60)
title.TextSize = 24

-- Input
local textbox = Instance.new("TextBox", frame)
textbox.PlaceholderText = "Enter Key (e.g. reb_LX)"
textbox.Size = UDim2.new(0.8, 0, 0, 40)
textbox.Position = UDim2.new(0.1, 0, 0, 60)
textbox.Text = ""
textbox.ClearTextOnFocus = false
textbox.TextColor3 = Color3.new(1,1,1)
textbox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
textbox.Font = Enum.Font.Gotham
textbox.TextSize = 18
Instance.new("UICorner", textbox).CornerRadius = UDim.new(0, 8)

-- Submit Button
local submit = Instance.new("TextButton", frame)
submit.Size = UDim2.new(0.5, 0, 0, 40)
submit.Position = UDim2.new(0.25, 0, 0, 115)
submit.Text = "Submit"
submit.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
submit.Font = Enum.Font.GothamBold
submit.TextColor3 = Color3.new(1,1,1)
submit.TextSize = 20
Instance.new("UICorner", submit).CornerRadius = UDim.new(0, 8)

-- Status Text
local statusText = Instance.new("TextLabel", frame)
statusText.Size = UDim2.new(1, 0, 0, 30)
statusText.Position = UDim2.new(0, 0, 0, 165)
statusText.BackgroundTransparency = 1
statusText.Text = ""
statusText.Font = Enum.Font.Gotham
statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
statusText.TextSize = 18

-- Get Key Button
local getKey = Instance.new("TextButton", frame)
getKey.Size = UDim2.new(0.45, 0, 0, 35)
getKey.Position = UDim2.new(0.05, 0, 1, -45)
getKey.Text = "🔑 Get Key"
getKey.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
getKey.Font = Enum.Font.Gotham
getKey.TextColor3 = Color3.new(1,1,1)
getKey.TextSize = 16
Instance.new("UICorner", getKey).CornerRadius = UDim.new(0, 6)

-- Close Button
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0.45, 0, 0, 35)
close.Position = UDim2.new(0.5, 0, 1, -45)
close.Text = "❌ Close"
close.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
close.Font = Enum.Font.Gotham
close.TextColor3 = Color3.new(1,1,1)
close.TextSize = 16
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)

-- Logic
local function showStatus(text, color)
	statusText.Text = text
	statusText.TextColor3 = color
end

submit.MouseButton1Click:Connect(function()
	local input = textbox.Text
	if input == "" then
		showStatus("❗ Please enter the key.", Color3.fromRGB(255, 120, 120))
		return
	end

	showStatus("🔄 Checking key...", Color3.fromRGB(255, 255, 120))
	wait(1.5)

	if input == KEY then
		showStatus("✅ Key accepted! Loading...", Color3.fromRGB(120, 255, 120))
		wait(1.2)

		pcall(function()
			loadstring(game:HttpGet(LOADSTRING_URL))()
		end)

		gui:Destroy()
	else
		showStatus("❌ Wrong key. Try again.", Color3.fromRGB(255, 80, 80))
	end
end)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

getKey.MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/legionx") -- Customize this link
	showStatus("📋 Key link copied!", Color3.fromRGB(150, 200, 255))
end)
