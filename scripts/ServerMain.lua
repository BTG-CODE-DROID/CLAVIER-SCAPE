-- CLAVIER-SCAPE: Scripts de Plateforme
-- Dossier: ServerScriptService
-- Ceci est le script principal du serveur

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Configuration du jeu
local GAME_CONFIG = {
	playerSpeed = 50,
	jumpPower = 50,
	gravityScale = 1,
	spawnPoint = Vector3.new(0, 5, 0)
}

-- Table pour tracker les joueurs
local playerData = {}

-- Créer les platefomes du niveau
local function createLevel()
	local levelFolder = Instance.new("Folder")
	levelFolder.Name = "Level1"
	levelFolder.Parent = workspace
	
	-- Plateforme de départ
	local startPlatform = Instance.new("Part")
	startPlatform.Name = "StartPlatform"
	startPlatform.Shape = Enum.PartType.Block
	startPlatform.Size = Vector3.new(10, 1, 10)
	startPlatform.TopSurface = Enum.SurfaceType.Smooth
	startPlatform.BottomSurface = Enum.SurfaceType.Smooth
	startPlatform.CFrame = CFrame.new(0, 0, 0)
	startPlatform.BrickColor = BrickColor.new("Bright green")
	startPlatform.CanCollide = true
	startPlatform.Parent = levelFolder
	
	-- Ajouter une texture
	startPlatform.TopSurface = Enum.SurfaceType.Smooth
	
	-- Plateforme 2
	local platform2 = Instance.new("Part")
	platform2.Name = "Platform2"
	platform2.Shape = Enum.PartType.Block
	platform2.Size = Vector3.new(8, 1, 8)
	platform2.TopSurface = Enum.SurfaceType.Smooth
	platform2.BottomSurface = Enum.SurfaceType.Smooth
	platform2.CFrame = CFrame.new(15, 3, 0)
	platform2.BrickColor = BrickColor.new("Bright blue")
	platform2.CanCollide = true
	platform2.Parent = levelFolder
	
	-- Plateforme 3
	local platform3 = Instance.new("Part")
	platform3.Name = "Platform3"
	platform3.Shape = Enum.PartType.Block
	platform3.Size = Vector3.new(8, 1, 8)
	platform3.TopSurface = Enum.SurfaceType.Smooth
	platform3.BottomSurface = Enum.SurfaceType.Smooth
	platform3.CFrame = CFrame.new(30, 5, -10)
	platform3.BrickColor = BrickColor.new("Bright yellow")
	platform3.CanCollide = true
	platform3.Parent = levelFolder
	
	-- Plateforme 4
	local platform4 = Instance.new("Part")
	platform4.Name = "Platform4"
	platform4.Shape = Enum.PartType.Block
	platform4.Size = Vector3.new(8, 1, 8)
	platform4.TopSurface = Enum.SurfaceType.Smooth
	platform4.BottomSurface = Enum.SurfaceType.Smooth
	platform4.CFrame = CFrame.new(45, 3, 0)
	platform4.BrickColor = BrickColor.new("Bright red")
	platform4.CanCollide = true
	platform4.Parent = levelFolder
	
	-- Plateforme finale (FIN)
	local endPlatform = Instance.new("Part")
	endPlatform.Name = "EndPlatform"
	endPlatform.Shape = Enum.PartType.Block
	endPlatform.Size = Vector3.new(10, 1, 10)
	endPlatform.TopSurface = Enum.SurfaceType.Smooth
	endPlatform.BottomSurface = Enum.SurfaceType.Smooth
	endPlatform.CFrame = CFrame.new(60, 5, 0)
	endPlatform.BrickColor = BrickColor.new("Bright magenta")
	endPlatform.CanCollide = true
	endPlatform.Parent = levelFolder
	
	-- Zone vide (mort)
	local killZone = Instance.new("Part")
	killZone.Name = "KillZone"
	killZone.Shape = Enum.PartType.Block
	killZone.Size = Vector3.new(200, 2, 200)
	killZone.TopSurface = Enum.SurfaceType.Smooth
	killZone.BottomSurface = Enum.SurfaceType.Smooth
	killZone.CFrame = CFrame.new(30, -50, 0)
	killZone.CanCollide = true
	killZone.Transparency = 1
	killZone.Parent = levelFolder
	
	-- Ajouter un script de mort à la kill zone
	local killScript = Instance.new("Script")
	killScript.Parent = killZone
	killScript.Source = [[
local killZone = script.Parent
killZone.Touched:Connect(function(hit)
	local humanoid = hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		humanoid:TakeDamage(100)
	end
end)
	]]
	
	return levelFolder
end

-- Initialiser un joueur
local function setupPlayer(player)
	player.CharacterAdded:Connect(function(character)
		-- Créer un dossier de données pour le joueur
		playerData[player.UserId] = {
			character = character,
			score = 0,
			level = 1
		}
		
		-- Ajouter un humanoid si nécessaire
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.MaxHealth = 100
			humanoid.Health = 100
		end
		
		-- Téléporter le joueur au point de spawn
		local rootPart = character:FindFirstChild("HumanoidRootPart")
		if rootPart then
			rootPart.CFrame = CFrame.new(GAME_CONFIG.spawnPoint + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5)))
		end
	end)
end

-- Quand un joueur rejoint
Players.PlayerAdded:Connect(function(player)
	setupPlayer(player)
	print(player.Name .. " a rejoint le jeu !")
end)

-- Quand un joueur quitte
Players.PlayerRemoving:Connect(function(player)
	playerData[player.UserId] = nil
	print(player.Name .. " a quitté le jeu !")
end)

-- Créer le niveau au démarrage du serveur
createLevel()

print("🎮 Serveur CLAVIER-SCAPE démarré !")
