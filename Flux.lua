local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Flux Universal",
   Icon = 0,
   LoadingTitle = "FluxHub",
   LoadingSubtitle = "by WhiteDev on github",
   ShowText = "Rayfield",
   Theme = "Amethyst",
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Flux Universal"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local Mouse = LocalPlayer:GetMouse()
local TouchEnabled = UserInputService.TouchEnabled
local VirtualInput = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")

local ColorStorage = {
   ESPColor = "#FF0000",
   NameColor = "#FFFFFF",
   TracerColor = "#0000FF",
   SkeletonColor = "#FFFFFF",
   FOVColor = "#FF0000",
   BoxColor = "#00FF00",
   HealthBarColor = "#00FF00",
   DistanceColor = "#FFFFFF",
}

local function LoadColors()
   local success, data = pcall(function()
      if isfile and readfile then
         return readfile("FluxUniversal_Colors.json")
      end
   end)
   if success and data then
      local decodeSuccess, decoded = pcall(function()
         return HttpService:JSONDecode(data)
      end)
      if decodeSuccess and type(decoded) == "table" then
         for key, value in pairs(decoded) do
            if ColorStorage[key] ~= nil then
               ColorStorage[key] = value
            end
         end
      end
   end
end

local function SaveColors()
   local success, encoded = pcall(function()
      return HttpService:JSONEncode(ColorStorage)
   end)
   if success then
      pcall(function()
         if writefile then
            writefile("FluxUniversal_Colors.json", encoded)
         end
      end)
   end
end

LoadColors()

local PlayerTab = Window:CreateTab("Player", 4483362458)
local PlayerSection = PlayerTab:CreateSection("Player Settings")

local WalkSpeedValue = 16
local JumpPowerValue = 50

local WalkSpeedToggle = PlayerTab:CreateToggle({
   Name = "WalkSpeed Toggle",
   CurrentValue = false,
   Flag = "WalkSpeed Toggle",
   Callback = function(Value)
      local char = LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.WalkSpeed = Value and WalkSpeedValue or 16
      end
   end,
})

local WalkSpeedSlider = PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 10,
   Suffix = "WalkSpeed",
   CurrentValue = 16,
   Flag = "WalkSpeed Slider",
   Callback = function(Value)
      WalkSpeedValue = Value
      if WalkSpeedToggle.CurrentValue then
         local char = LocalPlayer.Character
         if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = Value
         end
      end
   end,
})

local JumpPowerToggle = PlayerTab:CreateToggle({
   Name = "JumpPower Toggle",
   CurrentValue = false,
   Flag = "JumpPower Toggle",
   Callback = function(Value)
      local char = LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.JumpPower = Value and JumpPowerValue or 50
      end
   end,
})

local JumpPowerSlider = PlayerTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 300},
   Increment = 10,
   Suffix = "JumpPower",
   CurrentValue = 50,
   Flag = "JumpPower Slider",
   Callback = function(Value)
      JumpPowerValue = Value
      if JumpPowerToggle.CurrentValue then
         local char = LocalPlayer.Character
         if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = Value
         end
      end
   end,
})

local DebugSection = PlayerTab:CreateSection("Player Debug")

local GameIdLabel = PlayerTab:CreateLabel("Game ID: " .. game.PlaceId)
local ServerIdLabel = PlayerTab:CreateLabel("Server ID: " .. game.JobId)
local PlayersLabel = PlayerTab:CreateLabel("Players: 0/0")
local UptimeLabel = PlayerTab:CreateLabel("Uptime: 00:00:00")
local VelocityLabel = PlayerTab:CreateLabel("Velocity: 0, 0, 0")
local PositionLabel = PlayerTab:CreateLabel("Position: 0, 0, 0")

PlayerTab:CreateButton({
   Name = "Copy Game ID",
   Callback = function()
      if setclipboard then
         setclipboard(tostring(game.PlaceId))
         Rayfield:Notify({
            Title = "Copied!",
            Content = "Game ID copied to clipboard",
            Duration = 2,
         })
      else
         Rayfield:Notify({
            Title = "Mobile",
            Content = "Clipboard not supported on mobile",
            Duration = 2,
         })
      end
   end,
})

PlayerTab:CreateButton({
   Name = "Copy Server ID",
   Callback = function()
      if setclipboard then
         setclipboard(game.JobId)
         Rayfield:Notify({
            Title = "Copied!",
            Content = "Server ID copied to clipboard",
            Duration = 2,
         })
      else
         Rayfield:Notify({
            Title = "Mobile",
            Content = "Clipboard not supported on mobile",
            Duration = 2,
         })
      end
   end,
})

PlayerTab:CreateButton({
   Name = "Copy Position",
   Callback = function()
      local char = LocalPlayer.Character
      if char and char:FindFirstChild("HumanoidRootPart") then
         local pos = char.HumanoidRootPart.Position
         if setclipboard then
            setclipboard(tostring(pos))
            Rayfield:Notify({
               Title = "Copied!",
               Content = "Position copied to clipboard",
               Duration = 2,
            })
         else
            Rayfield:Notify({
               Title = "Mobile",
               Content = "Position: " .. tostring(pos),
               Duration = 3,
            })
         end
      else
         Rayfield:Notify({
            Title = "Error",
            Content = "Character not found",
            Duration = 2,
         })
      end
   end,
})

