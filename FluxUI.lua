local FluxLibrary = {}
FluxLibrary.__index = FluxLibrary

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local ExecutorName = "Unknown"
pcall(function()
    if getexecutorname then
        ExecutorName = getexecutorname()
    end
end)

local IsPC = ExecutorName == "Volt" or ExecutorName == "Potassium" or ExecutorName == "Wave"
    or ExecutorName == "Madium" or ExecutorName == "Real" or ExecutorName == "Isaeva"
    or ExecutorName == "Cosmic" or ExecutorName == "Velocity" or ExecutorName == "SirHurt"
    or ExecutorName == "Solara" or ExecutorName == "Xeno"

local IsMobileExecutor = ExecutorName == "Delta" or ExecutorName == "Codex"

local Themes = {
    Dark = {
        Background = Color3.fromRGB(20, 20, 26),
        Secondary = Color3.fromRGB(28, 28, 36),
        Tertiary = Color3.fromRGB(40, 40, 50),
        Accent = Color3.fromRGB(114, 137, 218),
        Text = Color3.fromRGB(240, 240, 245),
        SubText = Color3.fromRGB(150, 152, 165),
        Muted = Color3.fromRGB(95, 97, 110),
        Border = Color3.fromRGB(48, 48, 60),
        ToggleOff = Color3.fromRGB(58, 60, 72),
        ToggleOn = Color3.fromRGB(114, 137, 218),
        SliderTrack = Color3.fromRGB(46, 46, 56),
        ElementBg = Color3.fromRGB(32, 32, 40),
        ElementHover = Color3.fromRGB(40, 40, 50),
    },
    Midnight = {
        Background = Color3.fromRGB(10, 10, 18),
        Secondary = Color3.fromRGB(16, 16, 26),
        Tertiary = Color3.fromRGB(26, 26, 40),
        Accent = Color3.fromRGB(160, 100, 255),
        Text = Color3.fromRGB(238, 238, 248),
        SubText = Color3.fromRGB(145, 145, 175),
        Muted = Color3.fromRGB(90, 90, 120),
        Border = Color3.fromRGB(40, 40, 60),
        ToggleOff = Color3.fromRGB(48, 48, 72),
        ToggleOn = Color3.fromRGB(160, 100, 255),
        SliderTrack = Color3.fromRGB(30, 30, 48),
        ElementBg = Color3.fromRGB(20, 20, 32),
        ElementHover = Color3.fromRGB(28, 28, 42),
    },
    Ocean = {
        Background = Color3.fromRGB(12, 22, 34),
        Secondary = Color3.fromRGB(18, 32, 48),
        Tertiary = Color3.fromRGB(28, 46, 66),
        Accent = Color3.fromRGB(0, 200, 230),
        Text = Color3.fromRGB(228, 246, 250),
        SubText = Color3.fromRGB(140, 175, 195),
        Muted = Color3.fromRGB(90, 130, 155),
        Border = Color3.fromRGB(38, 60, 84),
        ToggleOff = Color3.fromRGB(42, 66, 94),
        ToggleOn = Color3.fromRGB(0, 200, 230),
        SliderTrack = Color3.fromRGB(30, 52, 78),
        ElementBg = Color3.fromRGB(18, 32, 48),
        ElementHover = Color3.fromRGB(26, 44, 64),
    },
    Rose = {
        Background = Color3.fromRGB(24, 14, 22),
        Secondary = Color3.fromRGB(36, 20, 32),
        Tertiary = Color3.fromRGB(50, 30, 46),
        Accent = Color3.fromRGB(255, 100, 150),
        Text = Color3.fromRGB(250, 238, 243),
        SubText = Color3.fromRGB(190, 150, 170),
        Muted = Color3.fromRGB(140, 100, 125),
        Border = Color3.fromRGB(66, 42, 60),
        ToggleOff = Color3.fromRGB(76, 48, 68),
        ToggleOn = Color3.fromRGB(255, 100, 150),
        SliderTrack = Color3.fromRGB(56, 36, 52),
        ElementBg = Color3.fromRGB(40, 24, 38),
        ElementHover = Color3.fromRGB(50, 30, 48),
    },
    Nordic = {
        Background = Color3.fromRGB(44, 50, 62),
        Secondary = Color3.fromRGB(57, 64, 80),
        Tertiary = Color3.fromRGB(74, 84, 104),
        Accent = Color3.fromRGB(136, 192, 208),
        Text = Color3.fromRGB(234, 237, 242),
        SubText = Color3.fromRGB(180, 190, 205),
        Muted = Color3.fromRGB(130, 140, 158),
        Border = Color3.fromRGB(64, 73, 91),
        ToggleOff = Color3.fromRGB(78, 88, 108),
        ToggleOn = Color3.fromRGB(136, 192, 208),
        SliderTrack = Color3.fromRGB(68, 78, 98),
        ElementBg = Color3.fromRGB(57, 64, 80),
        ElementHover = Color3.fromRGB(68, 76, 94),
    },
}

local Font = Enum.Font.Gotham
local FontMedium = Enum.Font.GothamMedium
local FontBold = Enum.Font.GothamBold
local FontSemibold = Enum.Font.GothamSemibold

local function create(class, props, children)
    local instance = Instance.new(class)
    for prop, value in pairs(props or {}) do
        instance[prop] = value
    end
    for _, child in ipairs(children or {}) do
        child.Parent = instance
    end
    return instance
end

local function corner(parent, radius)
    create("UICorner", { CornerRadius = UDim.new(0, radius or 8), Parent = parent })
end

local function stroke(parent, color, thickness, transparency)
    return create("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0.4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent
    })
end

local function padding(parent, top, bottom, left, right)
    create("UIPadding", {
        PaddingTop = UDim.new(0, top),
        PaddingBottom = UDim.new(0, bottom),
        PaddingLeft = UDim.new(0, left),
        PaddingRight = UDim.new(0, right),
        Parent = parent
    })
end

local function tween(instance, props, duration, style, direction)
    local info = TweenInfo.new(duration or 0.2, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out)
    local t = TweenService:Create(instance, info, props)
    t:Play()
    return t
end

local KeybindNames = {
    [Enum.KeyCode.RightShift] = "Right Shift",
    [Enum.KeyCode.LeftShift] = "Left Shift",
    [Enum.KeyCode.RightControl] = "Right Ctrl",
    [Enum.KeyCode.LeftControl] = "Left Ctrl",
    [Enum.KeyCode.RightAlt] = "Right Alt",
    [Enum.KeyCode.LeftAlt] = "Left Alt",
    [Enum.KeyCode.Insert] = "Insert",
    [Enum.KeyCode.Delete] = "Delete",
    [Enum.KeyCode.Home] = "Home",
    [Enum.KeyCode.End] = "End",
    [Enum.KeyCode.PageUp] = "Page Up",
    [Enum.KeyCode.PageDown] = "Page Down",
    [Enum.KeyCode.F1] = "F1",
    [Enum.KeyCode.F2] = "F2",
    [Enum.KeyCode.F3] = "F3",
    [Enum.KeyCode.F4] = "F4",
    [Enum.KeyCode.F5] = "F5",
    [Enum.KeyCode.F6] = "F6",
    [Enum.KeyCode.F7] = "F7",
    [Enum.KeyCode.F8] = "F8",
    [Enum.KeyCode.F9] = "F9",
    [Enum.KeyCode.F10] = "F10",
    [Enum.KeyCode.F11] = "F11",
    [Enum.KeyCode.F12] = "F12",
    [Enum.KeyCode.Tab] = "Tab",
    [Enum.KeyCode.CapsLock] = "Caps Lock",
    [Enum.KeyCode.Backquote] = "`",
}

