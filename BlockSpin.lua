local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Window = Rayfield:CreateWindow({
        Name = "Void Hub 🌀 | Blockspin 🔪",
        Icon = 0,
        LoadingTitle = "Void Hub | 🌀",
        LoadingSubtitle = "by VoideX",
        Theme = "Default",
 
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false,
 
        ConfigurationSaving = {
            Enabled = true,
            FolderName = VoidHub,
            FileName = "VoidHub"
        },
 
        Discord = {
            Enabled = true, 
            Invite = "Q6ndPDtK38", 
            RememberJoins = false
        },
 
        KeySystem = true,
        KeySettings = {
            Title = "Void Hub | 🌀",
            Subtitle = "by VoideX",
            Note = "     ↓ Join the discord for key ↓ https://discord.com/invite/Q6ndPDtK38", -- Use this to tell the user how to get a key
            VoidHubBlockspinFarm = "VoidHubKeyBlockSpin", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
            SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
            GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
            Key = {"https://pastebin.com/raw/keXy8HT4"}
        }
    })

local FarmTab = Window:CreateTab("--> Farm <--", nil)

local Section = FarmTab:CreateSection("⚠️Be sure to take the job before starting the autofarm.⚠️")

local ButtonII = FarmTab:CreateButton({
    Name = "🟢 | Start autofarm",
    CurrentValue = false,
    Callback = function()
getgenv().AutoFarm = false
task.wait(0.5)
getgenv().AutoFarm = true

--- Config ---
local SteakSlot = Enum.KeyCode.Two

--- Constants ---
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local VIM = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer

local ProgressBar = Player.PlayerGui.ProgressBar.ProgressBarFrame :: Frame
local BarAmount = ProgressBar.MainFrame.BarAmount :: Frame
local CookedPerfectly = ProgressBar.MainFrame.CookedPerfectly :: Frame
local FinishBar = ProgressBar.InputFrame.FinishBar :: Frame

local Map = workspace:WaitForChild("Map")
local SteakHouse = Map.Tiles.ShoppingTile.SteakHouse.Interior :: Model
local Fridge = SteakHouse.Fridge :: Model 
local prompt = nil
local floor = workspace.Map.Tiles.ShoppingTile.SteakHouse.Exterior.Structure
local hitbox = workspace.Map.Tiles.ShoppingTile.SteakHouse.Hitbox

--- Functions ---
local function keypress(key: Enum.KeyCode)
    VIM:SendKeyEvent(true, key, false, game)
    task.wait()
    VIM:SendKeyEvent(false, key, false, game)
    task.wait()
end

for _, descendant in ipairs(hitbox:GetDescendants()) do
    if descendant:IsA("BasePart") and descendant.Name == "Part" then
        descendant.CanCollide = false
    end
end

for _, part in ipairs(floor:GetDescendants()) do
    if part:IsA("BasePart") and part.Name == "Floor" then
        local currentPosition = part.Position
        part.CFrame = CFrame.new(currentPosition.X, 251.5, currentPosition.Z)
    end
end

for _, base in ipairs(Fridge:GetChildren()) do
    if base.Name == "Base" then
        for _, descendant in ipairs(base:GetDescendants()) do
            if descendant:IsA("ProximityPrompt") then
                prompt = descendant
                break
            end
        end
    end
    if prompt then break end
end

for _, model in ipairs(SteakHouse:GetChildren()) do
    if model.Name == "Grill" then
        local mesh = model:FindFirstChild("Meshes/kitchen assets_Cube.002 (1)", true)
        if mesh and mesh:IsA("BasePart") then
            mesh.CanCollide = false
        end
    end
end

for _, model in ipairs(SteakHouse:GetChildren()) do
    if model.Name == "Grill" then
        local grillArea = model:FindFirstChild("GrillArea", true)
        if grillArea and grillArea:IsA("BasePart") then
            grillArea.Size = Vector3.new(50, 50, 50)
        end
    end
end

local function clickOnUi(element: TextButton)
    firesignal(element.MouseButton1Click)
    task.wait()
end

local function progress()
    return BarAmount.Size.X.Scale
end

local function perfect()
    return CookedPerfectly.Position.X.Scale
end

local function character()
    return Player.Character or Player.CharacterAdded:Wait()
end

local function humanoid()
    return character():WaitForChild("Humanoid") :: Humanoid
end

local function humanoidRootPart()
    return character():WaitForChild("HumanoidRootPart") :: Part
end

-- Increase the fridge distance --
prompt.MaxActivationDistance = 50

humanoid().Sit = true

-- Go inside grill --
local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
TweenService:Create(humanoidRootPart(), tweenInfo, {
    CFrame = CFrame.new(-256.9259338378906, 252.53, 329.9),
}):Play()
task.wait(1.5)

TweenService:Create(humanoidRootPart(), tweenInfo, {
    CFrame = CFrame.new(-262.87811279296875, 252.53, 329.9),
}):Play()
task.wait(1.5)

TweenService:Create(humanoidRootPart(), tweenInfo, {
    CFrame = CFrame.new(-263.06512451171875, 252.53, 332.5),
}):Play()
task.wait(1.6)
--[[ TweenService:Create(humanoidRootPart(), tweenInfo, {
    CFrame = CFrame.new(-263.06512451171875, 253, 332.6),
}):Play()
task.wait(1.6) ]]

--- Main Loop ---
while getgenv().AutoFarm do
    keypress(Enum.KeyCode.E)

    while getgenv().AutoFarm and not ProgressBar.Visible do
        keypress(SteakSlot)

        -- Go back inside grill --
        humanoid().Sit = true
        TweenService:Create(humanoidRootPart(), TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            CFrame = CFrame.new(-263.06512451171875, 252.53, 332.5),
        }):Play()
    end

    while getgenv().AutoFarm and progress() < perfect() do
        if not ProgressBar.Visible then
            warn("Failed to cook")
            break
        end
        --print(progress())
        task.wait()
    end

    clickOnUi(FinishBar)

    print("Successfully cooked")

    task.wait()
end

--- Cleanup ---
-- Go outside grill --
TweenService:Create(humanoidRootPart(), tweenInfo, {
    CFrame = CFrame.new(-263.06512451171875, 256, 340),
}):Play()

humanoid().Sit = false
    end,
})

local ButtonI = FarmTab:CreateButton({
    Name = "🔴 | Stop autofarm",
    Callback = function()
        getgenv().AutoFarm = false
    end,
 })