PlayerTab:CreateButton({
   Name = "Copy Rejoin Script",
   Callback = function()
      local script = 'game:GetService("TeleportService"):TeleportToPlaceInstance(' .. game.PlaceId .. ', "' .. game.JobId .. '", game.Players.LocalPlayer)'
      if setclipboard then
         setclipboard(script)
         Rayfield:Notify({
            Title = "Copied!",
            Content = "Rejoin script copied to clipboard",
            Duration = 2,
         })
      else
         Rayfield:Notify({
            Title = "Mobile",
            Content = "Script: " .. script,
            Duration = 5,
         })
      end
   end,
})

local function ResetPlayerStats()
   local char = LocalPlayer.Character
   if char and char:FindFirstChild("Humanoid") then
      local humanoid = char.Humanoid
      humanoid.WalkSpeed = WalkSpeedToggle.CurrentValue and WalkSpeedValue or 16
      humanoid.JumpPower = JumpPowerToggle.CurrentValue and JumpPowerValue or 50
   end
end

LocalPlayer.CharacterAdded:Connect(function(char)
   char:WaitForChild("Humanoid")
   task.wait(0.5)
   ResetPlayerStats()
end)

local startTime = tick()
local debugConnection = RunService.Heartbeat:Connect(function()
   local char = LocalPlayer.Character
   local humanoid = char and char:FindFirstChild("Humanoid")
   local rootPart = char and char:FindFirstChild("HumanoidRootPart")
   
   if humanoid and rootPart then
      local vel = rootPart.Velocity
      local pos = rootPart.Position
      VelocityLabel:Set(string.format("Velocity: %.1f, %.1f, %.1f", vel.X, vel.Y, vel.Z))
      PositionLabel:Set(string.format("Position: %.1f, %.1f, %.1f", pos.X, pos.Y, pos.Z))
   end
   
   PlayersLabel:Set("Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers)
   
   local uptime = math.floor(tick() - startTime)
   UptimeLabel:Set(string.format("Uptime: %02d:%02d:%02d", uptime//3600, (uptime%3600)//60, uptime%60))
end)

local ESPTab = Window:CreateTab("ESP", 4483362458)
local ESPSection = ESPTab:CreateSection("ESP Settings")

local ESPEnabled = false
local NameEnabled = false
local TracerEnabled = false
local SkeletonEnabled = false
local HealthBarEnabled = false
local DistanceEnabled = false
local BoxEnabled = false

local ESPObjects = {}
local NameObjects = {}
local TracerObjects = {}
local SkeletonObjects = {}
local HealthBarObjects = {}
local DistanceObjects = {}
local BoxObjects = {}
local TracerConnection = nil
local SkeletonConnection = nil
local HealthConnection = nil
local DistanceConnection = nil
local BoxConnection = nil

local function HexToRGB(hex)
   hex = hex:gsub("#", "")
   return Color3.fromRGB(
      tonumber(hex:sub(1, 2), 16) or 255,
      tonumber(hex:sub(3, 4), 16) or 0,
      tonumber(hex:sub(5, 6), 16) or 0
   )
end

local function CreateESP(player)
   if player == LocalPlayer or ESPObjects[player] or not player.Character then return end
   local char = player.Character
   if not char:FindFirstChild("HumanoidRootPart") then return end
   
   local highlight = Instance.new("Highlight")
   highlight.FillColor = HexToRGB(ColorStorage.ESPColor)
   highlight.FillTransparency = 0.5
   highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
   highlight.OutlineTransparency = 0
   highlight.Adornee = char
   highlight.Enabled = ESPEnabled
   highlight.Parent = char
   
   local billboard = Instance.new("BillboardGui")
   billboard.Size = UDim2.new(0, 200, 0, 60)
   billboard.StudsOffset = Vector3.new(0, 2.5, 0)
   billboard.AlwaysOnTop = true
   billboard.Enabled = true
   billboard.Parent = char
   
   local nameLabel = Instance.new("TextLabel")
   nameLabel.Size = UDim2.new(1, 0, 0, 20)
   nameLabel.Position = UDim2.new(0, 0, 0, 0)
   nameLabel.BackgroundTransparency = 1
   nameLabel.Text = player.Name
   nameLabel.TextColor3 = HexToRGB(ColorStorage.NameColor)
   nameLabel.TextSize = 14
   nameLabel.Font = Enum.Font.GothamBold
   nameLabel.TextStrokeTransparency = 0.5
   nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
   nameLabel.Visible = NameEnabled
   nameLabel.Parent = billboard
   
   local healthBg = Instance.new("Frame")
   healthBg.Size = UDim2.new(0.8, 0, 0, 6)
   healthBg.Position = UDim2.new(0.1, 0, 0, 22)
   healthBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
   healthBg.BackgroundTransparency = 0.5
   healthBg.Visible = HealthBarEnabled
   healthBg.Parent = billboard
   
   local healthBar = Instance.new("Frame")
   healthBar.Size = UDim2.new(1, 0, 1, 0)
   healthBar.BackgroundColor3 = HexToRGB(ColorStorage.HealthBarColor)
   healthBar.BackgroundTransparency = 0
   healthBar.Parent = healthBg
   
   local distLabel = Instance.new("TextLabel")
   distLabel.Size = UDim2.new(1, 0, 0, 16)
   distLabel.Position = UDim2.new(0, 0, 0, 30)
   distLabel.BackgroundTransparency = 1
   distLabel.Text = "0m"
   distLabel.TextColor3 = HexToRGB(ColorStorage.DistanceColor)
   distLabel.TextSize = 12
   distLabel.Font = Enum.Font.Gotham
   distLabel.TextStrokeTransparency = 0.5
   distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
   distLabel.Visible = DistanceEnabled
   distLabel.Parent = billboard
   
   ESPObjects[player] = highlight
   NameObjects[player] = nameLabel
   HealthBarObjects[player] = {healthBg, healthBar}
   DistanceObjects[player] = distLabel
end

local function CreateTracer(player)
   if player == LocalPlayer or TracerObjects[player] or not player.Character then return end
   local char = player.Character
   if not char:FindFirstChild("HumanoidRootPart") then return end
   
   local tracer = Drawing.new("Line")
   tracer.Color = HexToRGB(ColorStorage.TracerColor)
   tracer.Thickness = 1.5
   tracer.Transparency = 0.7
   tracer.Visible = TracerEnabled
   TracerObjects[player] = tracer
end

local function CreateSkeleton(player)
   if player == LocalPlayer or SkeletonObjects[player] or not player.Character then return end
   
   local joints = {}
   for i = 1, 12 do
      local line = Drawing.new("Line")
      line.Color = HexToRGB(ColorStorage.SkeletonColor)
      line.Thickness = 2
      line.Transparency = 0.8
      line.Visible = SkeletonEnabled
      table.insert(joints, line)
   end
   SkeletonObjects[player] = joints
end

local function CreateBox(player)
   if player == LocalPlayer or BoxObjects[player] or not player.Character then return end
   local char = player.Character
   if not char:FindFirstChild("HumanoidRootPart") then return end
   
   local box = {}
   for i = 1, 4 do
      local line = Drawing.new("Line")
      line.Color = HexToRGB(ColorStorage.BoxColor)
      line.Thickness = 2
      line.Transparency = 0.7
      line.Visible = BoxEnabled
      table.insert(box, line)
   end
   BoxObjects[player] = box
end

local function RemoveESP(player)
   if ESPObjects[player] then
      ESPObjects[player]:Destroy()
      ESPObjects[player] = nil
   end
   if NameObjects[player] then
      NameObjects[player] = nil
   end
   if TracerObjects[player] then
      TracerObjects[player]:Remove()
      TracerObjects[player] = nil
   end
   if SkeletonObjects[player] then
      for _, line in ipairs(SkeletonObjects[player]) do
         line:Remove()
      end
      SkeletonObjects[player] = nil
   end
   if HealthBarObjects[player] then
      HealthBarObjects[player] = nil
   end
   if DistanceObjects[player] then
      DistanceObjects[player] = nil
   end
   if BoxObjects[player] then
      for _, line in ipairs(BoxObjects[player]) do
         line:Remove()
      end
      BoxObjects[player] = nil
   end
end

local function RemoveAllESP()
   for player in pairs(ESPObjects) do
      RemoveESP(player)
   end
   ESPObjects = {}
   NameObjects = {}
   TracerObjects = {}
   SkeletonObjects = {}
   HealthBarObjects = {}
   DistanceObjects = {}
   BoxObjects = {}
end

local function UpdateAllPlayers()
   for _, player in ipairs(Players:GetPlayers()) do
      if player ~= LocalPlayer then
         if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not ESPObjects[player] then CreateESP(player) end
            if not TracerObjects[player] then CreateTracer(player) end
            if not SkeletonObjects[player] then CreateSkeleton(player) end
            if not BoxObjects[player] then CreateBox(player) end
         else
            RemoveESP(player)
         end
      end
   end
end

local function SetupPlayer(player)
   if player == LocalPlayer then return end
   player.CharacterAdded:Connect(function(char)
      task.wait(0.5)
      RemoveESP(player)
      CreateESP(player)
      CreateTracer(player)
      CreateSkeleton(player)
      CreateBox(player)
   end)
end

for _, player in ipairs(Players:GetPlayers()) do
   if player ~= LocalPlayer then
      CreateESP(player)
      CreateTracer(player)
      CreateSkeleton(player)
      CreateBox(player)
   end
   SetupPlayer(player)
end

Players.PlayerAdded:Connect(function(player)
   if player ~= LocalPlayer then
      task.wait(0.5)
      CreateESP(player)
      CreateTracer(player)
      CreateSkeleton(player)
      CreateBox(player)
   end
   SetupPlayer(player)
end)

Players.PlayerRemoving:Connect(RemoveESP)

local function UpdateHealthBars()
   for player, healthObjects in pairs(HealthBarObjects) do
      local char = player.Character
      if char then
         local humanoid = char:FindFirstChild("Humanoid")
         if humanoid then
            local health = humanoid.Health
            local maxHealth = humanoid.MaxHealth
            local percent = math.clamp(health / maxHealth, 0, 1)
            
            local bg, bar = healthObjects[1], healthObjects[2]
            if bg and bar then
               bar.Size = UDim2.new(percent, 0, 1, 0)
               local baseColor = HexToRGB(ColorStorage.HealthBarColor)
               if percent > 0.5 then
                  bar.BackgroundColor3 = baseColor
               elseif percent > 0.25 then
                  bar.BackgroundColor3 = Color3.fromRGB(
                     baseColor.R * 255,
                     baseColor.G * 255 * 0.7,
                     baseColor.B * 255 * 0.3
                  )
               else
                  bar.BackgroundColor3 = Color3.fromRGB(
                     baseColor.R * 255 * 0.7,
                     baseColor.G * 255 * 0.2,
                     baseColor.B * 255 * 0.1
                  )
               end
            end
         end
      end
   end
end

local function UpdateDistance()
   local localChar = LocalPlayer.Character
   local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")
   if not localRoot then return end
   
   for player, distLabel in pairs(DistanceObjects) do
      local char = player.Character
      if char then
         local root = char:FindFirstChild("HumanoidRootPart")
         if root then
            local distance = (localRoot.Position - root.Position).Magnitude
            distLabel.Text = string.format("%.0fm", distance)
         end
      end
   end
end

local ESPToggle = ESPTab:CreateToggle({
   Name = "ESP Players",
   CurrentValue = false,
   Flag = "ESP Toggle",
   Callback = function(Value)
      ESPEnabled = Value
      for _, highlight in pairs(ESPObjects) do
         highlight.Enabled = Value
      end
      if Value then UpdateAllPlayers() end
   end,
})

ESPTab:CreateInput({
   Name = "ESP Color (HEX)",
   CurrentValue = ColorStorage.ESPColor,
   PlaceholderText = "#FF0000",
   Flag = "ESP Color",
   Callback = function(Value)
      local success, color = pcall(HexToRGB, Value)
      if success then
         ColorStorage.ESPColor = Value
         SaveColors()
         for _, highlight in pairs(ESPObjects) do
            highlight.FillColor = color
         end
         Rayfield:Notify({Title = "Color Updated", Content = "ESP color changed to " .. Value, Duration = 2})
      else
         Rayfield:Notify({Title = "Invalid Color", Content = "Please enter a valid HEX color", Duration = 2})
      end
   end,
})

local NameToggle = ESPTab:CreateToggle({
   Name = "ESP Users (Names)",
   CurrentValue = false,
   Flag = "Name Toggle",
   Callback = function(Value)
      NameEnabled = Value
      for _, nameLabel in pairs(NameObjects) do
         if nameLabel then
            nameLabel.Visible = Value
         end
      end
      if Value then UpdateAllPlayers() end
   end,
})

ESPTab:CreateInput({
   Name = "Name Color (HEX)",
   CurrentValue = ColorStorage.NameColor,
   PlaceholderText = "#FFFFFF",
   Flag = "Name Color",
   Callback = function(Value)
      local success, color = pcall(HexToRGB, Value)
      if success then
         ColorStorage.NameColor = Value
         SaveColors()
         for _, nameLabel in pairs(NameObjects) do
            if nameLabel then
               nameLabel.TextColor3 = color
            end
         end
         Rayfield:Notify({Title = "Color Updated", Content = "Name color changed to " .. Value, Duration = 2})
      else
         Rayfield:Notify({Title = "Invalid Color", Content = "Please enter a valid HEX color", Duration = 2})
      end
   end,
})

local TracerToggle = ESPTab:CreateToggle({
   Name = "ESP Tracers",
   CurrentValue = false,
   Flag = "Tracer Toggle",
   Callback = function(Value)
      TracerEnabled = Value
      
      for _, tracer in pairs(TracerObjects) do
         if tracer then
            tracer.Visible = Value
         end
      end
      
      if not Value then
         if TracerConnection then TracerConnection:Disconnect() TracerConnection = nil end
      else
         UpdateAllPlayers()
         if not TracerConnection then
            TracerConnection = RunService.RenderStepped:Connect(function()
               if not TracerEnabled then
                  for _, t in pairs(TracerObjects) do 
                     if t then t.Visible = false end 
                  end
                  return
               end
               local localChar = LocalPlayer.Character
               local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")
               if not localRoot then
                  for _, t in pairs(TracerObjects) do 
                     if t then t.Visible = false end 
                  end
                  return
               end
               local startPos = localRoot.Position
               local screenStart, startVisible = Camera:WorldToViewportPoint(startPos)
               if not startVisible then
                  for _, t in pairs(TracerObjects) do 
                     if t then t.Visible = false end 
                  end
                  return
               end
               for player, tracer in pairs(TracerObjects) do
                  local char = player.Character
                  if not char then
                     if tracer then tracer.Visible = false end
                     continue
                  end
                  
                  local root = char:FindFirstChild("HumanoidRootPart")
                  local humanoid = char:FindFirstChild("Humanoid")
                  
                  if root and humanoid and humanoid.Health > 0 then
                     local endPos = root.Position
                     local screenEnd, endVisible = Camera:WorldToViewportPoint(endPos)
                     
                     if endVisible and tracer then
                        tracer.From = Vector2.new(screenStart.X, screenStart.Y)
                        tracer.To = Vector2.new(screenEnd.X, screenEnd.Y)
                        tracer.Visible = TracerEnabled
                     elseif tracer then
                        tracer.Visible = false
                     end
                  elseif tracer then
                     tracer.Visible = false
                  end
               end
            end)
         end
      end
   end,
})

ESPTab:CreateInput({
   Name = "Tracer Color (HEX)",
   CurrentValue = ColorStorage.TracerColor,
   PlaceholderText = "#0000FF",
   Flag = "Tracer Color",
   Callback = function(Value)
      local success, color = pcall(HexToRGB, Value)
      if success then
         ColorStorage.TracerColor = Value
         SaveColors()
         for _, tracer in pairs(TracerObjects) do 
            if tracer then tracer.Color = color end
         end
         Rayfield:Notify({Title = "Color Updated", Content = "Tracer color changed to " .. Value, Duration = 2})
      else
         Rayfield:Notify({Title = "Invalid Color", Content = "Please enter a valid HEX color", Duration = 2})
      end
   end,
})

local SkeletonToggle = ESPTab:CreateToggle({
   Name = "ESP Skeleton",
   CurrentValue = false,
   Flag = "Skeleton Toggle",
   Callback = function(Value)
      SkeletonEnabled = Value
      
      for _, lines in pairs(SkeletonObjects) do
         for _, line in ipairs(lines) do
            if line then line.Visible = Value end
         end
      end
      
      if not Value then
         if SkeletonConnection then SkeletonConnection:Disconnect() SkeletonConnection = nil end
      else
         UpdateAllPlayers()
         if not SkeletonConnection then
            SkeletonConnection = RunService.RenderStepped:Connect(function()
               if not SkeletonEnabled then
                  for _, lines in pairs(SkeletonObjects) do
                     for _, line in ipairs(lines) do 
                        if line then line.Visible = false end
                     end
                  end
                  return
               end
               for player, lines in pairs(SkeletonObjects) do
                  local char = player.Character
                  if not char then
                     for _, line in ipairs(lines) do 
                        if line then line.Visible = false end
                     end
                     continue
                  end
                  
                  local isR15 = char:FindFirstChild("UpperTorso") ~= nil
                  
                  if isR15 then
                     local head = char:FindFirstChild("Head")
                     local upperTorso = char:FindFirstChild("UpperTorso")
                     local lowerTorso = char:FindFirstChild("LowerTorso")
                     local leftUpperArm = char:FindFirstChild("LeftUpperArm")
                     local leftLowerArm = char:FindFirstChild("LeftLowerArm")
                     local rightUpperArm = char:FindFirstChild("RightUpperArm")
                     local rightLowerArm = char:FindFirstChild("RightLowerArm")
                     local leftUpperLeg = char:FindFirstChild("LeftUpperLeg")
                     local leftLowerLeg = char:FindFirstChild("LeftLowerLeg")
                     local rightUpperLeg = char:FindFirstChild("RightUpperLeg")
                     local rightLowerLeg = char:FindFirstChild("RightLowerLeg")
                     
                     local bones = {}
                     table.insert(bones, head)
                     table.insert(bones, upperTorso)
                     table.insert(bones, lowerTorso)
                     table.insert(bones, leftUpperArm)
                     table.insert(bones, leftLowerArm)
                     table.insert(bones, rightUpperArm)
                     table.insert(bones, rightLowerArm)
                     table.insert(bones, leftUpperLeg)
                     table.insert(bones, leftLowerLeg)
                     table.insert(bones, rightUpperLeg)
                     table.insert(bones, rightLowerLeg)
                     
                     local positions = {}
                     local allVisible = true
                     for _, bone in ipairs(bones) do
                        if bone and bone:IsA("BasePart") then
                           local pos, vis = Camera:WorldToViewportPoint(bone.Position)
                           if vis then
                              table.insert(positions, Vector2.new(pos.X, pos.Y))
                           else
                              table.insert(positions, nil)
                              allVisible = false
                           end
                        else
                           table.insert(positions, nil)
                           allVisible = false
                        end
                     end
                     
                     local connections = {{1,2},{2,3},{3,4},{4,5},{3,6},{6,7},{3,8},{8,9},{3,10},{10,11}}
                     local idx = 1
                     for _, conn in ipairs(connections) do
                        local from = positions[conn[1]]
                        local to = positions[conn[2]]
                        local line = lines[idx]
                        if line then
                           if from and to and allVisible then
                              line.From = from
                              line.To = to
                              line.Visible = SkeletonEnabled
                           else
                              line.Visible = false
                           end
                        end
                        idx = idx + 1
                     end
                  else
                     local head = char:FindFirstChild("Head")
                     local torso = char:FindFirstChild("Torso")
                     
                     if head and torso then
                        local headPos, headVis = Camera:WorldToViewportPoint(head.Position)
                        local torsoPos, torsoVis = Camera:WorldToViewportPoint(torso.Position)
                        
                        if headVis and torsoVis then
                           local line1 = lines[1]
                           if line1 then
                              line1.From = Vector2.new(headPos.X, headPos.Y)
                              line1.To = Vector2.new(torsoPos.X, torsoPos.Y)
                              line1.Visible = SkeletonEnabled
                           end
                           
                           for i = 2, 12 do
                              local line = lines[i]
                              if line then
                                 line.Visible = false
                              end
                           end
                        end
                     end
                  end
               end
            end)
         end
      end
   end,
})

ESPTab:CreateInput({
   Name = "Skeleton Color (HEX)",
   CurrentValue = ColorStorage.SkeletonColor,
   PlaceholderText = "#FFFFFF",
   Flag = "Skeleton Color",
   Callback = function(Value)
      local success, color = pcall(HexToRGB, Value)
      if success then
         ColorStorage.SkeletonColor = Value
         SaveColors()
         for _, lines in pairs(SkeletonObjects) do
            for _, line in ipairs(lines) do 
               if line then line.Color = color end
            end
         end
         Rayfield:Notify({Title = "Color Updated", Content = "Skeleton color changed to " .. Value, Duration = 2})
      else
         Rayfield:Notify({Title = "Invalid Color", Content = "Please enter a valid HEX color", Duration = 2})
      end
   end,
})

local HealthBarToggle = ESPTab:CreateToggle({
   Name = "ESP Health Bar",
   CurrentValue = false,
   Flag = "Health Bar Toggle",
   Callback = function(Value)
      HealthBarEnabled = Value
      for _, healthObjects in pairs(HealthBarObjects) do
         if healthObjects and healthObjects[1] then
            healthObjects[1].Visible = Value
         end
      end
      if Value then
         UpdateAllPlayers()
         if HealthConnection then
            HealthConnection:Disconnect()
            HealthConnection = nil
         end
         HealthConnection = RunService.Heartbeat:Connect(UpdateHealthBars)
      else
         if HealthConnection then
            HealthConnection:Disconnect()
            HealthConnection = nil
         end
      end
   end,
})

ESPTab:CreateInput({
   Name = "Health Bar Color (HEX)",
   CurrentValue = ColorStorage.HealthBarColor,
   PlaceholderText = "#00FF00",
   Flag = "Health Bar Color",
   Callback = function(Value)
      local success, color = pcall(HexToRGB, Value)
      if success then
         ColorStorage.HealthBarColor = Value
         SaveColors()
         for _, healthObjects in pairs(HealthBarObjects) do
            if healthObjects and healthObjects[2] then
               healthObjects[2].BackgroundColor3 = color
            end
         end
         Rayfield:Notify({Title = "Color Updated", Content = "Health bar color changed to " .. Value, Duration = 2})
      else
         Rayfield:Notify({Title = "Invalid Color", Content = "Please enter a valid HEX color", Duration = 2})
      end
   end,
})

local DistanceToggle = ESPTab:CreateToggle({
   Name = "ESP Distance",
   CurrentValue = false,
   Flag = "Distance Toggle",
   Callback = function(Value)
      DistanceEnabled = Value
      for _, distLabel in pairs(DistanceObjects) do
         if distLabel then
            distLabel.Visible = Value
         end
      end
      if Value then
         UpdateAllPlayers()
         if DistanceConnection then
            DistanceConnection:Disconnect()
            DistanceConnection = nil
         end
         DistanceConnection = RunService.Heartbeat:Connect(UpdateDistance)
      else
         if DistanceConnection then
            DistanceConnection:Disconnect()
            DistanceConnection = nil
         end
      end
   end,
})

ESPTab:CreateInput({
   Name = "Distance Color (HEX)",
   CurrentValue = ColorStorage.DistanceColor,
   PlaceholderText = "#FFFFFF",
   Flag = "Distance Color",
   Callback = function(Value)
      local success, color = pcall(HexToRGB, Value)
      if success then
         ColorStorage.DistanceColor = Value
         SaveColors()
         for _, distLabel in pairs(DistanceObjects) do
            if distLabel then
               distLabel.TextColor3 = color
            end
         end
         Rayfield:Notify({Title = "Color Updated", Content = "Distance color changed to " .. Value, Duration = 2})
      else
         Rayfield:Notify({Title = "Invalid Color", Content = "Please enter a valid HEX color", Duration = 2})
      end
   end,
})

local BoxToggle = ESPTab:CreateToggle({
   Name = "ESP Box",
   CurrentValue = false,
   Flag = "Box Toggle",
   Callback = function(Value)
      BoxEnabled = Value
      
      for _, box in pairs(BoxObjects) do
         for _, line in ipairs(box) do
            if line then line.Visible = Value end
         end
      end
      
      if not Value then
         if BoxConnection then BoxConnection:Disconnect() BoxConnection = nil end
      else
         UpdateAllPlayers()
         if not BoxConnection then
            BoxConnection = RunService.RenderStepped:Connect(function()
               if not BoxEnabled then
                  for _, box in pairs(BoxObjects) do
                     for _, line in ipairs(box) do 
                        if line then line.Visible = false end
                     end
                  end
                  return
               end
               
               for player, boxLines in pairs(BoxObjects) do
                  local char = player.Character
                  if not char then
                     for _, line in ipairs(boxLines) do 
                        if line then line.Visible = false end
                     end
                     continue
                  end
                  
                  local root = char:FindFirstChild("HumanoidRootPart")
                  local head = char:FindFirstChild("Head")
                  local humanoid = char:FindFirstChild("Humanoid")
                  
                  if not root or not head or not humanoid or humanoid.Health <= 0 then
                     for _, line in ipairs(boxLines) do 
                        if line then line.Visible = false end
                     end
                     continue
                  end
                  
                  local headPos, headVis = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                  local feetPos, feetVis = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 2, 0))
                  
                  if not headVis or not feetVis then
                     for _, line in ipairs(boxLines) do 
                        if line then line.Visible = false end
                     end
                     continue
                  end
                  
                  local distance = (Camera.CFrame.Position - root.Position).Magnitude
                  local size = math.clamp(100 / distance, 20, 150)
                  
                  local x1 = headPos.X - size / 2
                  local x2 = headPos.X + size / 2
                  local y1 = headPos.Y
                  local y2 = feetPos.Y
                  
                  local lines = {
                     {Vector2.new(x1, y1), Vector2.new(x2, y1)},
                     {Vector2.new(x2, y1), Vector2.new(x2, y2)},
                     {Vector2.new(x2, y2), Vector2.new(x1, y2)},
                     {Vector2.new(x1, y2), Vector2.new(x1, y1)},
                  }
                  
                  for i, linePair in ipairs(lines) do
                     local line = boxLines[i]
                     if line then
                        line.From = linePair[1]
                        line.To = linePair[2]
                        line.Visible = BoxEnabled
                     end
                  end
               end
            end)
         end
      end
   end,
})

ESPTab:CreateInput({
   Name = "Box Color (HEX)",
   CurrentValue = ColorStorage.BoxColor,
   PlaceholderText = "#00FF00",
   Flag = "Box Color",
   Callback = function(Value)
      local success, color = pcall(HexToRGB, Value)
      if success then
         ColorStorage.BoxColor = Value
         SaveColors()
         for _, box in pairs(BoxObjects) do
            for _, line in ipairs(box) do 
               if line then line.Color = color end
            end
         end
         Rayfield:Notify({Title = "Color Updated", Content = "Box color changed to " .. Value, Duration = 2})
      else
         Rayfield:Notify({Title = "Invalid Color", Content = "Please enter a valid HEX color", Duration = 2})
      end
   end,
})

local AimbotTab = Window:CreateTab("Aimbot", 4483362458)
local AimbotSection = AimbotTab:CreateSection("Aimbot Settings")

local AimbotEnabled = false
local TriggerbotEnabled = false
local AimPart = "Head"
local FOV = 150
local FOVColor = HexToRGB(ColorStorage.FOVColor)
local FOVCircle = nil
local AimbotConnection = nil
local RightClickHeld = false
local CurrentTarget = nil
local LastTriggerTime = 0
local TriggerDelay = 0.1

local function CreateFOVCircle()
   if FOVCircle then
      FOVCircle:Remove()
      FOVCircle = nil
   end
   FOVCircle = Drawing.new("Circle")
   FOVCircle.Thickness = 2
   FOVCircle.Radius = FOV
   FOVCircle.Filled = false
   FOVCircle.Color = FOVColor
   FOVCircle.Transparency = 0.6
   FOVCircle.Visible = AimbotEnabled
   FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
   FOVCircle.ZIndex = 999
   FOVCircle.NumSides = 64
end

local function UpdateFOVCircle()
   if FOVCircle then
      FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
      FOVCircle.Radius = FOV
      FOVCircle.Color = FOVColor
      FOVCircle.Visible = AimbotEnabled
      FOVCircle.NumSides = 64
   end
end

local function IsPlayerVisible(player)
   if not player or not player.Character then return false end
   local char = player.Character
   local targetPart = char:FindFirstChild(AimPart) or char:FindFirstChild("Head")
   if not targetPart then return false end
   
   local localChar = LocalPlayer.Character
   if not localChar then return false end
   local localRoot = localChar:FindFirstChild("HumanoidRootPart")
   if not localRoot then return false end
   
   local origin = Camera.CFrame.Position
   local direction = (targetPart.Position - origin).Unit
   local distance = (targetPart.Position - origin).Magnitude
   
   local raycastParams = RaycastParams.new()
   raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
   raycastParams.FilterDescendantsInstances = {localChar, char}
   raycastParams.IgnoreWater = true
   
   local result = workspace:Raycast(origin, direction * distance, raycastParams)
   
   return result == nil
end

local function GetClosestPlayer()
   local localChar = LocalPlayer.Character
   local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")
   if not localRoot then return nil end
   
   local closest = nil
   local closestDist = FOV
   local centerX = Camera.ViewportSize.X / 2
   local centerY = Camera.ViewportSize.Y / 2
   
   for _, player in ipairs(Players:GetPlayers()) do
      if player == LocalPlayer then continue end
      local char = player.Character
      if not char then continue end
      
      local humanoid = char:FindFirstChild("Humanoid")
      if not humanoid or humanoid.Health <= 0 then continue end
      
      local targetPart = char:FindFirstChild(AimPart) or char:FindFirstChild("Head")
      if not targetPart then continue end
      
      if not IsPlayerVisible(player) then continue end
      
      local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
      if not onScreen then continue end
      
      local dx = pos.X - centerX
      local dy = pos.Y - centerY
      local dist = math.sqrt(dx * dx + dy * dy)
      
      if dist < closestDist then
         closestDist = dist
         closest = player
      end
   end
   
   return closest
end

local function LockAim(target)
   if not target then return end
   local char = target.Character
   if not char then return end
   
   local targetPart = char:FindFirstChild(AimPart) or char:FindFirstChild("Head")
   if not targetPart then return end
   
   local targetPos = targetPart.Position
   Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPos)