local function getParent()
    if gethui then return gethui() end
    return CoreGui
end

local function createLoadingScreen(self, onComplete)
    local parent = getParent()

    self.LoadingGui = create("ScreenGui", {
        Name = self.Name .. "_Loading",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        DisplayOrder = 999,
        Parent = parent
    })

    if syn and syn.protect_gui then syn.protect_gui(self.LoadingGui) end

    local overlay = create("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = self.LoadingGui
    })

    local center = create("Frame", {
        Size = UDim2.fromOffset(260, 110),
        Position = UDim2.new(0.5, -130, 0.5, -55),
        BackgroundColor3 = self.Theme.Background,
        BorderSizePixel = 0,
        Parent = overlay
    })
    corner(center, 10)
    stroke(center, self.Theme.Border, 1, 0.3)

    local title = create("TextLabel", {
        Size = UDim2.new(1, -24, 0, 22),
        Position = UDim2.new(0, 12, 0, 14),
        BackgroundTransparency = 1,
        Text = self.Name,
        TextColor3 = self.Theme.Text,
        Font = FontBold,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = center
    })

    local subtitle = create("TextLabel", {
        Size = UDim2.new(1, -24, 0, 16),
        Position = UDim2.new(0, 12, 0, 38),
        BackgroundTransparency = 1,
        Text = "Loading",
        TextColor3 = self.Theme.SubText,
        Font = Font,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = center
    })

    local barBg = create("Frame", {
        Size = UDim2.new(1, -24, 0, 4),
        Position = UDim2.new(0, 12, 0, 80),
        BackgroundColor3 = self.Theme.Tertiary,
        BorderSizePixel = 0,
        Parent = center
    })
    corner(barBg, 2)

    local barFill = create("Frame", {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        Parent = barBg
    })
    corner(barFill, 2)

    tween(barFill, { Size = UDim2.new(1, 0, 1, 0) }, 2.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    task.spawn(function()
        task.wait(0.9)
        subtitle.Text = "Building UI"
        task.wait(0.9)
        subtitle.Text = "Applying themes"
        task.wait(0.9)
        subtitle.Text = "Ready"
        task.wait(0.3)

        tween(overlay, { BackgroundTransparency = 1 }, 0.35)
        tween(center, { BackgroundTransparency = 1 }, 0.35)
        tween(title, { TextTransparency = 1 }, 0.35)
        tween(subtitle, { TextTransparency = 1 }, 0.35)
        tween(barBg, { BackgroundTransparency = 1 }, 0.35)
        tween(barFill, { BackgroundTransparency = 1 }, 0.35)

        task.wait(0.4)
        if self.LoadingGui then
            self.LoadingGui:Destroy()
            self.LoadingGui = nil
        end

        if onComplete then
            onComplete()
        end
    end)
end

function FluxLibrary.new(config)
    config = config or {}
    local self = setmetatable({}, FluxLibrary)

    if IsMobileExecutor then
        self.IsMobile = true
        self.Scale = 0.85
    elseif IsPC then
        self.IsMobile = false
        self.Scale = 1
    else
        self.IsMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
        self.Scale = self.IsMobile and 0.85 or 1
    end

    self.Name = config.Name or (self.IsMobile and "Flux Mobile" or "Flux PC")
    self.ThemeName = config.Theme or "Dark"
    self.Theme = Themes[self.ThemeName]
    self.Tabs = {}
    self.ActiveTab = nil
    self.Connections = {}
    self.Elements = {}
    self.Flags = {}
    self.ToggleKey = config.ToggleKey or Enum.KeyCode.RightShift
    self.SettingsOpen = false
    self.KeybindListening = false
    self.SettingsData = {}
    self.SaveManager = nil

    self:_build()
    self:_bindInput()
    self:_createSettingsPanel()

    self.Main.Visible = false

    createLoadingScreen(self, function()
        if self.Main then
            self.Main.Visible = true
        end
    end)

    return self
end

function FluxLibrary:_build()
    local parent = getParent()

    self.Gui = create("ScreenGui", {
        Name = self.Name,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        Parent = parent
    })

    if syn and syn.protect_gui then syn.protect_gui(self.Gui) end

    local baseW, baseH = 660, 460
    local w = math.floor(baseW * self.Scale)
    local h = math.floor(baseH * self.Scale)

    self.Main = create("Frame", {
        Name = "Main",
        Size = UDim2.new(0, w, 0, h),
        Position = UDim2.new(0.5, -w/2, 0.5, -h/2),
        BackgroundColor3 = self.Theme.Background,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 1,
        Parent = self.Gui
    })
    corner(self.Main, 14)
    stroke(self.Main, self.Theme.Border, 1, 0.35)

    self.Sidebar = create("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, 180, 1, 0),
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = self.Main
    })
    corner(self.Sidebar, 14)

    create("Frame", {
        Size = UDim2.new(0, 14, 1, 0),
        Position = UDim2.new(1, -7, 0, 0),
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = self.Sidebar
    })

    self.TitleBar = create("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 56),
        BackgroundTransparency = 1,
        ZIndex = 3,
        Parent = self.Sidebar
    })

    self.TitleLabel = create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -60, 0, 20),
        Position = UDim2.new(0, 18, 0, 20),
        BackgroundTransparency = 1,
        Text = self.Name,
        TextColor3 = self.Theme.Text,
        Font = FontBold,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 3,
        Parent = self.TitleBar
    })

    self.SettingsBtn = create("TextButton", {
        Name = "SettingsBtn",
        Size = UDim2.fromOffset(26, 26),
        Position = UDim2.new(1, -36, 0, 18),
        BackgroundColor3 = self.Theme.Tertiary,
        BorderSizePixel = 0,
        Text = "≡",
        TextColor3 = self.Theme.SubText,
        Font = FontBold,
        TextSize = 15,
        AutoButtonColor = false,
        ZIndex = 3,
        Parent = self.TitleBar
    })
    corner(self.SettingsBtn, 6)

    self.SettingsBtn.MouseEnter:Connect(function()
        tween(self.SettingsBtn, { BackgroundColor3 = self.Theme.ElementHover }, 0.15)
    end)
    self.SettingsBtn.MouseLeave:Connect(function()
        tween(self.SettingsBtn, { BackgroundColor3 = self.Theme.Tertiary }, 0.15)
    end)

    create("Frame", {
        Name = "Divider",
        Size = UDim2.new(1, -28, 0, 1),
        Position = UDim2.new(0, 14, 0, 56),
        BackgroundColor3 = self.Theme.Border,
        BorderSizePixel = 0,
        BackgroundTransparency = 0.4,
        ZIndex = 2,
        Parent = self.Sidebar
    })

    self.TabHolder = create("ScrollingFrame", {
        Name = "TabHolder",
        Size = UDim2.new(1, -20, 1, -190),
        Position = UDim2.new(0, 10, 0, 68),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ZIndex = 2,
        Parent = self.Sidebar
    })

    create("UIListLayout", {
        Padding = UDim.new(0, 3),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = self.TabHolder
    })

    self.ThemeBtn = create("TextButton", {
        Name = "ThemeBtn",
        Size = UDim2.new(1, -20, 0, 34),
        Position = UDim2.new(0, 10, 1, -82),
        BackgroundColor3 = self.Theme.Tertiary,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 2,
        Parent = self.Sidebar
    })
    corner(self.ThemeBtn, 7)

    self.ThemeIcon = create("Frame", {
        Size = UDim2.fromOffset(8, 8),
        Position = UDim2.new(0, 14, 0.5, -4),
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = self.ThemeBtn
    })
    corner(self.ThemeIcon, 4)

    self.ThemeBtnLabel = create("TextLabel", {
        Size = UDim2.new(1, -32, 1, 0),
        Position = UDim2.new(0, 28, 0, 0),
        BackgroundTransparency = 1,
        Text = "Theme: " .. self.ThemeName,
        TextColor3 = self.Theme.Text,
        Font = FontMedium,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
        Parent = self.ThemeBtn
    })

    self.CloseBtn = create("TextButton", {
        Name = "CloseBtn",
        Size = UDim2.new(1, -20, 0, 34),
        Position = UDim2.new(0, 10, 1, -44),
        BackgroundColor3 = self.Theme.Tertiary,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 2,
        Parent = self.Sidebar
    })
    corner(self.CloseBtn, 7)

    self.CloseIcon = create("Frame", {
        Size = UDim2.fromOffset(8, 8),
        Position = UDim2.new(0, 14, 0.5, -4),
        BackgroundColor3 = Color3.fromRGB(235, 90, 90),
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = self.CloseBtn
    })
    corner(self.CloseIcon, 4)

    create("TextLabel", {
        Size = UDim2.new(1, -32, 1, 0),
        Position = UDim2.new(0, 28, 0, 0),
        BackgroundTransparency = 1,
        Text = "Close UI",
        TextColor3 = self.Theme.Text,
        Font = FontMedium,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
        Parent = self.CloseBtn
    })

    self.ThemeBtn.MouseButton1Click:Connect(function()
        self:CycleTheme()
    end)

    self.CloseBtn.MouseButton1Click:Connect(function()
        self:Toggle(false)
    end)

    self.ThemeBtn.MouseEnter:Connect(function()
        tween(self.ThemeBtn, { BackgroundColor3 = self.Theme.ElementHover }, 0.15)
    end)
    self.ThemeBtn.MouseLeave:Connect(function()
        tween(self.ThemeBtn, { BackgroundColor3 = self.Theme.Tertiary }, 0.15)
    end)

    self.CloseBtn.MouseEnter:Connect(function()
        tween(self.CloseBtn, { BackgroundColor3 = self.Theme.ElementHover }, 0.15)
    end)
    self.CloseBtn.MouseLeave:Connect(function()
        tween(self.CloseBtn, { BackgroundColor3 = self.Theme.Tertiary }, 0.15)
    end)

    self.Content = create("Frame", {
        Name = "Content",
        Size = UDim2.new(1, -180, 1, 0),
        Position = UDim2.new(0, 180, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = 2,
        Parent = self.Main
    })

    self.TopBar = create("Frame", {
        Name = "TopBar",
        Size = UDim2.new(1, -36, 0, 36),
        Position = UDim2.new(0, 18, 0, 18),
        BackgroundTransparency = 1,
        ZIndex = 2,
        Parent = self.Content
    })

    self.SearchBox = create("Frame", {
        Name = "SearchBox",
        Size = UDim2.new(0, 240, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = self.Theme.ElementBg,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = self.TopBar
    })
    corner(self.SearchBox, 7)
    stroke(self.SearchBox, self.Theme.Border, 1, 0.5)

    create("TextLabel", {
        Size = UDim2.fromOffset(16, 16),
        Position = UDim2.new(0, 12, 0.5, -8),
        BackgroundTransparency = 1,
        Text = "?",
        TextColor3 = self.Theme.SubText,
        Font = FontBold,
        TextSize = 12,
        ZIndex = 2,
        Parent = self.SearchBox
    })

    self.SearchInput = create("TextBox", {
        Size = UDim2.new(1, -42, 1, 0),
        Position = UDim2.new(0, 32, 0, 0),
        BackgroundTransparency = 1,
        PlaceholderText = "Search elements...",
        PlaceholderColor3 = self.Theme.Muted,
        Text = "",
        TextColor3 = self.Theme.Text,
        Font = Font,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        ZIndex = 2,
        Parent = self.SearchBox
    })

    self.TabTitle = create("TextLabel", {
        Name = "TabTitle",
        Size = UDim2.new(0, 220, 1, 0),
        Position = UDim2.new(1, -220, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = self.Theme.SubText,
        Font = FontMedium,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 2,
        Parent = self.TopBar
    })

    self.PageHolder = create("Frame", {
        Name = "PageHolder",
        Size = UDim2.new(1, -36, 1, -78),
        Position = UDim2.new(0, 18, 0, 64),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 2,
        Parent = self.Content
    })
end

function FluxLibrary:_createSettingsPanel()
    self.SettingsPanel = create("Frame", {
        Name = "SettingsPanel",
        Size = UDim2.new(0, 280, 0, 0),
        Position = UDim2.new(0, 10, 0, 64),
        BackgroundColor3 = self.Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Visible = false,
        ZIndex = 100,
        Parent = self.Main
    })
    corner(self.SettingsPanel, 10)
    stroke(self.SettingsPanel, self.Theme.Border, 1, 0.3)

    local header = create("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        ZIndex = 101,
        Parent = self.SettingsPanel
    })
    corner(header, 10)

    create("TextLabel", {
        Size = UDim2.new(1, -48, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Text = "Settings",
        TextColor3 = self.Theme.Text,
        Font = FontBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 101,
        Parent = header
    })

    local closeSettings = create("TextButton", {
        Size = UDim2.fromOffset(24, 24),
        Position = UDim2.new(1, -34, 0.5, -12),
        BackgroundColor3 = self.Theme.Tertiary,
        BorderSizePixel = 0,
        Text = "X",
        TextColor3 = self.Theme.SubText,
        Font = FontBold,
        TextSize = 11,
        AutoButtonColor = false,
        ZIndex = 102,
        Parent = header
    })
    corner(closeSettings, 5)

    closeSettings.MouseButton1Click:Connect(function()
        self:ToggleSettings(false)
    end)

    closeSettings.MouseEnter:Connect(function()
        tween(closeSettings, { BackgroundColor3 = Color3.fromRGB(235, 90, 90) }, 0.15)
        closeSettings.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    closeSettings.MouseLeave:Connect(function()
        tween(closeSettings, { BackgroundColor3 = self.Theme.Tertiary }, 0.15)
        closeSettings.TextColor3 = self.Theme.SubText
    end)

    local content = create("Frame", {
        Size = UDim2.new(1, -24, 0, 0),
        Position = UDim2.new(0, 12, 0, 50),
        BackgroundTransparency = 1,
        ZIndex = 101,
        Parent = self.SettingsPanel
    })

    create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 14),
        BackgroundTransparency = 1,
        Text = "TOGGLE KEYBIND",
        TextColor3 = self.Theme.Muted,
        Font = FontBold,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 101,
        Parent = content
    })

    local keybindBtn = create("TextButton", {
        Size = UDim2.new(1, 0, 0, 32),
        Position = UDim2.new(0, 0, 0, 20),
        BackgroundColor3 = self.Theme.Tertiary,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 101,
        Parent = content
    })
    corner(keybindBtn, 6)

    local keybindLabel = create("TextLabel", {
        Size = UDim2.new(1, -16, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = KeybindNames[self.ToggleKey] or self.ToggleKey.Name,
        TextColor3 = self.Theme.Text,
        Font = FontMedium,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 101,
        Parent = keybindBtn
    })

    local keybindHint = create("TextLabel", {
        Size = UDim2.new(0, 80, 1, 0),
        Position = UDim2.new(1, -88, 0, 0),
        BackgroundTransparency = 1,
        Text = "Click to set",
        TextColor3 = self.Theme.Muted,
        Font = Font,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 101,
        Parent = keybindBtn
    })

    keybindBtn.MouseButton1Click:Connect(function()
        self.KeybindListening = true
        keybindLabel.Text = "Press a key..."
        keybindLabel.TextColor3 = self.Theme.Accent
        keybindHint.Text = "ESC to cancel"
    end)

    keybindBtn.MouseEnter:Connect(function()
        if not self.KeybindListening then
            tween(keybindBtn, { BackgroundColor3 = self.Theme.ElementHover }, 0.15)
        end
    end)
    keybindBtn.MouseLeave:Connect(function()
        if not self.KeybindListening then
            tween(keybindBtn, { BackgroundColor3 = self.Theme.Tertiary }, 0.15)
        end
    end)

    create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 14),
        Position = UDim2.new(0, 0, 0, 64),
        BackgroundTransparency = 1,
        Text = "THEME",
        TextColor3 = self.Theme.Muted,
        Font = FontBold,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 101,
        Parent = content
    })

    local themeHolder = create("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 84),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 101,
        Parent = content
    })

    create("UIListLayout", {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = themeHolder
    })

    local themeNames = {}
    for name in pairs(Themes) do table.insert(themeNames, name) end
    table.sort(themeNames)

    for _, themeName in ipairs(themeNames) do
        local themeData = Themes[themeName]
        local isSelected = self.ThemeName == themeName
        local themeBtn = create("TextButton", {
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundColor3 = isSelected and self.Theme.Accent or self.Theme.Tertiary,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            ZIndex = 101,
            Parent = themeHolder
        })
        corner(themeBtn, 6)

        local dot = create("Frame", {
            Size = UDim2.fromOffset(10, 10),
            Position = UDim2.new(0, 12, 0.5, -5),
            BackgroundColor3 = themeData.Accent,
            BorderSizePixel = 0,
            ZIndex = 101,
            Parent = themeBtn
        })
        corner(dot, 5)

        create("TextLabel", {
            Size = UDim2.new(1, -44, 1, 0),
            Position = UDim2.new(0, 30, 0, 0),
            BackgroundTransparency = 1,
            Text = themeName,
            TextColor3 = isSelected and Color3.fromRGB(255, 255, 255) or self.Theme.Text,
            Font = FontMedium,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 101,
            Parent = themeBtn
        })

        if isSelected then
            create("TextLabel", {
                Size = UDim2.new(0, 20, 1, 0),
                Position = UDim2.new(1, -26, 0, 0),
                BackgroundTransparency = 1,
                Text = "+",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Font = FontBold,
                TextSize = 11,
                ZIndex = 101,
                Parent = themeBtn
            })
        end

        themeBtn.MouseButton1Click:Connect(function()
            self:SetTheme(themeName)
        end)

        themeBtn.MouseEnter:Connect(function()
            if self.ThemeName ~= themeName then
                tween(themeBtn, { BackgroundColor3 = self.Theme.ElementHover }, 0.15)
            end
        end)
        themeBtn.MouseLeave:Connect(function()
            if self.ThemeName ~= themeName then
                tween(themeBtn, { BackgroundColor3 = self.Theme.Tertiary }, 0.15)
            end
        end)
    end

    self.SettingsData.keybindBtn = keybindBtn
    self.SettingsData.keybindLabel = keybindLabel
    self.SettingsData.keybindHint = keybindHint
    self.SettingsData.themeHolder = themeHolder
    self.SettingsData.content = content
    self.SettingsData.header = header
    self.SettingsData.closeSettings = closeSettings

    self.SettingsBtn.MouseButton1Click:Connect(function()
        self:ToggleSettings(not self.SettingsOpen)
    end)
