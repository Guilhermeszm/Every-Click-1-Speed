                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                -- Carrega as bibliotecas necessÃ¡ri
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Cria a janela principal
local Window = Fluent:CreateWindow({
    Title = "By Zetra Hub Bubble Gum Champions",
    SubTitle = "",
    TabWidth = 135,
    Size = UDim2.fromOffset(480, 360),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Adiciona abas Ã  janela
local Tabs = {
    InfoScript = Window:AddTab({ Title = "Info Script", Icon = "scroll" }),
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Others = Window:AddTab({ Title = "Others", Icon = "star" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- Notifica o usuÃ¡rio
Fluent:Notify({
    Title = "By ZetraScripts YT",
    Content = "Thanks for using the script",
    Duration = 5
})

-- Aba Info Script
local SupportSection = Tabs.InfoScript:AddSection("Support")
Tabs.InfoScript:AddParagraph({
    Title = "Supported",
    Content = "- Mobile\n- PC\n- Emulator\n- Console"
})

local UpdatesSection = Tabs.InfoScript:AddSection("Updates")
Tabs.InfoScript:AddParagraph({
    Title = "Updates",
    Content = "- 3/11/2024"
})

local SupportSection = Tabs.InfoScript:AddSection("Support Executors")
Tabs.InfoScript:AddParagraph({
    Title = "Executors",
    Content = "- Delta\n- Fluxus\n- Arceus X\n- Wave\n- Codex"
})

local CreditsSection = Tabs.InfoScript:AddSection("Credits")

local linkParaCopiar = "https://youtube.com/@zetrascripts?si=suM_heCy4O_X-P4H"
Tabs.InfoScript:AddButton({
    Title = "Copy Link Channel",
    Callback = function()
        setclipboard(linkParaCopiar)
        print("Link copied to clipboard.")
    end
})

-- Anti AFK
local AntiAFKEnabled = true
local Toggle = Tabs.Others:AddToggle("MyToggle", {Title = "Anti AFK", Default = true})
Toggle:OnChanged(function()
    AntiAFKEnabled = Options.MyToggle.Value
    print("Toggle changed:", AntiAFKEnabled)
end)
Options.MyToggle:SetValue(true)

Tabs.Others:AddButton({
    Title = "Server Hop",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local HttpService = game:GetService("HttpService")
        local placeId = game.PlaceId

        local function serverHop()
            local servers
            local cursor = ""

            -- Tentar obter uma lista de servidores
            local success, response = pcall(function()
                local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. cursor
                return HttpService:JSONDecode(game:HttpGet(url))
            end)

            if success and response and response.data then
                servers = response.data
            else
                warn("NÃ£o foi possÃ­vel obter servidores.")
                return
            end

            -- Encontrar um servidor diferente do atual
            for _, server in ipairs(servers) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    TeleportService:TeleportToPlaceInstance(placeId, server.id)
                    return
                end
            end

            -- Caso nÃ£o encontre um servidor, tentar buscar mais servidores com cursor
            if response.nextPageCursor then
                cursor = response.nextPageCursor
                serverHop() -- Tenta novamente com o prÃ³ximo cursor
            else
                warn("Nenhum servidor disponÃ­vel para hop.")
            end
        end

        -- Chamar a funÃ§Ã£o de server hop
        serverHop()
    end
})

Tabs.Others:AddButton({
    Title = "Rejoin",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local player = game.Players.LocalPlayer
        TeleportService:Teleport(game.PlaceId, player)
    end
})

local Toggle = Tabs.Main:AddToggle("BlowBubbleToggle", {Title = "Auto Click", Default = false})

local blowing = false

local function blowBubble()
    local args = {
        [1] = "BlowBubble"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

Toggle:OnChanged(function(value)
    print("Toggle changed:", value)

    if value then
        -- Se o toggle estiver ativado, começa a soprar bolhas em loop
        blowing = true
        while blowing do
            blowBubble()
            wait(1) -- Espera 1 segundo entre as chamadas. Ajuste conforme necessário.
        end
    else
        -- Se o toggle estiver desativado, para o loop
        blowing = false
    end
end)

Options.BlowBubbleToggle:SetValue(false) -- Define o valor inicial do toggle como falso

local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "Equip Best Pet", Default = false})

local function equipBest()
    local args = {
        [1] = "EquipBest"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

Toggle:OnChanged(function(value)
    print("Toggle changed:", value)

    if value then
        -- Se o toggle estiver ativado, executa o script
        equipBest()
    end
end)

Options.MyToggle:SetValue(false) -- Define o valor inicial do toggle como falso

local Toggle = Tabs.Main:AddToggle("SellToggle", {Title = "Auto Sell", Default = false})

local selling = false

local function sellBubble()
    local args = {
        [1] = "SellBubble",
        [2] = "Sell"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

Toggle:OnChanged(function(value)
    print("Toggle changed:", value)

    if value then
        -- Se o toggle estiver ativado, comeÃ§a a vender em loop
        selling = true
        while selling do
            sellBubble()
            wait(1) -- Espera 1 segundo entre as chamadas. Ajuste conforme necessÃ¡rio.
        end
    else
        -- Se o toggle estiver desativado, para o loop
        selling = false
    end
end)

Options.SellToggle:SetValue(false) -- Define o valor inicial do toggle como falso

local isRedeeming = false
local codes = {"HALLOWEEN", "Cauldron", "HappyHalloween"}

Tabs.Main:AddButton({
    Title = "Redeem Codes",
    Callback = function()
        isRedeeming = not isRedeeming -- Alterna o estado de isRedeeming
        if isRedeeming then
            print("Started redeeming codes.")
            while isRedeeming do
                for _, code in ipairs(codes) do
                    local args = {
                        [1] = "RedeemCode",
                        [2] = code
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
                    wait(1) -- Espera 1 segundo entre as tentativas de resgatar os cÃ³digos. Ajuste conforme necessÃ¡rio.
                end
            end
        else
            print("Stopped redeeming codes.")
        end
    end
})


local AutoCollectSection = Tabs.Main:AddSection("Auto Collect")

local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "Auto Collect Trick Or Treat", Default = false })

-- VariÃ¡vel para controlar se a funÃ§Ã£o deve continuar executando
local sendingGifts = false

-- FunÃ§Ã£o para enviar presentes de Natal
local function sendXmasGifts()
    while sendingGifts do
        -- Argumentos para o envio do presente
        local args = {
            [1] = "GiveXmasGift",
            [2] = workspace:WaitForChild("Activations"):WaitForChild("GiveXmasGifts")
        }
        -- Chama a funÃ§Ã£o remota para enviar o presente
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
        wait(0.5) -- Adiciona um pequeno intervalo para evitar sobrecarga
    end
end

Toggle:OnChanged(function()
    sendingGifts = Toggle.Value -- Atualiza o estado do envio
    if sendingGifts then
        coroutine.wrap(sendXmasGifts)() -- Inicia o envio em uma corrotina
    end
end)

-- Inicializa o estado do toggle
Toggle:SetValue(false)

local WalkSpeedSection = Tabs.Player:AddSection("WalkSpeed")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Velocidade padrão do personagem
local defaultWalkSpeed = 16 
local currentWalkSpeed = defaultWalkSpeed -- Velocidade atual
local speedEnabled = false -- Estado do toggle

-- Função para definir a WalkSpeed
local function setWalkSpeed(speed)
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = speed
    end
end

-- Criação do input na aba Player
local Input = Tabs.Player:AddInput("Input", {
    Title = "Select Speed", -- Título alterado
    Default = tostring(defaultWalkSpeed), -- Velocidade padrão como string
    Placeholder = "Escolha uma velocidade entre 0 e 100",
    Numeric = true, -- Permite apenas números
    Finished = true, -- Chama o callback quando você pressiona Enter
    Callback = function(Value)
        local speed = tonumber(Value) -- Converte o valor para número
        if speed and speed >= 0 and speed <= 100 then
            currentWalkSpeed = speed
            if speedEnabled then
                setWalkSpeed(currentWalkSpeed) -- Atualiza a velocidade se o toggle estiver ativado
            end
            print("Velocidade definida para:", currentWalkSpeed)
        else
            print("Por favor, insira um valor entre 0 e 100.")
        end
    end
})

-- Criação do toggle na aba Player
local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "Apply Speed", Default = false }) -- Título alterado

Toggle:OnChanged(function()
    speedEnabled = Toggle.Value
    if speedEnabled then
        setWalkSpeed(currentWalkSpeed) -- Define a WalkSpeed quando ativado
        print("Velocidade ativada:", currentWalkSpeed)
    else
        setWalkSpeed(defaultWalkSpeed) -- Restaura a velocidade padrão quando desativado
        print("Velocidade desativada. Voltando ao padrão:", defaultWalkSpeed)
    end
end)

-- Atualiza a WalkSpeed se o personagem mudar
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    setWalkSpeed(speedEnabled and currentWalkSpeed or defaultWalkSpeed) -- Aplica a velocidade atual ou padrão
end)

-- Exibe a atualização do input
Input:OnChanged(function()
    print("Input atualizado:", Input.Value)
end)

local InfiniteJumpSection = Tabs.Player:AddSection("Infinite Jump")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")

local jumpEnabled = false -- Estado do toggle

-- Função para lidar com o pulo
local function onJumpRequest()
    if jumpEnabled and character:FindFirstChild("Humanoid") then
        character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

-- Conectar a função ao evento JumpRequest
UserInputService.JumpRequest:Connect(onJumpRequest)

-- Criação do toggle na aba Player
local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "Enable Infinite Jump", Default = false })

Toggle:OnChanged(function()
    jumpEnabled = Toggle.Value
    if jumpEnabled then
        print("Infinite Jump ativado.")
    else
        print("Infinite Jump desativado.")
    end
end)

-- Atualiza o personagem se ele mudar (ex: ao renascer)
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
end)

-- ConfiguraÃ§Ã£o do SaveManager e InterfaceManager
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})

SaveManager:LoadAutoloadConfig()                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