end

local function Triggerbot()
   if not TriggerbotEnabled then return end
   
   local localChar = LocalPlayer.Character
   if not localChar then return end
   
   local currentTime = tick()
   if currentTime - LastTriggerTime < TriggerDelay then return end
   
   local mousePos = UserInputService:GetMouseLocation()
   if not mousePos then return end
   
   local target = nil
   local closestDist = 50
   
   for _, player in ipairs(Players:GetPlayers()) do
      if player == LocalPlayer then continue end
      local char = player.Character
      if not char then continue end
      
      local humanoid = char:FindFirstChild("Humanoid")
      if not humanoid or humanoid.Health <= 0 then continue end
      
      local targetPart = char:FindFirstChild(AimPart) or char:FindFirstChild("Head")
      if not targetPart then continue end
      
      if not IsPlayerVisible(player) then continue end
      
      local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
      if not onScreen then continue end
      
      local dx = pos.X - mousePos.X
      local dy = pos.Y - mousePos.Y
      local dist = math.sqrt(dx * dx + dy * dy)
      
      if dist < closestDist then
         closestDist = dist
         target = player
      end
   end
   
   if target then
      VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton1, 0, true)
      task.wait(0.01)
      VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton1, 0, false)
      LastTriggerTime = tick()
   end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
   if gameProcessed then return end
   if input.UserInputType == Enum.UserInputType.MouseButton2 then
      RightClickHeld = true
   end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
   if gameProcessed then return end
   if input.UserInputType == Enum.UserInputType.MouseButton2 then
      RightClickHeld = false
      CurrentTarget = nil
   end