end

function FluxLibrary:ToggleSettings(state)
    self.SettingsOpen = state
    if state then
        self.SettingsPanel.Visible = true
        self.SettingsPanel.ZIndex = 100
        self.SettingsPanel.Size = UDim2.new(0, 280, 0, 0)
        local themeCount = 0
        for _ in pairs(Themes) do themeCount = themeCount + 1 end
        local targetHeight = 90 + themeCount * 34 + 40
        tween(self.SettingsPanel, { Size = UDim2.new(0, 280, 0, targetHeight) }, 0.25, Enum.EasingStyle.Quart)
        tween(self.SettingsBtn, { BackgroundColor3 = self.Theme.Accent }, 0.2)
    else
        tween(self.SettingsPanel, { Size = UDim2.new(0, 280, 0, 0) }, 0.2, Enum.EasingStyle.Quart)
        tween(self.SettingsBtn, { BackgroundColor3 = self.Theme.Tertiary }, 0.2)
        task.delay(0.25, function()
            if not self.SettingsOpen then
                self.SettingsPanel.Visible = false
            end
        end)
    end
end

function FluxLibrary:_bindInput()
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        self.Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    self.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    self.TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            update(input)
        end
    end)

    table.insert(self.Connections, UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end

        if self.KeybindListening then
            if input.KeyCode == Enum.KeyCode.Escape then
                self.KeybindListening = false
                self.SettingsData.keybindLabel.Text = KeybindNames[self.ToggleKey] or self.ToggleKey.Name
                self.SettingsData.keybindLabel.TextColor3 = self.Theme.Text
                self.SettingsData.keybindHint.Text = "Click to set"
            else
                self.ToggleKey = input.KeyCode
                self.KeybindListening = false
                self.SettingsData.keybindLabel.Text = KeybindNames[input.KeyCode] or input.KeyCode.Name
                self.SettingsData.keybindLabel.TextColor3 = self.Theme.Text
                self.SettingsData.keybindHint.Text = "Click to set"
            end
            return
        end

        if input.KeyCode == self.ToggleKey then
            self:Toggle(not self.Main.Visible)
        end
    end))
