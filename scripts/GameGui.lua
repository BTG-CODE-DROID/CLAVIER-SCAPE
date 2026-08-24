-- CLAVIER-SCAPE: GUI du Joueur
-- Dossier: StarterPlayer > StarterPlayerScripts
-- Ceci crée l'interface utilisateur du jeu

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

-- Créer la GUI principale
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GameGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Barre de titre en haut
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0.08, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleBar.BorderSizePixel = 0
titleBar.Parent = screenGui

-- Titre du jeu
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
titleLabel.TextSize = 32
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "🎮 CLAVIER-SCAPE 🎮"
titleLabel.Parent = titleBar

-- Affichage du score
local scoreLabel = Instance.new("TextLabel")
scoreLabel.Name = "Score"
scoreLabel.Size = UDim2.new(0.2, 0, 0.08, 0)
scoreLabel.Position = UDim2.new(0, 10, 0.08, 10)
scoreLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
scoreLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
scoreLabel.TextSize = 20
scoreLabel.Font = Enum.Font.Gotham
scoreLabel.Text = "Score: 0"
scoreLabel.BorderSizePixel = 0
scoreLabel.Parent = screenGui

-- Affichage du niveau
local levelLabel = Instance.new("TextLabel")
levelLabel.Name = "Level"
levelLabel.Size = UDim2.new(0.2, 0, 0.08, 0)
levelLabel.Position = UDim2.new(0.8, -10, 0.08, 10)
levelLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
levelLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
levelLabel.TextSize = 20
levelLabel.Font = Enum.Font.Gotham
levelLabel.Text = "Niveau: 1"
levelLabel.TextXAlignment = Enum.TextXAlignment.Right
levelLabel.BorderSizePixel = 0
levelLabel.Parent = screenGui

-- Affichage des contrôles en bas
local controlsLabel = Instance.new("TextLabel")
controlsLabel.Name = "Controls"
controlsLabel.Size = UDim2.new(1, 0, 0.1, 0)
controlsLabel.Position = UDim2.new(0, 0, 0.9, 0)
controlsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
controlsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
controlsLabel.TextSize = 16
controlsLabel.Font = Enum.Font.Gotham
controlsLabel.Text = "W/A/S/D = Mouvement | ESPACE = Saut | ESC = Quitter"
controlsLabel.TextScaled = true
controlsLabel.BorderSizePixel = 0
controlsLabel.Parent = screenGui

-- Mini-map (coin haut droit)
local minimap = Instance.new("Frame")
minimap.Name = "Minimap"
minimap.Size = UDim2.new(0.15, 0, 0.2, 0)
minimap.Position = UDim2.new(0.83, 0, 0.08, 0)
minimap.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
minimap.BorderColor3 = Color3.fromRGB(0, 255, 100)
minimap.BorderSizePixel = 2
minimap.Parent = screenGui

local minimapLabel = Instance.new("TextLabel")
minimapLabel.Name = "Label"
minimapLabel.Size = UDim2.new(1, 0, 0.3, 0)
minimapLabel.BackgroundTransparency = 1
minimapLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
minimapLabel.TextSize = 14
minimapLabel.Font = Enum.Font.GothamBold
minimapLabel.Text = "Mini-Map"
minimapLabel.Parent = minimap

-- Zone de statut du joueur
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Size = UDim2.new(0.2, 0, 0.15, 0)
statusLabel.Position = UDim2.new(0, 10, 0.18, 0)
statusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
statusLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.Gotham
statusLabel.Text = "Santé: 100/100\nVitesse: Normal"
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.BorderSizePixel = 0
statusLabel.Parent = screenGui

-- Quitter le jeu avec ESC
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.Escape then
		print("Quitter le jeu...")
		game:Shutdown()
	end
end)

print("✅ GUI du jeu chargée !")