end)

local AimbotToggle = AimbotTab:CreateToggle({
   Name = "Aimbot",
   CurrentValue = false,
   Flag = "Aimbot Toggle",
   Callback = function(Value)
      AimbotEnabled = Value
      if Value then
         CreateFOVCircle()
         if AimbotConnection then
            AimbotConnection:Disconnect()
            AimbotConnection = nil
         end
         AimbotConnection = RunService.RenderStepped:Connect(function()
            if not AimbotEnabled then return end
            
            if RightClickHeld then
               if not CurrentTarget then
                  CurrentTarget = GetClosestPlayer()
               end
               
               if CurrentTarget and CurrentTarget.Character and 
                  CurrentTarget.Character:FindFirstChild("Humanoid") and 
                  CurrentTarget.Character.Humanoid.Health > 0 and
                  IsPlayerVisible(CurrentTarget) then
                  LockAim(CurrentTarget)
               else
                  CurrentTarget = nil
               end
            else
               CurrentTarget = nil
            end
            
            if TriggerbotEnabled then
               Triggerbot()
            end
         end)
      else
         if FOVCircle then
            FOVCircle:Remove()
            FOVCircle = nil
         end
         if AimbotConnection then
            AimbotConnection:Disconnect()
            AimbotConnection = nil
         end
         CurrentTarget = nil
      end
   end,
})