end

function FluxLibrary:Toggle(state)
    if state then
        self.Main.Visible = true
    else
        self.Main.Visible = false
        if self.SettingsOpen then
            self:ToggleSettings(false)
        end
    end
end

function FluxLibrary:CycleTheme()
    local names = {}
    for name in pairs(Themes) do table.insert(names, name) end
    table.sort(names)
    local idx = 1
    for i, name in ipairs(names) do
        if name == self.ThemeName then idx = i break end
    end
    idx = idx % #names + 1
    self:SetTheme(names[idx])
end

function FluxLibrary:SetTheme(name)
    if not Themes[name] then return end
    self.ThemeName = name
    self.Theme = Themes[name]
    local T = self.Theme

    tween(self.Main, { BackgroundColor3 = T.Background }, 0.25)
    tween(self.Sidebar, { BackgroundColor3 = T.Secondary }, 0.25)
    tween(self.ThemeBtn, { BackgroundColor3 = T.Tertiary }, 0.25)
    tween(self.CloseBtn, { BackgroundColor3 = T.Tertiary }, 0.25)
    tween(self.SearchBox, { BackgroundColor3 = T.ElementBg }, 0.25)
    tween(self.ThemeIcon, { BackgroundColor3 = T.Accent }, 0.25)
    tween(self.SettingsBtn, { BackgroundColor3 = self.SettingsOpen and T.Accent or T.Tertiary }, 0.25)
    tween(self.SettingsPanel, { BackgroundColor3 = T.Background }, 0.25)
    tween(self.SettingsData.header, { BackgroundColor3 = T.Secondary }, 0.25)

    if self.Main:FindFirstChild("UIStroke") then
        self.Main.UIStroke.Color = T.Border
    end
    if self.SearchBox:FindFirstChild("UIStroke") then
        self.SearchBox.UIStroke.Color = T.Border
    end
    if self.SettingsPanel:FindFirstChild("UIStroke") then
        self.SettingsPanel.UIStroke.Color = T.Border
    end

    self.ThemeBtnLabel.Text = "Theme: " .. name
    self.ThemeBtnLabel.TextColor3 = T.Text
    self.SearchInput.TextColor3 = T.Text
    self.SearchInput.PlaceholderColor3 = T.Muted
    self.TitleLabel.TextColor3 = T.Text
    self.TabTitle.TextColor3 = T.SubText

    local sd = self.SettingsData
    sd.keybindBtn.BackgroundColor3 = T.Tertiary
    sd.keybindLabel.TextColor3 = T.Text
    sd.keybindHint.TextColor3 = T.Muted
    sd.closeSettings.BackgroundColor3 = T.Tertiary
    sd.closeSettings.TextColor3 = T.SubText

    for _, btn in ipairs(sd.themeHolder:GetChildren()) do
        if btn:IsA("TextButton") then
            local themeName = nil
            for _, child in ipairs(btn:GetChildren()) do
                if child:IsA("TextLabel") and child.Text ~= "+" then
                    themeName = child.Text
                end
            end
            if themeName == self.ThemeName then
                btn.BackgroundColor3 = T.Accent
                for _, child in ipairs(btn:GetChildren()) do
                    if child:IsA("TextLabel") then
                        child.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end
            else
                btn.BackgroundColor3 = T.Tertiary
                for _, child in ipairs(btn:GetChildren()) do
                    if child:IsA("TextLabel") and child.Text ~= "+" then
                        child.TextColor3 = T.Text
                    end
                end
            end
        end
    end

    for _, child in ipairs(self.Sidebar:GetChildren()) do
        if child.Name == "Divider" and child:IsA("Frame") then
            child.BackgroundColor3 = T.Border
        end
    end

    for _, tab in ipairs(self.Tabs) do
        tab:_retheme(T)
    end

    for _, el in ipairs(self.Elements) do
        if el._retheme then el:_retheme(T) end
    end
