-- Horloge Numérique avec Fuseaux Horaires
-- Digital Clock with Multiple Time Zones
-- Pour Roblox Studio

local TimeZones = {
	{name = "UTC", offset = 0},
	{name = "EST", offset = -5},
	{name = "CST", offset = -6},
	{name = "MST", offset = -7},
	{name = "PST", offset = -8},
	{name = "GMT", offset = 0},
	{name = "CET", offset = 1},
	{name = "EET", offset = 2},
	{name = "IST", offset = 5.5},
	{name = "JST", offset = 9},
	{name = "AEST", offset = 10},
}

local Clock = {}

-- Fonction pour obtenir l'heure formatée
function Clock:getFormattedTime(timestamp)
	local hours = math.floor(timestamp / 3600) % 24
	local minutes = math.floor((timestamp % 3600) / 60)
	local seconds = timestamp % 60
	
	return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

-- Fonction pour obtenir l'heure dans un fuseau horaire spécifique
function Clock:getTimeInZone(zoneOffset)
	local currentTime = os.time()
	local utcTime = os.date("!*t", currentTime)
	
	-- Convertir en secondes depuis minuit UTC
	local secondsSinceUTC = (utcTime.hour * 3600) + (utcTime.min * 60) + utcTime.sec
	
	-- Ajouter l'offset du fuseau horaire
	local offsetSeconds = zoneOffset * 3600
	local zoneTime = secondsSinceUTC + offsetSeconds
	
	-- Gérer le débordement (24 heures)
	if zoneTime < 0 then
		zoneTime = zoneTime + (24 * 3600)
	elseif zoneTime >= (24 * 3600) then
		zoneTime = zoneTime - (24 * 3600)
	end
	
	return self:getFormattedTime(zoneTime)
end

-- Fonction pour afficher toutes les heures des fuseaux horaires
function Clock:displayAllTimeZones()
	print("\n========== HORLOGE MONDIALE ==========")
	print("WORLD CLOCK - " .. os.date("%Y-%m-%d"))
	print("=====================================\n")
	
	for _, zone in ipairs(TimeZones) do
		local time = self:getTimeInZone(zone.offset)
		print(string.format("%-6s : %s", zone.name, time))
	end
	
	print("\n=====================================\n")
end

-- Fonction pour ajouter un nouveau fuseau horaire
function Clock:addTimeZone(name, offset)
	table.insert(TimeZones, {name = name, offset = offset})
	print("Fuseau horaire ajouté: " .. name .. " (UTC" .. (offset >= 0 and "+" or "") .. offset .. ")")
end

-- Fonction pour obtenir un fuseau horaire spécifique
function Clock:getTimeZone(zoneName)
	for _, zone in ipairs(TimeZones) do
		if zone.name == zoneName then
			return self:getTimeInZone(zone.offset)
		end
	end
	return "Fuseau horaire non trouvé"
end

-- Fonction pour créer une GUI d'horloge dans Roblox
function Clock:createClockGUI(parent)
	-- Créer un ScreenGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ClockGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = parent
	
	-- Frame principal
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Size = UDim2.new(0.4, 0, 0.6, 0)
	mainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
	mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui
	
	-- Arrondir les coins
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 15)
	corner.Parent = mainFrame
	
	-- Titre
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
	titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
	titleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
	titleLabel.TextSize = 24
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Text = "🌍 HORLOGE MONDIALE"
	titleLabel.BorderSizePixel = 0
	titleLabel.Parent = mainFrame
	
	-- ScrollingFrame pour les fuseaux horaires
	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Name = "ScrollFrame"
	scrollFrame.Size = UDim2.new(1, 0, 0.85, 0)
	scrollFrame.Position = UDim2.new(0, 0, 0.1, 0)
	scrollFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
	scrollFrame.BorderSizePixel = 0
	scrollFrame.ScrollBarThickness = 10
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	scrollFrame.Parent = mainFrame
	
	-- Layout pour les fuseaux horaires
	local listLayout = Instance.new("UIListLayout")
	listLayout.Parent = scrollFrame
	listLayout.Padding = UDim.new(0, 10)
	listLayout.FillDirection = Enum.FillDirection.Vertical
	
	-- Créer les labels pour chaque fuseau horaire
	for _, zone in ipairs(TimeZones) do
		local zoneFrame = Instance.new("Frame")
		zoneFrame.Name = zone.name
		zoneFrame.Size = UDim2.new(1, -20, 0, 40)
		zoneFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
		zoneFrame.BorderSizePixel = 0
		zoneFrame.Parent = scrollFrame
		
		local zoneCorner = Instance.new("UICorner")
		zoneCorner.CornerRadius = UDim.new(0, 8)
		zoneCorner.Parent = zoneFrame
		
		-- Nom du fuseau
		local nameLabel = Instance.new("TextLabel")
		nameLabel.Name = "NameLabel"
		nameLabel.Size = UDim2.new(0.3, 0, 1, 0)
		nameLabel.BackgroundTransparency = 1
		nameLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
		nameLabel.TextSize = 18
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.Text = zone.name
		nameLabel.Parent = zoneFrame
		
		-- Heure
		local timeLabel = Instance.new("TextLabel")
		timeLabel.Name = "TimeLabel"
		timeLabel.Size = UDim2.new(0.7, 0, 1, 0)
		timeLabel.Position = UDim2.new(0.3, 0, 0, 0)
		timeLabel.BackgroundTransparency = 1
		timeLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
		timeLabel.TextSize = 18
		timeLabel.Font = Enum.Font.GothamMonospace
		timeLabel.Text = self:getTimeInZone(zone.offset)
		timeLabel.TextXAlignment = Enum.TextXAlignment.Right
		timeLabel.Parent = zoneFrame
		
		-- Mettre à jour l'heure toutes les secondes
		spawn(function()
			while true do
				wait(1)
				timeLabel.Text = Clock:getTimeInZone(zone.offset)
			end
		end)
	end
	
	return screenGui
end

-- Tests
if script.Parent == game.ServerScriptService or script.Parent == game.StarterPlayer.StarterCharacterScripts then
	-- Afficher les heures dans la console
	Clock:displayAllTimeZones()
	
	-- Créer la GUI
	local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	Clock:createClockGUI(playerGui)
end

return Clock