local TriggerbotToggle = AimbotTab:CreateToggle({
   Name = "Triggerbot",
   CurrentValue = false,
   Flag = "Triggerbot Toggle",
   Callback = function(Value)
      TriggerbotEnabled = Value
      Rayfield:Notify({
         Title = "Triggerbot",
         Content = Value and "Triggerbot enabled!" or "Triggerbot disabled!",
         Duration = 2,
      })
   end,
})

local FOVSlider = AimbotTab:CreateSlider({
   Name = "FOV Size",
   Range = {50, 500},
   Increment = 10,
   Suffix = "FOV",
   CurrentValue = 150,
   Flag = "FOV Size",
   Callback = function(Value)
      FOV = Value
      UpdateFOVCircle()
   end,
})

AimbotTab:CreateInput({
   Name = "FOV Color (HEX)",
   CurrentValue = ColorStorage.FOVColor,
   PlaceholderText = "#FF0000",
   Flag = "FOV Color",
   Callback = function(Value)
      local success, color = pcall(HexToRGB, Value)
      if success then
         ColorStorage.FOVColor = Value
         SaveColors()
         FOVColor = color
         UpdateFOVCircle()
         Rayfield:Notify({Title = "Color Updated", Content = "FOV color changed to " .. Value, Duration = 2})
      else
         Rayfield:Notify({Title = "Invalid Color", Content = "Please enter a valid HEX color", Duration = 2})
      end
   end,
})