end

function FluxLibrary:CreateTab(name)
    local tab = {}
    tab.Name = name
    tab.Library = self
    tab.Elements = {}
    tab.Theme = self.Theme

    tab.Button = create("TextButton", {
        Name = name .. "Tab",
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = self.Theme.Tertiary,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 2,
        Parent = self.TabHolder
    })
    corner(tab.Button, 7)

    tab.Icon = create("Frame", {
        Name = "Icon",
        Size = UDim2.fromOffset(6, 6),
        Position = UDim2.new(0, 14, 0.5, -3),
        BackgroundColor3 = self.Theme.Muted,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = tab.Button
    })
    corner(tab.Icon, 3)

    tab.Label = create("TextLabel", {
        Name = "TabLabel",
        Size = UDim2.new(1, -34, 1, 0),
        Position = UDim2.new(0, 28, 0, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = self.Theme.SubText,
        Font = FontMedium,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
        Parent = tab.Button
    })

    tab.Indicator = create("Frame", {
        Name = "Indicator",
        Size = UDim2.new(0, 3, 0, 0),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = tab.Button
    })
    corner(tab.Indicator, 2)

    tab.Page = create("ScrollingFrame", {
        Name = name .. "Page",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = self.Theme.Accent,
        ScrollBarImageTransparency = 0.5,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
        ZIndex = 2,
        Parent = self.PageHolder
    })

    create("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = tab.Page
    })

    padding(tab.Page, 4, 12, 4, 10)

    function tab:_retheme(T)
        tab.Theme = T
        tab.Button.BackgroundColor3 = T.Tertiary
        tab.Indicator.BackgroundColor3 = T.Accent
        tab.Page.ScrollBarImageColor3 = T.Accent
        tab.Label.TextColor3 = (tab.Library.ActiveTab == tab) and T.Text or T.SubText
        tab.Icon.BackgroundColor3 = (tab.Library.ActiveTab == tab) and T.Accent or T.Muted
        for _, el in ipairs(tab.Elements) do
            if el._retheme then el:_retheme(T) end
        end
    end

    function tab:Select()
        local lib = tab.Library
        lib.ActiveTab = tab
        lib.TabTitle.Text = tab.Name .. "  /  " .. #tab.Elements .. " elements"
        for _, t in ipairs(lib.Tabs) do
            local isActive = (t == tab)
            t.Page.Visible = isActive
            tween(t.Button, { BackgroundTransparency = isActive and 0 or 1 }, 0.2)
            if isActive then
                t.Button.BackgroundColor3 = t.Theme.Tertiary
            end
            tween(t.Indicator, { Size = UDim2.new(0, 3, isActive and 1 or 0, 0) }, 0.2)
            tween(t.Label, { TextColor3 = isActive and t.Theme.Text or t.Theme.SubText }, 0.2)
            tween(t.Icon, { BackgroundColor3 = isActive and t.Theme.Accent or t.Theme.Muted }, 0.2)
        end
    end

    tab.Button.MouseButton1Click:Connect(function()
        tab:Select()
    end)

    tab.Button.MouseEnter:Connect(function()
        if self.ActiveTab ~= tab then
            tween(tab.Button, { BackgroundTransparency = 0.5 }, 0.15)
        end
    end)

    tab.Button.MouseLeave:Connect(function()
        if self.ActiveTab ~= tab then
            tween(tab.Button, { BackgroundTransparency = 1 }, 0.15)
        end
    end)

    table.insert(self.Tabs, tab)

    if #self.Tabs == 1 then
        tab:Select()
    else
        self.TabTitle.Text = self.ActiveTab.Name .. "  /  " .. #self.ActiveTab.Elements .. " elements"
    end

    return tab
