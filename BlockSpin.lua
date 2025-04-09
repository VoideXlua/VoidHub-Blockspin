local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Window = Rayfield:CreateWindow({
        Name = "Void Hub | Blockspin 🔪",
        Icon = 0,
        LoadingTitle = "Void Hub",
        LoadingSubtitle = "by VoideX",
        Theme = "Default",
 
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false,
 
        ConfigurationSaving = {
            Enabled = true,
            FolderName = VoidHub,
            FileName = "Void Hub"
        },
 
        Discord = {
            Enabled = true, 
            Invite = "Q6ndPDtK38", 
            RememberJoins = true
        },
 
        KeySystem = false
})

local FarmTab = Window:CreateTab("Farm", nil)
local JobsSection = FarmTab:CreateSection("Jobs")

local ATMHack = FarmTab:CreateToggle({
    Name = "💳 | Auto hack ATMs",
    CurrentValue = false,
})

local Mop = FarmTab:CreateToggle({
    Name = "🧹 | Auto mop floors",
    CurrentValue = false,
})

local Stock = FarmTab:CreateToggle({
    Name = "📦 | Auto stock shelves",
    CurrentValue = false,
})

local Chef = FarmTab:CreateToggle({
    Name = "🍳 | Auto cook food",
    CurrentValue = false,
    Callback = function(Value)
        IsFarming = Value
        while IsFarming do
            
        end
    end
})