local AimPartDropdown = AimbotTab:CreateDropdown({
   Name = "Aim Part",
   Options = {"Head", "Torso"},
   CurrentOption = {"Head"},
   Flag = "Aim Part",
   Callback = function(Value)
      AimPart = Value[1]
   end,
})

local ScriptTab = Window:CreateTab("Scripts", 4483362458)
local ScriptSection = ScriptTab:CreateSection("Script Executor")

ScriptTab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
      local success, err = pcall(function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
      end)
      if success then
         Rayfield:Notify({
            Title = "Success",
            Content = "Infinite Yield loaded successfully!",
            Duration = 3,
         })
      else
         Rayfield:Notify({
            Title = "Error",
            Content = "Failed to load Infinite Yield: " .. tostring(err),
            Duration = 5,
         })
      end
   end,
})

ScriptTab:CreateButton({
   Name = "Simple Spy",
   Callback = function()
      local success, err = pcall(function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
      end)
      if success then
         Rayfield:Notify({
            Title = "Success",
            Content = "Simple Spy loaded successfully!",
            Duration = 3,
         })
      else
         Rayfield:Notify({
            Title = "Error",
            Content = "Failed to load Simple Spy: " .. tostring(err),
            Duration = 5,
         })
      end
   end,
})

ScriptTab:CreateButton({
   Name = "Cobalt",
   Callback = function()
      local success, err = pcall(function()
         loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau"))()
      end)
      if success then
         Rayfield:Notify({
            Title = "Success",
            Content = "Cobalt loaded successfully!",
            Duration = 3,
         })
      else
         Rayfield:Notify({
            Title = "Error",
            Content = "Failed to load Cobalt: " .. tostring(err),
            Duration = 5,
         })
      end
   end,
})

ScriptTab:CreateButton({
   Name = "Dex Explorer",
   Callback = function()
      local success, err = pcall(function()
         loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()
      end)
      if success then
         Rayfield:Notify({
            Title = "Success",
            Content = "Dex Explorer loaded successfully!",
            Duration = 3,
         })
      else
         Rayfield:Notify({
            Title = "Error",
            Content = "Failed to load Dex Explorer: " .. tostring(err),
            Duration = 5,
         })
      end
   end,
})

task.spawn(function()
   while task.wait(2) do UpdateAllPlayers() end
end)

Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
   if FOVCircle then
      FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
   end
end)

return Window