end

local function createElementBase(tab, height)
    local el = {}
    el.Theme = tab.Theme
    el.Tab = tab

    el.Container = create("Frame", {
        Size = UDim2.new(1, 0, 0, height),
        BackgroundColor3 = tab.Theme.ElementBg,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = tab.Page
    })
    corner(el.Container, 8)
    stroke(el.Container, tab.Theme.Border, 1, 0.6)

    table.insert(tab.Elements, el)
    table.insert(tab.Library.Elements, el)

    return el
end

local function registerFlag(library, flag, element)
    if flag and flag ~= "" then
        library.Flags[flag] = element
    end
end

function FluxLibrary:_createSlider(tab, config)
    local el = createElementBase(tab, 62)
    el.Value = config.Default or config.CurrentValue or 0
    el.Min = config.Min or 0
    el.Max = config.Max or 100
    el.Callback = config.Callback or function() end
    el.Suffix = config.Suffix or ""
    el.Dragging = false
    el.Name = config.Name or "Slider"
    el.Flag = config.Flag
    el.Type = "Slider"

    registerFlag(self, el.Flag, el)

    padding(el.Container, 12, 12, 16, 16)

    el.Label = create("TextLabel", {
        Size = UDim2.new(1, -110, 0, 16),
        BackgroundTransparency = 1,
        Text = el.Name,
        TextColor3 = tab.Theme.Text,
        Font = FontSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
        Parent = el.Container
    })

    el.ValueLabel = create("TextLabel", {
        Size = UDim2.new(0, 110, 0, 16),
        Position = UDim2.new(1, -110, 0, 0),
        BackgroundTransparency = 1,
        Text = tostring(el.Value) .. el.Suffix,
        TextColor3 = tab.Theme.SubText,
        Font = FontMedium,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 2,
        Parent = el.Container
    })

    el.Track = create("Frame", {
        Size = UDim2.new(1, 0, 0, 5),
        Position = UDim2.new(0, 0, 0, 36),
        BackgroundColor3 = tab.Theme.SliderTrack,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = el.Container
    })
    corner(el.Track, 3)

    el.Fill = create("Frame", {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = tab.Theme.Accent,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = el.Track
    })
    corner(el.Fill, 3)

    el.Knob = create("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = el.Track
    })
    corner(el.Knob, 7)
    stroke(el.Knob, tab.Theme.Accent, 2, 0)

    local function updateFromX(x)
        local rel = math.clamp((x - el.Track.AbsolutePosition.X) / el.Track.AbsoluteSize.X, 0, 1)
        local val = el.Min + (el.Max - el.Min) * rel
        if el.Max - el.Min <= 1 then
            val = math.floor(val * 100 + 0.5) / 100
        else
            val = math.floor(val + 0.5)
        end
        el:SetValue(val)
    end

    function el:SetValue(val, silent)
        val = math.clamp(val, self.Min, self.Max)
        self.Value = val
        local alpha = (val - self.Min) / (self.Max - self.Min)
        tween(self.Fill, { Size = UDim2.new(alpha, 0, 1, 0) }, 0.08)
        tween(self.Knob, { Position = UDim2.new(alpha, 0, 0.5, 0) }, 0.08)
        self.ValueLabel.Text = tostring(val) .. self.Suffix
        if not silent then
            self.Callback(val)
        end
    end

    el.Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            el.Dragging = true
            updateFromX(input.Position.X)
        end
    end)

    table.insert(tab.Library.Connections, UserInputService.InputChanged:Connect(function(input)
        if el.Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromX(input.Position.X)
        end
    end))

    table.insert(tab.Library.Connections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            el.Dragging = false
        end
    end))

    function el:_retheme(T)
        el.Theme = T
        el.Container.BackgroundColor3 = T.ElementBg
        el.Label.TextColor3 = T.Text
        el.ValueLabel.TextColor3 = T.SubText
        el.Track.BackgroundColor3 = T.SliderTrack
        el.Fill.BackgroundColor3 = T.Accent
        el.Knob.UIStroke.Color = T.Accent
        if el.Container:FindFirstChild("UIStroke") then
            el.Container.UIStroke.Color = T.Border
        end
    end

    task.defer(function()
        el:SetValue(el.Value, true)
    end)

    return el
end

function FluxLibrary:_createButton(tab, config)
    local el = createElementBase(tab, 40)
    el.Callback = config.Callback or function() end
    el.Name = config.Name or "Button"
    el.Flag = config.Flag
    el.Type = "Button"

    registerFlag(self, el.Flag, el)

    el.Button = create("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 3,
        Parent = el.Container
    })

    el.Label = create("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = el.Name,
        TextColor3 = tab.Theme.Text,
        Font = FontSemibold,
        TextSize = 12,
        ZIndex = 3,
        Parent = el.Button
    })

    el.Button.MouseButton1Click:Connect(function()
        el.Callback()
    end)

    el.Button.MouseEnter:Connect(function()
        tween(el.Container, { BackgroundColor3 = tab.Theme.Accent }, 0.15)
        tween(el.Label, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.15)
    end)

    el.Button.MouseLeave:Connect(function()
        tween(el.Container, { BackgroundColor3 = tab.Theme.ElementBg }, 0.15)
        tween(el.Label, { TextColor3 = tab.Theme.Text }, 0.15)
    end)

    function el:_retheme(T)
        el.Theme = T
        el.Container.BackgroundColor3 = T.ElementBg
        el.Label.TextColor3 = T.Text
        if el.Container:FindFirstChild("UIStroke") then
            el.Container.UIStroke.Color = T.Border
        end
    end

    return el
end

function FluxLibrary:_createToggle(tab, config)
    local el = createElementBase(tab, 44)
    el.Value = config.Default ~= nil and config.Default or (config.CurrentValue ~= nil and config.CurrentValue or false)
    el.Callback = config.Callback or function() end
    el.Name = config.Name or "Toggle"
    el.Flag = config.Flag
    el.Type = "Toggle"

    registerFlag(self, el.Flag, el)

    el.Label = create("TextLabel", {
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Text = el.Name,
        TextColor3 = tab.Theme.Text,
        Font = FontSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
        Parent = el.Container
    })

    el.Switch = create("Frame", {
        Size = UDim2.new(0, 38, 0, 21),
        Position = UDim2.new(1, -54, 0.5, -10.5),
        BackgroundColor3 = el.Value and tab.Theme.ToggleOn or tab.Theme.ToggleOff,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = el.Container
    })
    corner(el.Switch, 10)

    el.Knob = create("Frame", {
        Size = UDim2.new(0, 17, 0, 17),
        Position = el.Value and UDim2.new(1, -19, 0.5, -8.5) or UDim2.new(0, 2, 0.5, -8.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = el.Switch
    })
    corner(el.Knob, 8)

    el.ClickArea = create("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 3,
        Parent = el.Container
    })

    function el:SetValue(val, silent)
        self.Value = val
        tween(self.Switch, { BackgroundColor3 = val and self.Theme.ToggleOn or self.Theme.ToggleOff }, 0.18)
        tween(self.Knob, {
            Position = val and UDim2.new(1, -19, 0.5, -8.5) or UDim2.new(0, 2, 0.5, -8.5)
        }, 0.18)
        if not silent then
            self.Callback(val)
        end
    end

    el.ClickArea.MouseButton1Click:Connect(function()
        el:SetValue(not el.Value)
    end)

    el.ClickArea.MouseEnter:Connect(function()
        if not el.Value then
            tween(el.Switch, { BackgroundColor3 = el.Theme.ToggleOff:Lerp(el.Theme.Accent, 0.25) }, 0.15)
        end
    end)

    el.ClickArea.MouseLeave:Connect(function()
        if not el.Value then
            tween(el.Switch, { BackgroundColor3 = el.Theme.ToggleOff }, 0.15)
        end
    end)

    function el:_retheme(T)
        el.Theme = T
        el.Container.BackgroundColor3 = T.ElementBg
        el.Label.TextColor3 = T.Text
        el.Switch.BackgroundColor3 = el.Value and T.ToggleOn or T.ToggleOff
        if el.Container:FindFirstChild("UIStroke") then
            el.Container.UIStroke.Color = T.Border
        end
    end

    return el
end

function FluxLibrary:_createTextBox(tab, config)
    local el = createElementBase(tab, 62)
    el.Value = config.Default or config.CurrentValue or ""
    el.Callback = config.Callback or function() end
    el.Name = config.Name or "Input"
    el.Placeholder = config.Placeholder or "Type here..."
    el.Flag = config.Flag
    el.Type = "TextBox"

    registerFlag(self, el.Flag, el)

    el.Label = create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 16),
        Position = UDim2.new(0, 16, 0, 10),
        BackgroundTransparency = 1,
        Text = el.Name,
        TextColor3 = tab.Theme.Text,
        Font = FontSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
        Parent = el.Container
    })

    el.Box = create("Frame", {
        Size = UDim2.new(1, -32, 0, 24),
        Position = UDim2.new(0, 16, 0, 30),
        BackgroundColor3 = tab.Theme.Secondary,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = el.Container
    })
    corner(el.Box, 6)

    el.Input = create("TextBox", {
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = el.Value,
        PlaceholderText = el.Placeholder,
        PlaceholderColor3 = tab.Theme.Muted,
        TextColor3 = tab.Theme.Text,
        Font = Font,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        ZIndex = 3,
        Parent = el.Box
    })

    el.Input.FocusLost:Connect(function()
        el.Value = el.Input.Text
        el.Callback(el.Value)
    end)

    function el:SetValue(val, silent)
        self.Value = val
        self.Input.Text = val
        if not silent then
            self.Callback(val)
        end
    end

    function el:_retheme(T)
        el.Theme = T
        el.Container.BackgroundColor3 = T.ElementBg
        el.Label.TextColor3 = T.Text
        el.Box.BackgroundColor3 = T.Secondary
        el.Input.TextColor3 = T.Text
        el.Input.PlaceholderColor3 = T.Muted
        if el.Container:FindFirstChild("UIStroke") then
            el.Container.UIStroke.Color = T.Border
        end
    end

    return el
end

function FluxLibrary:_createLabel(tab, config)
    local el = createElementBase(tab, config.Height or 28)
    el.Container.BackgroundTransparency = 1
    el.Container.UIStroke.Transparency = 1
    el.Name = config.Text or "Label"
    el.Type = "Label"

    el.Label = create("TextLabel", {
        Size = UDim2.new(1, -24, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = config.Text or "Label",
        TextColor3 = tab.Theme.Text,
        Font = config.Bold and FontBold or Font,
        TextSize = config.Size or 12,
        TextXAlignment = config.Align or Enum.TextXAlignment.Left,
        TextWrapped = true,
        ZIndex = 2,
        Parent = el.Container
    })

    function el:SetValue(val)
        el.Label.Text = val
    end

    function el:_retheme(T)
        el.Label.TextColor3 = T.Text
    end

    return el
end

function FluxLibrary:_createSection(tab, config)
    local el = createElementBase(tab, 26)
    el.Container.BackgroundTransparency = 1
    el.Container.UIStroke.Transparency = 1
    el.Name = config.Name or "Section"
    el.Type = "Section"

    el.Label = create("TextLabel", {
        Size = UDim2.new(1, -24, 1, 0),
        Position = UDim2.new(0, 6, 0, 0),
        BackgroundTransparency = 1,
        Text = string.upper(config.Name or "Section"),
        TextColor3 = tab.Theme.Muted,
        Font = FontBold,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
        Parent = el.Container
    })

    function el:_retheme(T)
        el.Label.TextColor3 = T.Muted
    end

    return el
end

function FluxLibrary:_createDivider(tab)
    local el = createElementBase(tab, 6)
    el.Container.BackgroundTransparency = 1
    el.Container.UIStroke.Transparency = 1
    el.Name = "Divider"
    el.Type = "Divider"

    local line = create("Frame", {
        Size = UDim2.new(1, -24, 0, 1),
        Position = UDim2.new(0, 12, 0.5, 0),
        BackgroundColor3 = tab.Theme.Border,
        BorderSizePixel = 0,
        BackgroundTransparency = 0.3,
        ZIndex = 2,
        Parent = el.Container
    })

    function el:_retheme(T)
        line.BackgroundColor3 = T.Border
    end

    return el
end

function FluxLibrary:_createKeybind(tab, config)
    local el = createElementBase(tab, 44)
    el.Value = config.Default or config.CurrentValue or Enum.KeyCode.E
    el.Callback = config.Callback or function() end
    el.Name = config.Name or "Keybind"
    el.Flag = config.Flag
    el.Type = "Keybind"
    el.Listening = false

    registerFlag(self, el.Flag, el)

    el.Label = create("TextLabel", {
        Size = UDim2.new(1, -110, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Text = el.Name,
        TextColor3 = tab.Theme.Text,
        Font = FontSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
        Parent = el.Container
    })

    el.Btn = create("TextButton", {
        Size = UDim2.new(0, 90, 0, 26),
        Position = UDim2.new(1, -106, 0.5, -13),
        BackgroundColor3 = tab.Theme.Tertiary,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 3,
        Parent = el.Container
    })
    corner(el.Btn, 6)

    el.BtnLabel = create("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = KeybindNames[el.Value] or el.Value.Name,
        TextColor3 = tab.Theme.Text,
        Font = FontMedium,
        TextSize = 11,
        ZIndex = 3,
        Parent = el.Btn
    })

    el.Btn.MouseButton1Click:Connect(function()
        el.Listening = true
        el.BtnLabel.Text = "Press..."
        el.BtnLabel.TextColor3 = el.Theme.Accent
    end)

    table.insert(tab.Library.Connections, UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if el.Listening then
            if input.KeyCode == Enum.KeyCode.Escape then
                el.Listening = false
                el.BtnLabel.Text = KeybindNames[el.Value] or el.Value.Name
                el.BtnLabel.TextColor3 = el.Theme.Text
            else
                el.Value = input.KeyCode
                el.Listening = false
                el.BtnLabel.Text = KeybindNames[input.KeyCode] or input.KeyCode.Name
                el.BtnLabel.TextColor3 = el.Theme.Text
                el.Callback(input.KeyCode)
            end
        elseif input.KeyCode == el.Value then
            el.Callback(input.KeyCode)
        end
    end))

    function el:SetValue(val, silent)
        self.Value = val
        self.BtnLabel.Text = KeybindNames[val] or val.Name
        if not silent then
            self.Callback(val)
        end
    end

    function el:_retheme(T)
        el.Theme = T
        el.Container.BackgroundColor3 = T.ElementBg
        el.Label.TextColor3 = T.Text
        el.Btn.BackgroundColor3 = T.Tertiary
        el.BtnLabel.TextColor3 = T.Text
        if el.Container:FindFirstChild("UIStroke") then
            el.Container.UIStroke.Color = T.Border
        end
    end

    return el
end

function FluxLibrary:GetFlag(flag)
    return self.Flags[flag]
end

function FluxLibrary:SetFlagValue(flag, value)
    local el = self.Flags[flag]
    if el and el.SetValue then
        el:SetValue(value)
    end
end

function FluxLibrary:GetFlags()
    local data = {}
    for flag, el in pairs(self.Flags) do
        if el.Value ~= nil then
            data[flag] = el.Value
        end
    end
    return data
end

function FluxLibrary:LoadFlags(data)
    if type(data) ~= "table" then return end
    for flag, value in pairs(data) do
        local el = self.Flags[flag]
        if el and el.SetValue then
            el:SetValue(value, true)
        end
    end
end

function FluxLibrary:CreateSaveManager(options)
    options = options or {}
    local saveManager = {}
    saveManager.Folder = options.Folder or "FluxUI"
    saveManager.FileName = options.FileName or "config"
    saveManager.Library = self

    local httpRequest = (syn and syn.request) or (http and http.request) or http_request or request
    local writeFile = writefile
    local readFile = readfile
    local isFile = isfile
    local makeFolder = makefolder

    function saveManager:Save()
        if not writeFile then return end
        local data = self.Library:GetFlags()
        local encoded = game:GetService("HttpService"):JSONEncode(data)
        if makeFolder and not (isFile and isFile(self.Folder)) then
            pcall(makeFolder, self.Folder)
        end
        pcall(writeFile, self.Folder .. "/" .. self.FileName .. ".json", encoded)
    end

    function saveManager:Load()
        if not readFile then return end
        local path = self.Folder .. "/" .. self.FileName .. ".json"
        if isFile and not isFile(path) then return end
        local ok, content = pcall(readFile, path)
        if ok and content then
            local success, data = pcall(function()
                return game:GetService("HttpService"):JSONDecode(content)
            end)
            if success then
                self.Library:LoadFlags(data)
            end
        end
    end

    self.SaveManager = saveManager
    return saveManager
end

function FluxLibrary:Destroy()
    for _, conn in ipairs(self.Connections) do
        pcall(function() conn:Disconnect() end)
    end
    if self.Gui then
        self.Gui:Destroy()
    end
    if self.LoadingGui then
        self.LoadingGui:Destroy()
    end
end

function FluxLibrary:CreateTabElement(tab)
    return {
        CreateButton = function(_, config) return self:_createButton(tab, config) end,
        CreateToggle = function(_, config) return self:_createToggle(tab, config) end,
        CreateSlider = function(_, config) return self:_createSlider(tab, config) end,
        CreateTextBox = function(_, config) return self:_createTextBox(tab, config) end,
        CreateLabel = function(_, config) return self:_createLabel(tab, config) end,
        CreateSection = function(_, config) return self:_createSection(tab, config) end,
        CreateDivider = function(_) return self:_createDivider(tab) end,
        CreateKeybind = function(_, config) return self:_createKeybind(tab, config) end,
    }
end

local function attachTabMethods(tab, library)
    function tab:CreateButton(config)
        return library:_createButton(tab, config or {})
    end

    function tab:CreateToggle(config)
        return library:_createToggle(tab, config or {})
    end

    function tab:CreateSlider(config)
        return library:_createSlider(tab, config or {})
    end

    function tab:CreateTextBox(config)
        return library:_createTextBox(tab, config or {})
    end

    function tab:CreateLabel(config)
        return library:_createLabel(tab, config or {})
    end

    function tab:CreateSection(config)
        return library:_createSection(tab, config or {})
    end

    function tab:CreateDivider()
        return library:_createDivider(tab)
    end

    function tab:CreateKeybind(config)
        return library:_createKeybind(tab, config or {})
    end
end

local originalCreateTab = FluxLibrary.CreateTab
function FluxLibrary:CreateTab(name)
    local tab = originalCreateTab(self, name)
    attachTabMethods(tab, self)
    return tab
end

local function buildLibrary()
    local lib = FluxLibrary.new({
        Theme = "Dark",
        ToggleKey = Enum.KeyCode.RightShift
    })
    return lib
end

return {
    new = function(config) return FluxLibrary.new(config or {}) end,
    Library = FluxLibrary,
    Themes = Themes,
    Default = buildLibrary,
}
