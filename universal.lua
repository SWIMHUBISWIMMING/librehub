--!native
--!optimize 2

-- FABRICATED VALUES!!!
if not LPH_OBFUSCATED then
	LPH_JIT = function(...)
		return ...;
	end;
	LPH_JIT_MAX = function(...)
		return ...;
	end;
	LPH_NO_VIRTUALIZE = function(...)
		return ...;
	end;
	LPH_NO_UPVALUES = function(f)
		return (function(...)
			return f(...);
		end);
	end;
	LPH_ENCSTR = function(...)
		return ...;
	end;
	LPH_ENCNUM = function(...)
		return ...;
	end;
	LPH_ENCFUNC = function(func, key1, key2)
		if key1 ~= key2 then return print("LPH_ENCFUNC mismatch") end
		return func
	end
	LPH_CRASH = function()
		return print(debug.traceback());
	end;
	SWG_DiscordUser = "swim"
	SWG_DiscordID = 1337
	SWG_SecondsLeft = 9999
	SWG_Note = "scp,alpha"
	SWG_IsLifetime = true
end;


if (getgenv and getgenv() or _G).Library then
	(getgenv and getgenv() or _G).Library.Unload()
end

do -- fuckass adonis bypass :heart:
	for _, v in getgc(true) do
		if type(v) == "table" then
			local namecallInstance = rawget(v, "namecallInstance")
			-- god forgive me
			if not (namecallInstance and type(namecallInstance) == "table" and type(namecallInstance[1]) == "string" and type(namecallInstance[2]) == "function") then
				continue
			end

			setreadonly(v, false)
			for caller, tbl in v do
				v[caller] = {"kick", function(...) return coroutine.yield() end}
			end
		end
	end
end

local Folder = "moneyblox"
makefolder(Folder)

local ImagesFolder = string.format( "%s\\%s\\", Folder, "Images" )
makefolder(ImagesFolder)

local FontsFolder = string.format( "%s\\%s\\", Folder, "FontsFolder" )
makefolder(FontsFolder)
delfolder(FontsFolder) -- we do a little trolling
makefolder(FontsFolder)

local ConfigFolder = string.format( "%s\\%s\\", Folder, "Configs" )
makefolder(ConfigFolder)

local ThemeFolder = string.format( "%s\\%s\\", Folder, "Themes" )
makefolder(ThemeFolder)

local Fonts, Images = LPH_JIT(function()
	local RunService = game:GetService("RunService")
	local HttpService = game:GetService("HttpService")

	local Fonts = {
		URL = "https://raw.githubusercontent.com/SWIMHUBISWIMMING/librehub/refs/heads/main/assets/",

		Names = {
			"Tahoma",
			"TahomaXP",
			"Comfortaa",
			"Verdana",
			"SmallestPixel7",
			"Proggy",
		},

		Data = {}
	}; do
		function Fonts.Load(font)
			if not RunService:IsStudio() then
				local TTF = string.format("%s%s.ttf", FontsFolder, font)
				local JSON = string.format("%s%s.json", FontsFolder, font)

				if not isfile(TTF) then
					local success, data = pcall(function()
						return game:HttpGet( string.format("%s%s.txt", Fonts.URL, font) )
					end)

					if success and data then
						writefile(TTF, base64_decode(data))
					else
						return
					end			
				end

				if not isfile(JSON) then
					local Font = {
						name = font,
						faces = {{
							name = "Regular",
							weight = 400,
							style = "normal",
							assetId = getcustomasset(TTF)
						}}
					}

					writefile(JSON, HttpService:JSONEncode(Font))
				end

				Fonts.Data[font] = Font.new(getcustomasset(JSON), Enum.FontWeight.Regular)
			end
		end

		function Fonts.Get(font)
			return Fonts.Data[font]
		end

		for _,font in Fonts.Names do
			Fonts.Load(font)
		end
	end

	local Images = {
		URL = "https://raw.githubusercontent.com/SWIMHUBISWIMMING/librehub/refs/heads/main/assets/",

		Names = {
			"combat",
			"visuals",
			"misc",
			"config",
			"checkers",
			"saturation",
			"scrollbar",
			"lines"
		},

		Data = {}
	}; do
		function Images.Load(image)
			if not RunService:IsStudio() then
				local PNG = string.format("%s%s.png", ImagesFolder, image)

				if not isfile(PNG) then
					local success, data = pcall(function()
						return game:HttpGet( string.format( "%s%s.txt", Images.URL, image ) )
					end)

					if success and data then
						writefile(PNG, base64_decode(data))
					else
						return
					end
				end

				Images.Data[image] = getcustomasset(PNG)
			end
		end

		function Images.Get(image)
			return Images.Data[image]
		end

		for _,image in Images.Names do
			Images.Load(image)
		end
	end
	return Fonts, Images
end)();
local Library, Utility = LPH_JIT(function()
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local HttpService = game:GetService("HttpService")
	local GuiService = game:GetService("GuiService")
	local TweenService = game:GetService("TweenService")
	local Stats = game:GetService("Stats")
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local Camera = workspace.CurrentCamera

	local Env = RunService:IsStudio() and _G or getgenv()
	local HiddenUI = RunService:IsStudio() and game.Players.LocalPlayer.PlayerGui --[[or gethui and gethui()]] or game:GetService("CoreGui")
	local Converts = {
		[0] = "0",
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
	}
	local KeyConverters = {
		escape = "ESC",
		backquote = "`",
		backspace = "BSP",
		slash = "/",
		leftquote = "'",
		rightquote = '"',
		leftbracket = "[",
		rightbracket = "]",
		semicolon = ";",
		comma = ",",
		period = ".",
		backslash = "\\",
		minus = "-",
		equals = "=",
		space = "SPC",
		[ "return" ] = "ENT",
		tab = "TAB",
		capslock = "CAP",
		leftshift = "LSH",
		mousebutton1 = "MB1",
		mousebutton2 = "MB2",
		mousebutton3 = "MB3",
		rightshift = "RSH",
		leftcontrol = "CTRL",
		leftalt = "ALT",
		leftsuper = "WIN",
		rightcontrol = "CTRL",
		rightalt = "ALT",
		rightsuper = "WIN",
		insert = "INS",
		delete = "DEL",
		home = "HME",
		pageup = "PUD",
		pagedown = "PDN",
		up = "UP",
		down = "DWN",
		left = "LFT",
		right = "RGT",
		numlock = "NUM",
		numpad0 = "N0",
		numpad1 = "N1",
		numpad2 = "N2",
		numpad3 = "N3",
		numpad4 = "N4",
		numpad5 = "N5",
		numpad6 = "N6",
		numpad7 = "N7",
		numpad8 = "N8",
		numpad9 = "N9",
	}
	local Library = {
		TweenSpeed = 0.4,
		TweenStyle = Enum.EasingStyle.Exponential,

		ThemeObjects = {},

		Font = Fonts.Get("Verdana"),
		FontSize = 16,

		Flags = {},
		ConfigFlags = {},

		Popups = {},

		CopiedColor = nil,

		Fps = 0,

		Images = {
			Lines = Images.Get("lines"),
			ScrollBar = Images.Get("scrollbar"),
			Saturation = Images.Get("saturation"),
			Checkers = Images.Get("checkers")
		},

		Theme = {
			outline = Color3.fromRGB(0, 0, 0),
			inline = Color3.fromRGB(40, 42, 44),
			["inline hovering"] = Color3.fromRGB(50, 52, 54),

			background = Color3.fromRGB(23, 25, 26),
			["dock background"] = Color3.fromRGB(19, 19, 19),

			accent = Color3.fromRGB(220, 100, 100),

			text = Color3.fromRGB(230, 230, 230),
			["dark text"] = Color3.fromRGB(86, 86, 86),
		},

	}; Library.__index = Library
	do
		Library.Utility = { Objects = {}, Connections = {} }; local Utility = Library.Utility do
			function Utility.New(object, props, theme)
				local Obj = Instance.new(object)

				if object == "TextButton" then
					Obj.AutoButtonColor = false
					Obj.Text = ""
					Obj.Style = Enum.ButtonStyle.Custom
				end

				if props then
					for prop, val in props do
						--if prop ~= "Color" and prop:lower():find("color") then continue end
						--if prop == "FontFace" then Obj.Font = val continue end

						Obj[prop] = val
					end
				end

				if theme then
					Library.AddObjectTheme(Obj, theme)
				end

				table.insert(Utility.Objects, Obj)

				return Obj
			end

			function Utility.Signal(connection)
				table.insert(Utility.Connections, connection)

				return connection
			end

			function Utility.GetTransparency(obj)
				if obj:IsA("Frame") then
					return "BackgroundTransparency"
				elseif obj:IsA("TextLabel") or obj:IsA("TextButton") then
					return { "TextTransparency", "BackgroundTransparency" }
				elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
					return { "BackgroundTransparency", "ImageTransparency" }
				elseif obj:IsA("ScrollingFrame") then
					return { "BackgroundTransparency", "ScrollBarImageTransparency" }
				elseif obj:IsA("TextBox") then
					return { "TextTransparency", "BackgroundTransparency" }
				elseif obj:IsA("UIStroke") then
					return "Transparency"
				end

				return nil
			end

			function Utility.Round(number, float)
				local Mult = 1 / (float or 1)

				return math.floor(number * Mult + 0.5) / Mult
			end

			-- taken from dev forums.
			function Utility.PositionOver(position, object, addedy)
				addedy = addedy or 0

				local posX, posY = object.AbsolutePosition.X, (object.AbsolutePosition.Y - addedy)
				local size = object.AbsoluteSize
				local sizeX, sizeY = posX + size.X, posY + size.Y + addedy

				if position.X >= posX and position.Y >= posY and position.X <= sizeX and position.Y <= sizeY then
					return true
				end

				return false
			end

			function Utility.MouseOver(object, input)
				local posX, posY = object.AbsolutePosition.X, object.AbsolutePosition.Y
				local size = object.AbsoluteSize
				local sizeX, sizeY = posX + size.X, posY + size.Y
				local position = input.Position

				if position.X >= posX and position.Y >= posY and position.X <= sizeX and position.Y <= sizeY then
					return true
				end

				return false
			end

			function Utility.Lerp(a, b, c)
				c = c or 1 / 8

				local offset = math.abs(b - a)
				if (offset < c) then 
					return b 
				end 

				return a + (b - a) * c
			end

			function Utility.StringToEnum(enumstring)
				local EnumType, EnumValue = enumstring:match("Enum%.([^%.]+)%.(.+)")

				if EnumType and EnumValue then
					return Enum[EnumType][EnumValue]
				end

				return nil
			end

			function Utility.TextTriggers(text)
				local Triggers = {
					["{hour}"] = os.date("%H"),
					["{minute}"] = os.date("%M"),
					["{second}"] = os.date("%S"),
					["{ap}"] = os.date("%p"),
					["{month}"] = os.date("%b"),
					["{day}"] = os.date("%d"),
					["{year}"] = os.date("%Y"),
					["{fps}"] = Library.Fps,
					["{user}"] = SWG_DiscordUser or "admin",
					["{ping}"] = RunService:IsStudio() and 0 or math.floor(Stats.PerformanceStats.Ping:GetValue() or 0),
					["{time}"] = os.date("%H:%M:%S"),
					["{date}"] = os.date("%b. %d, %Y"),
					["{game}"] = Game and Game.Name or "Universal",
					["{n}"] = "\n"
				}

				for i,v in Triggers do
					text = string.gsub(text, i, v)
				end

				return text
			end

			function Utility.ToTitleCase(str)
				return str:gsub("(%a)([%w_']*)", function(first, rest)
					return first:upper() .. rest:lower()
				end)
			end

			function Utility.IsScrollable(frame)
				local CanvasSize = frame.AbsoluteCanvasSize
				local WindowSize = frame.AbsoluteWindowSize

				return CanvasSize.Y > WindowSize.Y
			end

			function Utility.IsAtBottom(frame)
				return frame.CanvasPosition.Y == frame.AbsoluteCanvasSize.Y - frame.AbsoluteWindowSize.Y
			end

			function Utility.RichText(text, color)
				return string.format('<font color="rgb(%s, %s, %s)">%s</font>', math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255), text)
			end

			function Utility.GetFiles(folder, extensions)
				if not isfolder(folder) then
					makefolder(folder)
				end

				local Files = isfolder(folder) and listfiles(folder) or {}
				local StoredFiles = {}
				local FileNames = {}

				for _,v in Files do
					for _,ext in extensions do
						if v:find(ext) then
							StoredFiles[#StoredFiles + 1] = v
							FileNames[#FileNames + 1] = v:gsub(folder, ""):gsub(ext, "")
						end
					end
				end

				return StoredFiles, FileNames
			end
		end

		Library.ScreenGui = Utility.New("ScreenGui", {
			Name = "\0",
			DisplayOrder = 1,
			Parent = HiddenUI,
			IgnoreGuiInset = true,
		})

		Library.ScreenGuiPopups = Utility.New("ScreenGui", {
			Name = "\0",
			DisplayOrder = -1,
			Parent = HiddenUI,
			IgnoreGuiInset = true,
		})

		local ItemsHolder = Utility.New("Frame", {
			Name = "leftholder",
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			Position = UDim2.new(0, 0, 0, 60),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Parent = Library.ScreenGuiPopups,
		})

		Utility.New("UIListLayout", {
			Padding = UDim.new(0, 0),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = ItemsHolder
		})

		Library.NotificationHolder = ItemsHolder

		function Library.Tween(obj, props, tweeninfo)
			tweeninfo = tweeninfo or TweenInfo.new(Library.TweenSpeed, Library.TweenStyle)

			local Tween = TweenService:Create(obj, tweeninfo, props)

			Tween:Play()

			return Tween
		end

		function Library.Fade(obj, prop, vis)
			if not ((obj:IsA("UIStroke") and obj.Enabled or obj.Visible) and prop) then
				return
			end

			local OldTransparency = obj[prop]
			obj[prop] = vis and 1 or OldTransparency

			local Tween = Library.Tween(obj, { [prop] = vis and OldTransparency or 1 })

			Utility.Signal(Tween.Completed:Connect(function()
				if not vis then
					task.wait()
					obj[prop] = OldTransparency
				end
			end))

			return Tween
		end

		function Library.AddObjectTheme(object, props)
			local Theme = {
				Props = props,
				Object = object
			}

			for prop,v in props do
				if type(v) == "string" then
					object[prop] = Library.Theme[v]
				elseif type(v) == "function" then
					object[prop] = v()
				end
			end

			Library.ThemeObjects[object] = Theme
		end

		function Library.ChangeObjectTheme(object, props, tweened)
			local Theme = Library.ThemeObjects[object]

			if Theme then
				Theme.Props = props

				for prop,v in props do
					if type(v) == "string" then
						if tweened then
							Theme.Tween = Library.Tween(object, {
								[prop] = Library.Theme[v]
							})
						else
							object[prop] = Library.Theme[v]
						end
					elseif type(v) == "function" then
						object[prop] = v()
					end
				end
			end
		end

		function Library.UpdateTheme(theme, color)
			if not Library.Theme[theme] then
				return
			end

			Library.Theme[theme] = color

			for _,themeobj in Library.ThemeObjects do
				for prop,val in themeobj.Props do
					if val == theme then
						if themeobj.Tween then
							themeobj.Tween:Cancel()
						end

						themeobj.Object[prop] = color
					end
				end
			end
		end

		function Library.Config(cfg, default)
			local Table = { }

			for name, val in cfg do
				Table[name:lower()] = val
			end

			for name, val in default do
				if Table[name] == nil then
					Table[name] = val
				end
			end

			return Table
		end

		function Library.Resize(holder, box)
			local Start, StartSize, Resizing;
			local CurrentSize = holder.Size
			local OriginalSize = holder.Size

			Utility.Signal(box.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Resizing = true
					Start = input.Position
					StartSize = holder.Size
				end
			end))

			Utility.Signal(UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and Resizing then
					local ViewportSize = Camera.ViewportSize
					CurrentSize = UDim2.new(0, math.clamp(StartSize.X.Offset + (input.Position.X - Start.X), OriginalSize.X.Offset, ViewportSize.x), 0, math.clamp(StartSize.Y.Offset + (input.Position.Y - Start.Y), OriginalSize.Y.Offset, ViewportSize.y))
					holder.Size = CurrentSize
				end
			end))

			Utility.Signal(UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Resizing = false
				end
			end))
		end

		function Library.Dragging(holder, box, useinset)
			useinset = useinset == nil and true or useinset

			local Start, StartPos, Dragging;
			local CurrentPos;
			local Inset = GuiService:GetGuiInset( );

			Utility.Signal(box.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Dragging = true
					Start = input.Position
					StartPos = holder.AbsolutePosition
				end
			end))

			Utility.Signal(UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
					local MaxSize = holder.AbsoluteSize
					local ViewportSize = Camera.ViewportSize
					CurrentPos = UDim2.new(0, math.clamp(StartPos.X + (input.Position.X - Start.X), 0, ViewportSize.x - MaxSize.x), 0, math.clamp(StartPos.Y + (input.Position.Y - Start.Y + 36), 0, ViewportSize.y - MaxSize.y) + ( useinset and (Inset.Y / 2) or 0 ))
					holder.Position = CurrentPos
				end
			end))

			Utility.Signal(UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Dragging = false
				end
			end))
		end

		function Library.CreateList(cfg)
			cfg = cfg or {}; cfg = Library.Config(cfg, {
				namestart = "Key",
				nameend = "binds",
				size = 150,
			})

			local List = {
				Objects = { },

				Items = { },

				ShowMode = cfg.showmode,
			}

			local Objects = List.Objects; do
				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					Position = UDim2.new(0, 20, 0.5, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, cfg.size, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Library.ScreenGuiPopups,
				}, { BackgroundColor3 = "accent" })

				Library.Dragging(Objects.accent, Objects.accent, true)

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.accent,
				}, { BackgroundColor3 = "background" })

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.background,
				})

				Objects.dock_background = Utility.New("Frame", {
					Name = "dock_background",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 23),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(19, 19, 19),
					Parent = Objects.background,
				}, { BackgroundColor3 = "dock background" })

				Objects.textholder = Utility.New("Frame", {
					Name = "textholder",
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 1, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.dock_background,
				})

				Utility.New("UIPadding", {
					PaddingRight = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6),
					Parent = Objects.textholder,
				})

				Utility.New("UIListLayout", {
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.textholder,
				})

				Objects.text = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.namestart,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "text",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.textholder,
				}, { TextColor3 = "text" })

				Objects.text2 = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(220, 100, 100),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.nameend,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "accent",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.textholder,
				}, { TextColor3 = "accent" })

				Objects.content = Utility.New("Frame", {
					Name = "content",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Utility.New("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.content,
					Padding = UDim.new(0, 0),
				})
			end

			function List.Add()
				local Item = {}

				local Holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					Visible = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.content,
				})

				Utility.New("UIPadding", {
					Parent = Holder,
					PaddingBottom = UDim.new(0, 8),
				})

				local Text = Utility.New("TextLabel", {
					FontFace = Fonts.Get("TahomaXP"),
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					Name = "text",
					TextStrokeTransparency = 0,
					Size = UDim2.new(1, -16, 0, 0),
					Position = UDim2.new(0, 8, 0, 0),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Holder,
				}, { TextColor3 = "text" })

				Utility.New("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					Parent = Text,
				})

				local Accent = Utility.New("TextLabel", {
					FontFace = Fonts.Get("TahomaXP"),
					TextColor3 = Color3.fromRGB(220, 100, 100),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = "[]",
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "accent",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Text,
				}, { TextColor3 = "accent" })

				function Item.Set(value, text, mode)
					Holder.Visible = value
					Text.Text = text
					Accent.Text = string.format("[%s]", mode)
				end

				table.insert(List.Items, Item)

				return Item
			end

			function List.Status(value)
				Objects.accent.Visible = value
			end

			return List
		end

		local KeybindList = Library.CreateList()
		Library.KeybindsList = KeybindList

		-- Element

		function Library.ColorpickerWindow(self)
			local Popup = {
				Visible = false,

				Tweening = false,

				Objects = { },

				Flag = nil,

				SetFunc = function() end,

				Alpha = 1,

				Color = Color3.new(1, 1, 1),

				HuePos = nil,
			}

			local Objects = Popup.Objects; do
				Objects.accent = Utility.New("Frame", {
					Size = UDim2.new(0, 200, 0, 200),
					Name = "accent",
					Position = UDim2.new(0, 0, 0, 0),
					Visible = false,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Library.ScreenGui,
				}, { BackgroundColor3 = "accent" })

				Objects.outline = Utility.New("Frame", {
					Name = "outline",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Objects.accent,
				}, { BackgroundColor3 = "outline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.outline,
				}, { BackgroundColor3 = "background" })

				Utility.New("UIPadding", {
					PaddingTop = UDim.new(0, 6),
					PaddingBottom = UDim.new(0, 6),
					PaddingRight = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6),
					Parent = Objects.background,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.background,
				})

				Objects.satholder = Utility.New("Frame", {
					Name = "satholder",
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 0, 186),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 6),
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Horizontal,
					Parent = Objects.satholder,
				})

				Objects.saturation = Utility.New("TextButton", {
					Name = "saturation",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 186, 0, 186),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 0, 4),
					Parent = Objects.satholder,
				})

				Objects.saturationimage = Utility.New("ImageLabel", {
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Image = Library.Images.Saturation,
					BackgroundTransparency = 1,
					Name = "saturationimage",
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.saturation,
				})

				Objects.saturationpickeroutline = Utility.New("Frame", {
					Name = "saturationpickeroutline",
					Position = UDim2.new(0, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 3, 0, 3),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Objects.saturationimage,
				})

				Objects.saturationpicker = Utility.New("Frame", {
					Name = "saturationpicker",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.saturationpickeroutline,
				})

				Objects.hue = Utility.New("TextButton", {
					Name = "hue",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 12, 0, 186),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.satholder,
				})

				Objects.huepickeroutline = Utility.New("Frame", {
					Name = "huepickeroutline",
					Position = UDim2.new(0, 0, 0.5, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 3),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Objects.hue,
				})

				Objects.huepicker = Utility.New("Frame", {
					Name = "huepicker",
					Position = UDim2.new(0, 0, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.huepickeroutline,
				})

				Utility.New("UIGradient", {
					Rotation = -90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
						ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 0, 255)),
						ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 0, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
						ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 255, 0)),
						ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 255, 0)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
					},
					Parent = Objects.hue,
				})

				Objects.alphaimage = Utility.New("ImageLabel", {
					ScaleType = Enum.ScaleType.Tile,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Name = "alphaimage",
					Image = Library.Images.Checkers,
					TileSize = UDim2.new(0, 6, 0, 6),
					Position = UDim2.new(0, 1, 0, 1),
					Size = UDim2.new(0, 186, 0, 12),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Objects.alpha = Utility.New("TextButton", {
					Name = "alpha",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.alphaimage,
				})

				Objects.UIGradient = Utility.New("UIGradient", {
					Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(1, 0)
					},
					Parent = Objects.alpha,
				})

				Objects.alphapickeroutline = Utility.New("Frame", {
					Name = "alphapickeroutline",
					Position = UDim2.new(0.5, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 3, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Objects.alpha,
				})

				Objects.alphapicker = Utility.New("Frame", {
					Name = "alphapicker",
					Position = UDim2.new(0, 1, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.alphapickeroutline,
				})

				Objects.buttonline = Utility.New("Frame", {
					Name = "buttonline",
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 186, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Utility.New("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = UDim.new(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.buttonline,
				})

				Library.Button({
					holder = Objects.buttonline,
				}, {Name = "Copy", Callback = function()
					Library.CopiedColor = Popup.Color
				end})

				Library.Button({
					holder = Objects.buttonline,
				}, {Name = "Paste", Callback = function()
					if not Library.CopiedColor then 
						Library.Notification("Please copy a color first.", 5)
						return 
					end

					Popup.Set(Library.CopiedColor, Popup.Alpha, false)
				end})
			end

			local Hue, Sat, Val;
			function Popup.Set(color, alpha, ignore)
				alpha = alpha or Popup.Alpha

				Hue, Sat, Val = color:ToHSV()

				Popup.Color = color
				Popup.Alpha = alpha

				if not ignore then
					Library.Tween(Objects.saturationpickeroutline, {
						Position = UDim2.new(
							Sat,
							0,
							1 - Val,
							0
						),
						AnchorPoint = Vector2.new(Sat, 1 - Val)
					})

					Popup.HuePos = Hue

					Library.Tween(Objects.huepickeroutline, {
						Position = UDim2.new(
							0,
							0,
							Hue,
							0
						),
						AnchorPoint = Vector2.new(0, Hue)
					})

					Library.Tween(Objects.alphapickeroutline, {
						Position = UDim2.new(
							1 - alpha,
							0,
							0,
							0
						),
						AnchorPoint = Vector2.new(1 - alpha, 0)
					})
				end

				Popup.SetFunc(color, alpha)

				Objects.huepicker.BackgroundColor3 = Color3.fromHSV(Popup.HuePos, 1, 1)
				Objects.saturationpicker.BackgroundColor3 = color
				Objects.alphapicker.BackgroundColor3 = color
				Objects.saturation.BackgroundColor3 = Color3.fromHSV(Popup.HuePos, 1, 1)
			end

			function Popup.Open(visibility, position)
				if Popup.Tweening or Popup.Visible == visibility then
					return
				end

				Popup.Tweening = true

				Popup.Visible = visibility

				if Popup.Visible then
					Objects.accent.Visible = true

					Objects.saturationpickeroutline.Position = UDim2.new(0, 0, 0, 0)
					Objects.alphapickeroutline.Position = UDim2.new(0, 0, 0, 0)
					Objects.huepickeroutline.Position = UDim2.new(0, 0, 0, 0)
				end

				local ParentObjects = Objects.accent:GetDescendants()

				table.insert(ParentObjects, Objects.accent)

				local Tween;
				for _, obj in ParentObjects do
					local Index = Utility.GetTransparency(obj)
					if not Index then continue end

					if type(Index) == "table" then
						for _, prop in Index do
							Tween = Library.Fade(obj, prop, Popup.Visible)
						end
					else
						Tween = Library.Fade(obj, Index, Popup.Visible)
					end
				end

				if not Popup.Visible then
					Library.Tween(Objects.saturationpickeroutline, {
						Position = UDim2.new(
							0,
							0,
							0,
							0
						),
						AnchorPoint = Vector2.new(0, 0)
					})

					Library.Tween(Objects.huepickeroutline, {
						Position = UDim2.new(
							0,
							0,
							0,
							0
						),
						AnchorPoint = Vector2.new(0, 0)
					})

					Library.Tween(Objects.alphapickeroutline, {
						Position = UDim2.new(
							0,
							0,
							0,
							0
						),
						AnchorPoint = Vector2.new(0, 0)
					})
				end

				if position then
					Objects.accent.Position = UDim2.new(0, position.X, 0, position.Y)
				end

				Utility.Signal(Tween.Completed:Connect(function()
					Objects.accent.Visible = Popup.Visible

					Popup.Tweening = false
				end))
			end

			function Popup.SlideSaturation(input)
				if Popup.Tweening or not Popup.Visible then return end

				local SizeX = math.clamp((input.Position.X - Objects.saturation.AbsolutePosition.X) / Objects.saturation.AbsoluteSize.X, 0, 1)
				local SizeY = 1 - math.clamp((input.Position.Y - Objects.saturation.AbsolutePosition.Y) / Objects.saturation.AbsoluteSize.Y, 0, 1)

				Objects.saturationpickeroutline.Position = UDim2.new(SizeX, 0, 1 - SizeY, 0)
				Objects.saturationpickeroutline.AnchorPoint = Vector2.new(SizeX, 1 - SizeY)

				Popup.Set(Color3.fromHSV(Popup.HuePos, SizeX, SizeY), Popup.Alpha, true)
			end

			Utility.Signal(Objects.saturation.MouseButton1Down:Connect(function()
				Popup.SlidingSaturation = true
				Popup.SlideSaturation({ Position = UserInputService:GetMouseLocation() - Vector2.new(0, GuiService:GetGuiInset( ).Y) })
			end))

			function Popup.SlideHue(input)
				if Popup.Tweening or not Popup.Visible then return end

				local SizeY = math.clamp((input.Position.Y - Objects.hue.AbsolutePosition.Y) / Objects.hue.AbsoluteSize.Y, 0, 1)

				Objects.huepickeroutline.Position = UDim2.new(0, 0, SizeY, 0)
				Objects.huepickeroutline.AnchorPoint = Vector2.new(0, SizeY)
				Popup.HuePos = SizeY

				Popup.Set(Color3.fromHSV(SizeY, Sat, Val), Popup.Alpha, true)
			end

			Utility.Signal(Objects.hue.MouseButton1Down:Connect(function()
				Popup.SlidingHue = true
				Popup.SlideHue({ Position = UserInputService:GetMouseLocation() - Vector2.new(0, GuiService:GetGuiInset( ).Y) })
			end))

			function Popup.SlideAlpha(input)
				if Popup.Tweening or not Popup.Visible then return end

				local SizeX = math.clamp((input.Position.X - Objects.alpha.AbsolutePosition.X) / Objects.alpha.AbsoluteSize.X, 0, 1)

				Objects.alphapickeroutline.Position = UDim2.new(SizeX, 0, 0, 0)
				Objects.alphapickeroutline.AnchorPoint = Vector2.new(SizeX, 0)
				Popup.Set(Popup.Color, 1 - SizeX, true)
			end

			Utility.Signal(Objects.alpha.MouseButton1Down:Connect(function()
				Popup.SlidingAlpha = true
				Popup.SlideAlpha({ Position = UserInputService:GetMouseLocation() })
			end))

			Utility.Signal(UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					if Popup.SlidingSaturation then Popup.SlideSaturation({ Position = UserInputService:GetMouseLocation() - Vector2.new(0, GuiService:GetGuiInset( ).Y) }) end
					if Popup.SlidingHue then Popup.SlideHue({ Position = UserInputService:GetMouseLocation() - Vector2.new(0, GuiService:GetGuiInset( ).Y) }) end
					if Popup.SlidingAlpha then Popup.SlideAlpha({ Position = UserInputService:GetMouseLocation() }) end
				end
			end))

			Utility.Signal(UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Popup.SlidingSaturation, Popup.SlidingHue, Popup.SlidingAlpha = false, false, false
				end
			end))

			return Popup
		end

		function Library.Window(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				size = UDim2.fromOffset(602, 502),
				open = true,
				namestart = "swim",
				nameend = "hub",
			})

			local Window = {
				Objects = { },

				Visible = cfg.open,

				Tweening = false,

				TabsTweening = false,

				Tabs = { },

				CurrentPage = nil,
			}

			local Objects = Window.Objects; do
				Objects.ScreenGui = Utility.New("ScreenGui", {
					Name = "\0",
					Parent = HiddenUI,
					IgnoreGuiInset = true,
				})

				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					Position = UDim2.new(0.5, -cfg.size.X.Offset / 2, 0.5, -cfg.size.Y.Offset / 2),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = cfg.size,
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Objects.ScreenGui,
				}, { BackgroundColor3 = "accent" })

				Objects.outline = Utility.New("Frame", {
					Name = "outline",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Objects.accent,
				}, { BackgroundColor3 = "outline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.outline,
				}, { BackgroundColor3 = "background" })

				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 44),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -14, 1, -58),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Objects.dock_background = Utility.New("Frame", {
					Name = "dock_background",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 30),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(19, 19, 19),
					Parent = Objects.background,
				}, { BackgroundColor3 = "dock background" })

				Library.Dragging(Objects.accent, Objects.dock_background, true)

				Objects.textholder = Utility.New("Frame", {
					Name = "textholder",
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 1, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.dock_background,
				})

				Utility.New("UIPadding", {
					PaddingRight = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6),
					Parent = Objects.textholder,
				})

				Utility.New("UIListLayout", {
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.textholder,
				})

				Objects.text = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.namestart,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "text",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.textholder,
				}, { TextColor3 = "text" })

				Objects.text2 = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(220, 100, 100),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.nameend,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "accent",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.textholder,
				}, { TextColor3 = "accent" })

				Objects.shadow = Utility.New("Frame", {
					Name = "shadow",
					Position = UDim2.new(0, 0, 1, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 8),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(16, 16, 16),
					Parent = Objects.dock_background,
				})

				Utility.New("UIGradient", {
					Rotation = 90,
					Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 0),
						NumberSequenceKeypoint.new(1, 1)
					},
					Parent = Objects.shadow,
				})

				Objects.tabsholder = Utility.New("Frame", {
					BackgroundTransparency = 1,
					Name = "tabsholder",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 105, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				Utility.New("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalFlex = Enum.UIFlexAlignment.Fill,
					Parent = Objects.tabsholder,
				})

				Window.tabsholder = Objects.tabsholder

				Window.pageholder = Objects.holder
			end

			function Window.Open()
				if Window.Tweening then
					return
				end

				Window.Tweening = true

				Library.ColorpickerWindow.Open(false)

				Window.Visible = not Window.Visible

				if Window.Visible then
					Objects.accent.Visible = true
				end

				for _,popup in Library.Popups do
					popup.Open(false)
				end

				local Tween;
				for _,obj in Objects.ScreenGui:GetDescendants() do
					local Index = Utility.GetTransparency(obj)

					if not Index then continue end

					if type(Index) == "table" then
						for _,prop in Index do
							Tween = Library.Fade(obj, prop, Window.Visible)
						end
					else
						Tween = Library.Fade(obj, Index, Window.Visible)
					end
				end

				Utility.Signal(Tween.Completed:Connect(function()
					Window.Tweening = false
					Objects.accent.Visible = Window.Visible
				end))
			end

			return setmetatable(Window, Library)
		end

		function Library.Tab(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "Tab",
				image = "rbxassetid://12941020168",
				size = 45,
				side = false,
			})

			local Tab = {
				Selected = false,

				Objects = { },

				Name = cfg.name,

				Tabs = {}
			}

			local Objects = Tab.Objects; do
				Objects.holder = Utility.New("TextButton", {
					BackgroundTransparency = 1,
					Name = "holder",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 105, 0, 88),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.tabsholder,
				})

				Objects.icon = Utility.New("ImageLabel", {
					ImageColor3 = Color3.fromRGB(215, 215, 215),
					ScaleType = Enum.ScaleType.Fit,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Name = "icon",
					AnchorPoint = Vector2.new(0.5, 0.5),
					Image = cfg.image,
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, -2, 0.5, 0),
					Size = UDim2.new(0, cfg.size, 0, cfg.size),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				}, { ImageColor3 = "text" })

				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					Position = UDim2.new(1, -2, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 2, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Objects.holder,
				}, { BackgroundColor3 = "accent" })

				Objects.pagetabsholder = Utility.New("Frame", {
					Name = "pagetabsholder",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 115, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -115, 0, 32),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.pageholder,
				})

				Utility.New("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Parent = Objects.pagetabsholder,
				})

				Tab.pagetabsholder = Objects.pagetabsholder

				Objects.page = Utility.New("Frame", {
					Name = "page",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 115, 0, 42),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -115, 1, -42),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.pageholder,
				})

				Tab.pageholder = Objects.page
			end

			function Tab.Set(status, nested)
				Library.ChangeObjectTheme(Objects.accent, {
					BackgroundColor3 = status and "accent" or "inline",
				}, true)

				Library.ChangeObjectTheme(Objects.icon, {
					ImageColor3 = status and "text" or "dark text",
				}, true)

				Objects.pagetabsholder.Parent = status and self.pageholder or HiddenUI
				Objects.page.Parent = status and self.pageholder or HiddenUI

				Tab.Selected = status

				if not nested then
					for _,tab in self.Tabs do
						if tab == Tab then continue end

						tab.Set(false, true)
					end
				end
			end

			Utility.Signal(Objects.holder.MouseButton1Click:Connect(function()
				Tab.Set(true)
			end))

			table.insert(self.Tabs, Tab)

			return setmetatable(Tab, Library)
		end

		function Library.SubTab(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "Tab",
			})

			local Tab = {
				Selected = false,

				Objects = { },
			}

			local Objects = Tab.Objects; do
				Objects.holder = Utility.New("TextButton", {
					BackgroundTransparency = 1,
					Name = "holder",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.pagetabsholder,
				})

				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					Position = UDim2.new(0, 0, 1, -2),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Objects.holder,
				}, { BackgroundColor3 = "accent" })

				Objects.text = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.name,
					TextStrokeTransparency = 0,
					Name = "text",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 18),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.holder,
				}, { TextColor3 = "text" })  

				Objects.page = Utility.New("Frame", {
					Name = "page",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.pageholder,
				})

				Utility.New("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.page,
				})

				Objects.left = Utility.New("Frame", {
					BackgroundTransparency = 1,
					Name = "left",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.page,
				})

				Tab.left = Objects.left

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.left,
				})

				Objects.right = Utility.New("Frame", {
					BackgroundTransparency = 1,
					Name = "right",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.page,
				})

				Tab.right = Objects.right

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.right,
				})
			end

			function Tab.Set(status, nested)
				Library.ChangeObjectTheme(Objects.accent, {
					BackgroundColor3 = status and "accent" or "inline",
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = status and "text" or "dark text",
				}, true)

				Tab.Selected = status

				Objects.page.Parent = status and self.pageholder or HiddenUI

				if not nested then
					for _,tab in self.Tabs do
						if tab == Tab then continue end

						tab.Set(false, true)
					end
				end
			end

			Utility.Signal(Objects.holder.MouseButton1Click:Connect(function()
				Tab.Set(true)
			end))

			table.insert(self.Tabs, Tab)

			return setmetatable(Tab, Library)
		end

		function Library.Section(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "Section",
				tabs = false,
				side = "left",
				size = UDim2.new(1, 0, 1, 0)
			})

			local Side = cfg.side:lower() == "left" and self.left or self.right

			local Section = {
				Objects = {},

				Tabs = {},
			}

			local Objects = Section.Objects; do
				Objects.outline = Utility.New("Frame", {
					Name = "outline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = cfg.size,
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Side,
				}, { BackgroundColor3 = "outline" })

				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Objects.outline,
				}, { BackgroundColor3 = "accent" })

				Objects.outline = Utility.New("Frame", {
					Name = "outline",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Objects.accent,
				}, { BackgroundColor3 = "outline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.outline,
				}, { BackgroundColor3 = "background" })

				Objects.dock_background = Utility.New("Frame", {
					Name = "dock_background",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 28),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(19, 19, 19),
					Parent = Objects.background,
				}, { BackgroundColor3 = "dock background" })

				Objects.shadow = Utility.New("Frame", {
					Name = "shadow",
					Position = UDim2.new(0, 0, 1, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 8),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(16, 16, 16),
					Parent = Objects.dock_background,
				})

				Utility.New("UIGradient", {
					Rotation = 90,
					Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 0),
						NumberSequenceKeypoint.new(1, 1)
					},
					Parent = Objects.shadow,
				})

				Objects.text = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.name,
					TextStrokeTransparency = 0,
					Name = "text",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, -2),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.dock_background,
				}, { TextColor3 = "text" })

				Objects.accent = Utility.New("ScrollingFrame", {
					Active = true,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					ScrollBarImageColor3 = Color3.fromRGB(220, 100, 100),
					MidImage = Library.Images.ScrollBar,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					ScrollBarThickness = 1,
					Name = "accent",
					Size = UDim2.new(1, -12, 1, -28),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 12, 0, 28),
					BottomImage = Library.Images.ScrollBar,
					TopImage = Library.Images.ScrollBar,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				}, { ScrollBarImageColor3 = "accent" })

				Objects.content = Utility.New("Frame", {
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Name = "content",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 12),
					Size = UDim2.new(1, -12, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.accent,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 9),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.content,
				})

				Utility.New("UIPadding", {
					Parent = Objects.accent,
					PaddingBottom = UDim.new(0, 4),
				})

				Section.holder = Objects.content
			end

			function Section.State(value)
				Objects.outline.Visible = value
			end

			return setmetatable(Section, Library)
		end

		function Library.Toggle(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "New Toggle",
				value = false,
				callback = function() end,
				flag = nil,
			})



			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local Toggle = {
				Objects = { },

				Tweening = false,

				Value = false,
			}

			local Objects = Toggle.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.holder,
				})

				Objects.line = Utility.New("TextButton", {
					Name = "line",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 17, 0, 17),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Objects.line,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Objects.background,
				}, { BackgroundColor3 = "accent" })

				Objects.text = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.name,
					TextStrokeTransparency = 0,
					Name = "text",
					Size = UDim2.new(1, -25, 1, -3),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.new(0, 25, 0, 0),
					BorderSizePixel = 0,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.line,
				}, { TextColor3 = "text" })

				Utility.New("UIListLayout", {
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					Padding = UDim.new(0, 2),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.text,
				})

				Toggle.childholder = Objects.text
			end

			function Toggle.Set(value)
				Toggle.Value = value

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = value and "text" or "dark text"
				}, true)

				Library.Tween(Objects.accent, {
					BackgroundTransparency = value and 0 or 1
				})

				cfg.callback(value)

				Library.Flags[cfg.flag] = value
			end

			function Toggle.Enable()
				Toggle.Set(not Toggle.Value)
			end

			function Toggle.State(value)
				Objects.holder.Visible = value
			end

			Utility.Signal(Objects.line.MouseButton1Click:Connect(Toggle.Enable))

			Utility.Signal(Objects.line.MouseEnter:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "text"
				}, true)
			end))

			Utility.Signal(Objects.line.MouseLeave:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)

				if not Toggle.Value then
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)
				end
			end))

			Toggle.Set(cfg.value)

			Library.ConfigFlags[cfg.flag] = Toggle.Set

			return setmetatable(Toggle, Library)
		end

		function Library.Slider(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "New Slider",
				value = 50,
				min = 0,
				max = 100,
				float = 1,
				suffix = "%s",
				callback = function() end,
				flag = nil,
			})

			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local Slider = {
				Tweening = false,

				Objects = { },

				Value = cfg.value,

				Sliding = false,
			}

			local Objects = Slider.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.holder,
				})

				Objects.line = Utility.New("TextButton", {
					Name = "line",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				if cfg.name ~= "" then
					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = cfg.name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.line,
					}, { TextColor3 = "dark text" })

					Slider.childholder = Objects.text

					Utility.New("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.text,
					})
				end

				Objects.value = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(86, 86, 86),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = "50%",
					TextStrokeTransparency = 0,
					Name = "text",
					Size = UDim2.new(0, 0, 1, 0),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.text,
				}, { TextColor3 = "dark text" })

				Utility.New("UIListLayout", {
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					FillDirection = Enum.FillDirection.Horizontal,
					Parent = Objects.value,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 3),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.line,
				})

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 14),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Objects.line,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0.5, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Objects.background,
				}, { BackgroundColor3 = "accent" })

				Utility.New("UIPadding", {
					PaddingTop = UDim.new(0, 1),
					PaddingBottom = UDim.new(0, 1),
					PaddingRight = UDim.new(0, 1),
					PaddingLeft = UDim.new(0, 1),
					Parent = Objects.background,
				})  
			end

			function Slider.Set(value)
				Slider.Value = math.clamp(Utility.Round(value, cfg.float), cfg.min, cfg.max)

				if Objects.value then
					Objects.value.Text = string.format(cfg.suffix, tostring(Slider.Value))
				end

				Objects.accent.Size = UDim2.new((Slider.Value - cfg.min) / (cfg.max - cfg.min), 0, 1, 0)

				cfg.callback(Slider.Value)

				Library.Flags[cfg.flag] = Slider.Value
			end

			function Slider.State(value)
				Objects.holder.Visible = value
			end

			Utility.Signal(Objects.line.MouseButton1Down:Connect(function(input)
				local MouseLocation = UserInputService:GetMouseLocation()

				Slider.Sliding = true

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "text"
				}, true)

				Library.ChangeObjectTheme(Objects.value, {
					TextColor3 = "text"
				}, true)

				Slider.Set( ((cfg.max - cfg.min) * ((MouseLocation.x - Objects.inline.AbsolutePosition.x) / Objects.inline.AbsoluteSize.x)) + cfg.min )
			end))

			Utility.Signal(Objects.line.MouseEnter:Connect(function(input)
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "text"
				}, true)

				Library.ChangeObjectTheme(Objects.value, {
					TextColor3 = "text"
				}, true)
			end))

			Utility.Signal(Objects.line.MouseLeave:Connect(function(input)
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)

				if not Slider.Sliding then
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)

					Library.ChangeObjectTheme(Objects.value, {
						TextColor3 = "dark text"
					}, true)
				end
			end))

			Utility.Signal(UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and Slider.Sliding then
					Slider.Sliding = false

					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)

					Library.ChangeObjectTheme(Objects.value, {
						TextColor3 = "dark text"
					}, true)
				end
			end))

			Utility.Signal(UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and Slider.Sliding then
					Slider.Set( ((cfg.max - cfg.min) * ((input.Position.x - Objects.inline.AbsolutePosition.x) / Objects.inline.AbsoluteSize.x)) + cfg.min )
				end
			end))

			Slider.Set(cfg.value)

			Library.ConfigFlags[cfg.flag] = Slider.Set

			return setmetatable(Slider, Library)
		end

		function Library.Button(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "New Button",
				confirm = false,
				callback = function() end,
			})

			local Button = {
				Clicked = false,

				Time = 0,

				Objects = { },
			}

			local Objects = Button.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.holder,
				})

				Objects.line = Utility.New("TextButton", {
					Name = "line",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 27),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Objects.line,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.text = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(86, 86, 86),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.name,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "dark_text",
					Size = UDim2.new(1, 0, 1, -2),
					BorderSizePixel = 0,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.background,
				}, { TextColor3 = "dark text" })
			end

			function Button.StartConfirmation()
				Button.Clicked = true

				Button.Time = 5

				Objects.text.Text = string.format("Confirm %s? (%s)", cfg.name, Button.Time)

				Button.Coroutine = coroutine.create(function()
					for i = 1, 5 do
						task.wait(1)

						Button.Time -= 1

						if Button.Time > 0 then
							Objects.text.Text = string.format("Confirm %s? (%s)", cfg.name, Button.Time)
						else
							Objects.text.Text = cfg.name

							if Button.Clicked then
								Library.ChangeObjectTheme(Objects.text, {
									TextColor3 = "dark text"
								}, true)

								Button.Clicked = false
							end

							break
						end
					end
				end); coroutine.resume(Button.Coroutine)
			end

			function Button.Click()
				if cfg.confirm then
					if Button.Clicked then
						Library.ChangeObjectTheme(Objects.text, {
							TextColor3 = "dark text"
						}, true)

						coroutine.close(Button.Coroutine)

						Objects.text.Text = cfg.name

						Button.Clicked = false

						cfg.callback()
					else
						Library.ChangeObjectTheme(Objects.text, {
							TextColor3 = "text"
						}, true)

						Button.StartConfirmation()
					end
				else
					cfg.callback()	

					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "text"
					}, true)

					task.wait(Library.TweenSpeed)

					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)
				end
			end

			function Button.State(value)
				Objects.holder.Visible = value
			end

			Utility.Signal(Objects.line.MouseButton1Click:Connect(Button.Click))

			Utility.Signal(Objects.line.MouseEnter:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)

				if not Button.Clicked then
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "text"
					}, true)
				end
			end))

			Utility.Signal(Objects.line.MouseLeave:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)

				if not Button.Clicked then
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)
				end
			end))

			return setmetatable(Button, Library)
		end

		function Library.Dropdown(self, cfg)
			cfg = cfg or {}; cfg = Library.Config(cfg, {
				name = "New Dropdown",
				values = { "value1", "value2", "value3", "value4", "value5", "value6" },
				value = "value1",
				multi = false,
				flag = nil,
				callback = function() end,
			})

			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local Dropdown = {
				Tweening = false,

				Visible = false,

				Objects = { },

				Popup = { Objects = {} },

				Items = { },

				Value = nil,
			}

			local Objects = Dropdown.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.holder,
				})

				Objects.line = Utility.New("TextButton", {
					Name = "line",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 3),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.line,
				})

				if cfg.name ~= "" then
					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = cfg.name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.line,
					}, { TextColor3 = "dark text" })

					Dropdown.childholder = Objects.text

					Utility.New("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.text,
					})
				end

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 27),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Objects.line,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.value = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(86, 86, 86),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = "-",
					TextStrokeTransparency = 0,
					Name = "dark_text",
					Size = UDim2.new(1, -4, 1, -2),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.new(0, 4, 0, 0),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.background,
				}, { TextColor3 = "dark text" })

				Objects.ImageLabel = Utility.New("ImageLabel", {
					ImageColor3 = Color3.fromRGB(86, 86, 86),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					AnchorPoint = Vector2.new(1, 0.5),
					Image = Library.Images.Lines,
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -8, 0.5, 0),
					Size = UDim2.new(0, 10, 0, 7),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Objects.value.Size = UDim2.new(1, -(4 + Objects.ImageLabel.AbsoluteSize.X + 12), 1, -2)
			end

			local Popup = Dropdown.Popup; do
				local Objects = Popup.Objects

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					Position = UDim2.new(0, 618, 0, 464),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 199, 0, 60),
					BorderSizePixel = 0,
					Visible = false,
					ClipsDescendants = true,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Library.ScreenGui,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -1),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.accent = Utility.New("ScrollingFrame", {
					Active = true,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					ScrollBarImageColor3 = Color3.fromRGB(220, 100, 100),
					MidImage = Library.Images.ScrollBar,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					ScrollBarThickness = 1,
					Name = "accent",
					Size = UDim2.new(1, 1, 1, 0),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, -1, 0, 0),
					BottomImage = Library.Images.ScrollBar,
					TopImage = Library.Images.ScrollBar,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				}, { ScrollBarImageColor3 = "accent" })

				Utility.New("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.accent,
				})
			end

			-- Change Pos
			Utility.Signal(Objects.inline:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				if Dropdown.Visible then
					local Size = Objects.inline.AbsoluteSize

					local Position = Objects.inline.AbsolutePosition

					Popup.Objects.inline.Position = UDim2.new(0, math.round(Position.X), 0, math.round(Position.Y) + math.round(Size.Y) + GuiService:GetGuiInset().Y - 2)
				end
			end))

			Utility.Signal(UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and Dropdown.Visible and not Utility.MouseOver(Popup.Objects.inline, input) then
					Dropdown.Open(false)
				end
			end))
			--

			function Dropdown.Display()
				local Value = Dropdown.Value

				if cfg.multi then
					local CurrentText = {}

					if #Value > 0 then
						for _,item in Value do
							table.insert(CurrentText, item)

							Objects.value.Text = table.concat(CurrentText, ", ")
						end
					else
						Objects.value.Text = "-"
					end
				else
					Objects.value.Text = type(Value) == "string" and Value or "-"
				end
			end

			function Dropdown.Size()
				local Size = 0

				local Count = 0

				for _,v in Popup.Objects.accent:GetChildren() do
					Count += 1

					if v:IsA("TextButton") then
						Size += v.AbsoluteSize.y
					end

					if Count > 5 then
						break
					end
				end

				return Size
			end

			function Dropdown.Open(visbility)
				if Dropdown.Tweening or Dropdown.Visible == visbility then
					return
				end

				Dropdown.Tweening = true

				Dropdown.Visible = visbility

				if Dropdown.Visible then
					Popup.Objects.inline.Visible = true
				end

				local ParentObjects = Popup.Objects.inline:GetDescendants()

				table.insert(ParentObjects, Popup.Objects.inline)

				for _, obj in ParentObjects do
					local Index = Utility.GetTransparency(obj)
					if not Index then continue end

					if type(Index) == "table" then
						for _, prop in Index do
							Library.Fade(obj, prop, Dropdown.Visible)
						end
					else
						Library.Fade(obj, Index, Dropdown.Visible)
					end
				end

				local Size = Vector2.new(Objects.inline.AbsoluteSize.x, math.round(Objects.inline.AbsoluteSize.y))

				local Position = Vector2.new(math.round(Objects.inline.AbsolutePosition.x), math.round(Objects.inline.AbsolutePosition.y))

				Popup.Objects.inline.Position = UDim2.new(0, Position.X, 0, Position.Y + Size.Y + 1 + GuiService:GetGuiInset().Y - 2)

				Popup.Objects.inline.Size = Dropdown.Visible and UDim2.new(0, Size.X, 0, 10) or UDim2.new(0, Size.X + 1, 0, Dropdown.Size())

				local Tween = Library.Tween(Popup.Objects.inline, {
					Size = Dropdown.Visible and UDim2.new(0, Size.X, 0, Dropdown.Size()) or UDim2.new(0, Size.X + 1, 0, 10),
				})

				Utility.Signal(Tween.Completed:Connect(function()
					Popup.Objects.inline.Visible = Dropdown.Visible

					Dropdown.Tweening = false
				end))
			end

			function Dropdown.Set(value, ignore)
				if cfg.multi then
					if type(value) == "table" then -- probably means config/values is loading...
						for _,item in Dropdown.Items do
							item.Select(false)
						end

						for _,item in value do
							for _,item2 in Dropdown.Items do
								if item2.Name == item then
									item2.Select(true)
								end
							end
						end

						Dropdown.Value = value

						Dropdown.Display()

						if not ignore then
							cfg.callback(Dropdown.Value)
						end

						Library.Flags[cfg.flag] = Dropdown.Value
					else
						local Index = table.find(Dropdown.Value, value)

						if Index then
							table.remove(Dropdown.Value, Index)

							for _,item in Dropdown.Items do
								if item.Name == value then
									item.Select(false)
								end
							end

							Dropdown.Display()

							if not ignore then
								cfg.callback(Dropdown.Value)
							end

							Library.Flags[cfg.flag] = Dropdown.Value
						else
							table.insert(Dropdown.Value, value)

							for _,item in Dropdown.Items do
								if item.Name == value then
									item.Select(true)
								end
							end

							Dropdown.Display()

							if not ignore then
								cfg.callback(Dropdown.Value)
							end

							Library.Flags[cfg.flag] = Dropdown.Value
						end
					end
				else
					for _,item in Dropdown.Items do
						item.Select(item.Name == value)
					end

					Dropdown.Value = value

					Dropdown.Display()

					if not ignore then
						cfg.callback(Dropdown.Value)
					end

					Library.Flags[cfg.flag] = Dropdown.Value
				end
			end

			function Dropdown.Add(name)
				local Item = {
					Objects = {},

					Name = name,

					Selected = false,
				}

				local Objects = Item.Objects; do
					Objects.holder = Utility.New("TextButton", {
						Name = "holder",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Parent = Popup.Objects.accent,
					})

					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(230, 230, 230),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = name,
						TextStrokeTransparency = 0,
						Name = "text",
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 5, 0, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.XY,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.holder,
					}, { TextColor3 = "dark text" })

					Utility.New("UIPadding", {
						PaddingBottom = UDim.new(0, 4),
						PaddingTop = UDim.new(0, 4),
						PaddingRight = UDim.new(0, 6),
						Parent = Objects.text,
					})

					Objects.accent = Utility.New("Frame", {
						Name = "accent",
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Size = UDim2.new(0, 1, 1, 0),
						BorderSizePixel = 0,
						BackgroundColor3 = Color3.fromRGB(220, 100, 100),
						Parent = Objects.holder,
					}, { BackgroundColor3 = "accent" })

					Utility.New("UIListLayout", {
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.accent,
					})
				end

				function Item.Select(value)
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = value and "text" or "dark text"
					}, true)

					Library.Tween(Objects.accent, {
						BackgroundTransparency = value and 0 or 1
					})

					Item.Selected = value
				end

				Utility.Signal(Objects.holder.MouseButton1Click:Connect(function()
					Dropdown.Set(name)
				end))

				Utility.Signal(Objects.holder.MouseEnter:Connect(function()
					if Item.Selected then return end

					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "text"
					}, true)
				end))

				Utility.Signal(Objects.holder.MouseLeave:Connect(function()
					if Item.Selected then return end

					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)
				end))

				table.insert(Dropdown.Items, Item)

				return Item
			end

			function Dropdown.Refresh(tbl)
				for _,item in Dropdown.Items do
					item.Objects.holder:Destroy()
				end

				Dropdown.Items = { }

				Dropdown.Value = cfg.multi and { } or nil

				for _,item in tbl do
					Dropdown.Add(item)
				end

				Dropdown.Display()
			end

			function Dropdown.State(value)
				Objects.holder.Visible = value
				Dropdown.Open(false)
			end

			for _,item in cfg.values do
				Dropdown.Add(item)
			end

			Dropdown.Set(cfg.value)

			Utility.Signal(Objects.line.MouseButton1Click:Connect(function()
				Dropdown.Open(not Dropdown.Visible)
			end))

			Utility.Signal(Objects.line.MouseEnter:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "text"
				}, true)

				Library.ChangeObjectTheme(Objects.value, {
					TextColor3 = "text"
				}, true)
			end))

			Utility.Signal(Objects.line.MouseLeave:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "dark text"
				}, true)

				Library.ChangeObjectTheme(Objects.value, {
					TextColor3 = "dark text"
				}, true)
			end))

			Library.ConfigFlags[cfg.flag] = Dropdown.Set

			table.insert(Library.Popups, Dropdown)

			return setmetatable(Dropdown, Library)
		end

		function Library.List(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "New List",
				value = "value1",
				values = { "value1", "value2", "value3", "value4", "value5", "value6" },
				multi = false,
				size = 100,
				search = false,
				callback = function() end,
				flag = nil,
			})

			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local List = {
				Objects = { },

				Items = { },

				Value = nil,
			}

			function List.SearchFunc(text)
				text = text:lower()

				for _,item in List.Items do
					local Holder = item.Objects.text

					Holder.Visible = text == "" and true or item.Name:lower():find(text)
				end
			end

			local Objects = List.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.holder,
				})

				Objects.line = Utility.New("Frame", {
					Name = "line",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 3),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.line,
				})

				if cfg.name ~= "" then
					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = cfg.name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.line,
					}, { TextColor3 = "dark text" })

					Utility.New("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.text,
					})

					List.childholder = Objects.text
				end

				Objects.box = Utility.New("Frame", {
					Name = "box",
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.line,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, -1),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.box,
				})

				if cfg.search then
					Library.Textbox({
						holder = Objects.box
					}, {
						name = "",
						callback = function(value)
							List.SearchFunc(value)
						end,
						flag = "list_search_" .. cfg.name,
					})
				end

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, cfg.size),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Objects.box,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.accent = Utility.New("ScrollingFrame", {
					Active = true,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					ScrollBarImageColor3 = Color3.fromRGB(220, 100, 100),
					MidImage = Library.Images.ScrollBar,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					ScrollBarThickness = 1,
					Name = "accent",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					BottomImage = Library.Images.ScrollBar,
					TopImage = Library.Images.ScrollBar,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				}, { ScrollBarImageColor3 = "accent" })

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.accent,
				})

				Utility.New("UIPadding", {
					PaddingTop = UDim.new(0, 4),
					PaddingBottom = UDim.new(0, 4),
					PaddingRight = UDim.new(0, 4),
					PaddingLeft = UDim.new(0, 4),
					Parent = Objects.accent,
				})
			end

			function List.Set(value)
				if cfg.multi then
					if type(value) == "table" then -- probably means config/values is loading...
						for _,item in List.Items do
							item.Select(false)
						end

						for _,item in value do
							for _,item2 in List.Items do
								if item2.Name == item then
									item2.Select(true)
								end
							end
						end

						List.Value = value

						cfg.callback(List.Value)

						Library.Flags[cfg.flag] = List.Value
					else
						local Index = table.find(List.Value, value)

						if Index then
							table.remove(List.Value, Index)

							for _,item in List.Items do
								if item.Name == value then
									item.Select(false)
								end
							end

							cfg.callback(List.Value)

							Library.Flags[cfg.flag] = List.Value
						else
							table.insert(List.Value, value)

							for _,item in List.Items do
								if item.Name == value then
									item.Select(true)
								end
							end

							cfg.callback(List.Value)

							Library.Flags[cfg.flag] = List.Value
						end
					end
				else
					for _,item in List.Items do
						item.Select(item.Name == value)
					end

					List.Value = value

					cfg.callback(List.Value)

					Library.Flags[cfg.flag] = List.Value
				end
			end

			function List.Add(name)
				local Item = {
					Objects = {},

					Name = name,

					Selected = false,
				}

				local Objs = Item.Objects; do
					Objs.text = Utility.New("TextButton", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.accent,
					}, { TextColor3 = "dark text" })
				end

				function Item.Select(value)
					Library.ChangeObjectTheme(Objs.text, {
						TextColor3 = value and "text" or "dark text"
					}, true)

					Item.Selected = value
				end

				Utility.Signal(Objs.text.MouseButton1Click:Connect(function()
					List.Set(name)
				end))

				Utility.Signal(Objs.text.MouseEnter:Connect(function()
					if Item.Selected then return end

					Library.ChangeObjectTheme(Objs.text, {
						TextColor3 = "text"
					}, true)
				end))

				Utility.Signal(Objs.text.MouseLeave:Connect(function()
					if Item.Selected then return end

					Library.ChangeObjectTheme(Objs.text, {
						TextColor3 = "dark text"
					}, true)
				end))

				table.insert(List.Items, Item)

				return Item
			end

			function List.Refresh(tbl)
				for _,item in List.Items do
					item.Objects.text:Destroy()
				end

				List.Items = { }

				List.Value = cfg.multi and { } or nil

				for _,item in tbl do
					List.Add(item)
				end
			end

			function List.State(value)
				Objects.holder.Visible = value
			end

			for _,item in cfg.values do
				List.Add(item)
			end

			Utility.Signal(Objects.inline.MouseEnter:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)
			end))

			Utility.Signal(Objects.inline.MouseLeave:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)
			end))

			List.Set(cfg.value)

			Library.ConfigFlags[cfg.flag] = List.Set

			return setmetatable(List, Library)
		end

		function Library.Textbox(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "Textbox",
				value = "",
				callback = function() end,
				flag = nil,
			})

			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local Textbox = {
				Objects = { },
			}

			local Objects = Textbox.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.holder,
				})

				Objects.line = Utility.New("Frame", {
					Name = "line",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 3),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.line,
				})

				if cfg.name ~= "" then
					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = cfg.name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.line,
					}, { TextColor3 = "dark text" })

					Textbox.childholder = Objects.text

					Utility.New("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.text,
					})
				end

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 27),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Objects.line,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.textbox = Utility.New("TextBox", {
					FontFace = Library.Font,
					Name = "text",
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.value,
					Size = UDim2.new(1, -5, 1, 0),
					TextStrokeTransparency = 0,
					Position = UDim2.new(0, 4, 0, 0),
					ClipsDescendants = true,
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					ClearTextOnFocus = false,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				}, { TextColor3 = "dark text" })			 
			end

			function Textbox.Set(value)
				Objects.textbox.Text = value

				Library.Flags[cfg.flag] = value
				cfg.callback(value)
			end

			function Textbox.State(value)
				Objects.holder.Visible = value
			end

			Utility.Signal(Objects.textbox.FocusLost:Connect(function()
				Textbox.Set(Objects.textbox.Text)

				Library.ChangeObjectTheme(Objects.textbox, {
					TextColor3 = "dark text"
				}, true)
			end))

			Utility.Signal(Objects.textbox.Focused:Connect(function()
				Library.ChangeObjectTheme(Objects.textbox, {
					TextColor3 = "text"
				}, true)
			end))

			Utility.Signal(Objects.line.MouseEnter:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "text"
				}, true)
			end))

			Utility.Signal(Objects.line.MouseLeave:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "dark text"
				}, true)
			end))

			Textbox.Set(cfg.value)

			Library.ConfigFlags[cfg.flag] = Textbox.Set

			return setmetatable(Textbox, Library)
		end

		function Library.Colorpicker(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "New Colorpicker",
				value = Color3.new(1, 1, 1),
				alpha = 0,
				usealpha = true,
				flag = nil,
				ignore = false,
				callback = function() end,
			})

			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local Colorpicker = {
				Tweening = false,

				ZIndex = self.ZIndex,

				Objects = { },

				OriginalColor = cfg.value,

				Popup = { },

				Value = cfg.value,

				Alpha = cfg.alpha,
			}

			local ZIndex = Colorpicker.ZIndex

			local Objects = Colorpicker.Objects; do
				if not self.childholder then
					Objects.holder = Utility.New("Frame", {
						Name = "holder",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Parent = self.holder,
					})

					Objects.line = Utility.New("Frame", {
						Name = "line",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Parent = Objects.holder,
					})

					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = cfg.name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.line,
					}, { TextColor3 = "dark text" })

					Utility.New("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.text,
					})

					Colorpicker.childholder = Objects.text
				end

				local Parent = self.childholder or Objects.text

				Objects.inline = Utility.New("TextButton", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 24, 0, 12),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Parent,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.alphaimage = Utility.New("ImageLabel", {
					ScaleType = Enum.ScaleType.Tile,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Name = "alphaimage",
					Image = Library.Images.Checkers,
					TileSize = UDim2.new(0, 6, 0, 6),
					Position = UDim2.new(0, 1, 0, 1),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Objects.color = Utility.New("Frame", {
					BackgroundTransparency = 0,
					Name = "color",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 151, 197),
					Parent = Objects.alphaimage,
				})
			end

			local ColorpickerWindow = Library.ColorpickerWindow

			function Colorpicker.Set(value, alpha)
				local Color, Alpha;

				if type(value) == "table" then
					Color = value.c
					Alpha = value.a
				else
					Color = value
					Alpha = alpha or Colorpicker.Alpha
				end

				Colorpicker.Value = Color

				if Alpha then
					Colorpicker.Alpha = Alpha

					Objects.color.BackgroundTransparency = Alpha
				end

				Objects.color.BackgroundColor3 = Color

				if not cfg.ignore then
					Library.Flags[cfg.flag] = {
						c = Color,
						a = Alpha
					}
				end

				cfg.callback({
					c = Color,
					a = Alpha
				})
			end

			function Colorpicker.State(state)
				if Objects.holder then Objects.holder.Visible = state end
				Objects.inline.Visible = state
				ColorpickerWindow.Open(false)
			end

			Utility.Signal(Objects.inline.MouseButton1Click:Connect(function(input)
				ColorpickerWindow.Flag = cfg.flag

				ColorpickerWindow.SetFunc = Colorpicker.Set

				ColorpickerWindow.OriginalColor = Colorpicker.OriginalColor

				ColorpickerWindow.Set(Colorpicker.Value, Colorpicker.Alpha)

				ColorpickerWindow.Open(not ColorpickerWindow.Visible, Objects.inline.AbsolutePosition + Vector2.new(0, Objects.inline.AbsoluteSize.Y + 2 + GuiService:GetGuiInset().Y) )

				ColorpickerWindow.Objects.alphaimage.Visible = cfg.usealpha
			end))

			Utility.Signal(UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and ColorpickerWindow.Visible and ColorpickerWindow.Flag == cfg.flag and not (Utility.MouseOver(ColorpickerWindow.Objects.accent, input) or Utility.MouseOver(Objects.inline, input)) then
					ColorpickerWindow.Open(false, Objects.inline.AbsolutePosition + Vector2.new(0, Objects.inline.AbsoluteSize.Y + 2 + GuiService:GetGuiInset().Y) )
				end
			end))

			Utility.Signal(Objects.inline.MouseEnter:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)
			end))

			Utility.Signal(Objects.inline.MouseLeave:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)
			end))

			if Objects.line then
				Utility.Signal(Objects.line.MouseEnter:Connect(function()
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "text"
					}, true)
				end))

				Utility.Signal(Objects.line.MouseLeave:Connect(function()
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)
				end))
			end

			Colorpicker.Set(cfg.value, cfg.alpha)

			if not cfg.ignore then
				Library.ConfigFlags[cfg.flag] = Colorpicker.Set
			end

			return setmetatable(Colorpicker, Library)
		end

		function Library.Keybind(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "New Keybind",
				value = false,
				key = nil,
				mode = "Toggle",
				ignore = false,
				callback = function() end,
				flag = nil,
			})

			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local Keybind = {
				Tweening = false,

				Visible = false,

				Objects = { },

				Popup = { Objects = {}, Items = {} },

				Key = nil,

				Mode = nil,

				Value = false,

				OnHold = nil,

				Listener = nil,
			}

			local Objects = Keybind.Objects; do
				if not self.childholder then
					Objects.holder = Utility.New("Frame", {
						Name = "holder",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Parent = self.holder,
					})

					Objects.line = Utility.New("Frame", {
						Name = "line",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Parent = Objects.holder,
					})

					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = cfg.name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.line,
					}, { TextColor3 = "dark text" })

					Utility.New("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.text,
					})

					Keybind.childholder = Objects.text
				end

				local Parent = self.childholder or Objects.text

				Objects.value = Utility.New("TextButton", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(86, 86, 86),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = "[-]",
					TextStrokeTransparency = 0,
					Name = "text",
					Size = UDim2.new(0, 0, 1, 0),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Parent,
				}, { TextColor3 = "dark text" })

				Utility.New("UIListLayout", {
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					FillDirection = Enum.FillDirection.Horizontal,
					Parent = Objects.value,
				})
			end

			local Popup = Keybind.Popup; do
				Popup.Objects.inline = Utility.New("Frame", {
					Name = "inline",
					Position = UDim2.new(0, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Visible = false,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Library.ScreenGui,
				}, { BackgroundColor3 = "inline" })

				Popup.Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Popup.Objects.inline,
				}, { BackgroundColor3 = "background" })

				Utility.New("UIPadding", {
					PaddingBottom = UDim.new(0, 1),
					Parent = Popup.Objects.background,
				})

				Utility.New("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Popup.Objects.background,
				})

				function Popup.SetMode(mode)
					for _,item in Popup.Items do
						item.Select(item.Mode == mode)
					end
				end

				function Popup.Add(mode)
					local Item = {
						Objects = {},

						Mode = mode,

						Selected = false,
					}

					local Objs = Item.Objects; do
						Objs.holder = Utility.New("TextButton", {
							BackgroundTransparency = 1,
							Name = "holder",
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							AutomaticSize = Enum.AutomaticSize.XY,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							Parent = Popup.Objects.background,
						})

						Objs.text = Utility.New("TextLabel", {
							FontFace = Library.Font,
							TextColor3 = Color3.fromRGB(230, 230, 230),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							Text = mode,
							TextStrokeTransparency = 0,
							Name = "text",
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 4, 0, 0),
							BorderSizePixel = 0,
							AutomaticSize = Enum.AutomaticSize.XY,
							TextSize = 12,
							BackgroundColor3 = Color3.fromRGB(25, 25, 25),
							Parent = Objs.holder,
						}, { TextColor3 = "dark text" })

						Utility.New("UIPadding", {
							PaddingBottom = UDim.new(0, 4),
							PaddingTop = UDim.new(0, 4),
							PaddingRight = UDim.new(0, 6),
							Parent = Objs.text,
						})

						Objs.accent = Utility.New("Frame", {
							Name = "accent",
							Position = UDim2.new(0, -1, 0, 0),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							Size = UDim2.new(0, 1, 1, 0),
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							BackgroundColor3 = Color3.fromRGB(220, 100, 100),
							Parent = Objs.holder,
						}, { BackgroundColor3 = "accent" })
					end

					function Item.Select(value)
						Library.ChangeObjectTheme(Objs.text, {
							TextColor3 = value and "text" or "dark text"
						})

						Library.Tween(Objs.accent, {
							BackgroundTransparency = value and 0 or 1
						})

						Item.Selected = value
					end

					Utility.Signal(Objs.holder.MouseButton1Click:Connect(function()
						Keybind.Set(mode)
					end))

					Utility.Signal(Objs.holder.MouseEnter:Connect(function()
						if Item.Selected then return end

						Library.ChangeObjectTheme(Objs.text, {
							TextColor3 = "text"
						})
					end))

					Utility.Signal(Objs.holder.MouseLeave:Connect(function()
						if Item.Selected then return end

						Library.ChangeObjectTheme(Objs.text, {
							TextColor3 = "dark text"
						})
					end))

					Popup.Items[mode] = Item

					return Item
				end

				Utility.Signal(Objects.value:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
					if Keybind.Visible then
						local Size = Objects.value.AbsoluteSize
						local Position = Objects.value.AbsolutePosition

						Popup.Objects.inline.Position = UDim2.new(0, math.round(Position.X), 0, math.round(Position.Y) + math.round(Size.Y) + 2 + GuiService:GetGuiInset().Y)
					end
				end))
			end; Keybind.ZIndex = ZIndex

			for _,mode in {"Always on", "Hold", "Toggle"} do
				Popup.Add(mode)
			end

			local Item;
			if not cfg.ignore then
				Item = Library.KeybindsList.Add()
			end

			function Keybind.Set(value, ignore)
				if type(value) == "table" then
					for _,v in value do 
						Keybind.Set(v, true)
					end

					return 
				end

				local Type = typeof(value)
				if Type == "EnumItem" then
					Keybind.Key = value 

					value = ( value == Enum.KeyCode.Unknown and "-" or value.Name )

					Objects.value.Text = string.format("[%s]", KeyConverters[ value:lower() ] or value)
				elseif Type == "boolean" then
					-- state 
					if Keybind.Mode == "Always on" and not value then
						value = true 
					end 

					Keybind.Value = value 
				elseif Type == "string" then
					-- method
					if Keybind.OnHold and value ~= "Hold" then 
						Keybind.OnHold:Disconnect( )
						Keybind.OnHold = nil 
					end 

					Keybind.Mode = value 

					Popup.SetMode(value)

					if value == "Always on" then
						Keybind.Value = true 
					end	
				end 

				if Item then
					Item.Set(Keybind.Value, cfg.name, Keybind.Mode or "Toggle")
				end

				if not ignore then
					Library.Flags[cfg.flag] = Keybind.Value
					cfg.callback(Keybind.Value)
				end

				Library.Flags[string.format("%s_data", cfg.flag)] = {
					value = Keybind.Value,
					key = Keybind.Key,
					mode = Keybind.Mode
				}
			end

			function Keybind.Open(visibility)
				if Keybind.Tweening or Keybind.Visible == visibility then
					return
				end

				Keybind.Tweening = true

				Keybind.Visible = visibility

				if Keybind.Visible then
					Popup.Objects.inline.Visible = true
				end

				local ParentObjects = Popup.Objects.inline:GetDescendants()

				table.insert(ParentObjects, Popup.Objects.inline)

				local Tween;
				for _, obj in ParentObjects do
					local Index = Utility.GetTransparency(obj)
					if not Index then continue end

					if type(Index) == "table" then
						for _, prop in Index do
							Tween = Library.Fade(obj, prop, Keybind.Visible)
						end
					else
						Tween = Library.Fade(obj, Index, Keybind.Visible)
					end
				end

				Popup.Objects.inline.Position = UDim2.new(0, Objects.value.AbsolutePosition.X, 0, Objects.value.AbsolutePosition.Y + Objects.value.AbsoluteSize.Y + 2 + GuiService:GetGuiInset().Y)

				Utility.Signal(Tween.Completed:Connect(function()
					Keybind.Tweening = false

					Popup.Objects.inline.Visible = Keybind.Visible
				end))
			end

			function Keybind.State(state)
				if Objects.holder then Objects.holder.Visible = state end
				Objects.inline.Visible = state
				Keybind.Open(false)
			end

			Utility.Signal(Objects.value.MouseButton1Click:Connect(function(input)
				if Keybind.Listener then 
					Keybind.Listener:Disconnect( )
					Keybind.Listener = nil 

					return
				end

				Objects.value.Text = string.format("[%s]", "...")

				Library.ChangeObjectTheme(Objects.value, {
					TextColor3 = "text"
				}, true)

				task.wait( 1/50 )

				Keybind.Listener = Utility.Signal(UserInputService.InputBegan:Connect(function(input) 
					if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Backspace then 
						Keybind.Set( Enum.KeyCode.Unknown )

						Library.ChangeObjectTheme(Objects.value, {
							TextColor3 = "dark text"
						}, true)

						Keybind.Listener:Disconnect( )
						Keybind.Listener = nil

						return
					end

					if input.UserInputType == Enum.UserInputType.Keyboard or table.find({ Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3 }, input.UserInputType ) then 
						local Key = input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode or input.UserInputType or Enum.KeyCode.Unknown

						Keybind.Set( Key )

						Library.ChangeObjectTheme(Objects.value, {
							TextColor3 = "dark text"
						}, true)

						Keybind.Listener:Disconnect( )
						Keybind.Listener = nil
					end
				end))
			end))

			Utility.Signal(Objects.value.MouseButton2Click:Connect(function(input)
				Keybind.Open(not Keybind.Visible)
			end))

			Utility.Signal(UserInputService.InputBegan:Connect(function(input) 
				if input.KeyCode == Keybind.Key or input.UserInputType == Keybind.Key then 
					local Value = Keybind.Mode ~= "Toggle" or not Keybind.Value
					Keybind.Set( Value )

					if Keybind.Mode == "Hold" then 
						if Keybind.OnHold then 
							Keybind.OnHold:Disconnect( ) 
						end

						Keybind.OnHold = Utility.Signal(UserInputService.InputEnded:Connect(function(input) 
							if input.KeyCode == Keybind.Key or input.UserInputType == Keybind.Key then 
								Keybind.Set( false )

								if Keybind.OnHold then 
									Keybind.OnHold:Disconnect( )
									Keybind.OnHold = nil
								end
							end
						end))
						-- elseif keybind.method == "single" then 
						--	 keybind.set( false )
					end
				end
			end))

			Utility.Signal(UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and Keybind.Visible and not Utility.MouseOver(Popup.Objects.inline, input) then
					Keybind.Open(false)
				end
			end))

			if Objects.line then
				Utility.Signal(Objects.line.MouseEnter:Connect(function(input)
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "text"
					}, true)
				end))

				Utility.Signal(Objects.line.MouseLeave:Connect(function(input)
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)
				end))
			end

			Keybind.Set({ cfg.key, cfg.mode, cfg.value }, true)
			-- Library.ConfigFlags[cfg.flag] = Keybind.Set
			Library.ConfigFlags[string.format("%s_data", cfg.flag)] = Keybind.Set

			table.insert(Library.Popups, Keybind)

			return setmetatable(Keybind, Library)
		end

		function Library.Watermark(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				text = "ping: {ping}ms | user: admin | {date}",
				titlestart = "swim",
				titleend = "bot",
				visible = true,
				rate = 1 / 20,
			})

			local Watermark = {
				Objects = {},

				Visible = cfg.visible,

				Rate = cfg.rate,

				Text = cfg.text,

				Clock = os.clock(),
			}

			local Objects = Watermark.Objects; do
				Objects.accent = Utility.New("Frame", {
					Size = UDim2.new(0, 250, 0, 0),
					Name = "accent",
					Position = UDim2.new(0, 5, 0, 60),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Library.NotificationHolder,
				}, { BackgroundColor3 = "accent" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.accent,
				}, { BackgroundColor3 = "background" })

				Utility.New("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.background,
				})

				Objects.topbar = Utility.New("Frame", {
					Name = "topbar",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Objects.textholder = Utility.New("Frame", {
					Name = "textholder",
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 1, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.topbar,
				})

				Utility.New("UIPadding", {
					PaddingBottom = UDim.new(0, 2),
					PaddingTop = UDim.new(0, 4),
					Parent = Objects.topbar,
				})

				Utility.New("UIPadding", {
					PaddingRight = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6),
					Parent = Objects.textholder,
				})

				Utility.New("UIListLayout", {
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.textholder,
				})

				Objects.text = Utility.New("TextLabel", {
					FontFace = Fonts.Get("TahomaXP"),
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.titlestart,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "text",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.textholder,
				}, { TextColor3 = "text" })

				Objects.text2 = Utility.New("TextLabel", {
					FontFace = Fonts.Get("TahomaXP"),
					TextColor3 = Color3.fromRGB(220, 100, 100),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.titleend,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "accent",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.textholder,
				}, { TextColor3 = "accent" })

				Objects.bottombar = Utility.New("Frame", {
					Name = "bottombar",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Utility.New("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.bottombar,
				})

				Utility.New("UIPadding", {
					PaddingTop = UDim.new(0, 4),
					PaddingBottom = UDim.new(0, 8),
					PaddingRight = UDim.new(0, 14),
					PaddingLeft = UDim.new(0, 14),
					Parent = Objects.bottombar,
				})

				Objects.bottomtext = Utility.New("TextLabel", {
					FontFace = Fonts.Get("TahomaXP"),
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "text",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.bottombar,
				}, { TextColor3 = "text" })
			end

			function Watermark.SetText(text)
				Watermark.Text = text
			end

			function Watermark.SetVisible(visibility)
				Objects.accent.Visible = visibility
				Watermark.Visible = visibility
			end

			function Watermark.SetRate(rate)
				Watermark.Rate = rate
			end

			local LastTime = 0
			local Frames = 0
			function Watermark.Think(step)
				Frames += 1
				if tick() - LastTime >= 1 then
					Library.Fps = Frames
					LastTime = tick()
					Frames = 0
				end

				if Watermark.Visible and os.clock() - Watermark.Clock >= Watermark.Rate then
					Watermark.Clock = os.clock()

					Objects.bottomtext.Text = Utility.TextTriggers(Watermark.Text)
				end
			end

			Utility.Signal(RunService.RenderStepped:Connect(Watermark.Think))

			return Watermark
		end

		function Library.Notification(text, time)
			local Notification = {
				Objects = { },
			}

			local Objects = Notification.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 70),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Library.NotificationHolder,
				})

				Objects.background = Utility.New("Frame", {
					BackgroundTransparency = 0.5,
					Name = "background",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Position = UDim2.new(-1, 0, 0, 0),
					Parent = Objects.holder,
				}, { BackgroundColor3 = "background" })

				Objects.text = Utility.New("TextLabel", {
					FontFace = Fonts.Get("TahomaXP"),
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = text,
					RichText = true,
					TextStrokeTransparency = 0,
					Name = "text",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 4, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.background,
				}, { TextColor3 = "text" })

				Utility.New("UIPadding", {
					PaddingBottom = UDim.new(0, 8),
					PaddingTop = UDim.new(0, 6),
					PaddingRight = UDim.new(0, 6),
					Parent = Objects.text,
				})

				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 2, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Objects.background,
				}, { BackgroundColor3 = "accent" })	
			end

			task.spawn(function()
				Library.Tween(Objects.background, {
					Position = UDim2.new(0, 0, 0, 0),
				})

				task.wait(time)

				Library.Tween(Objects.background, {
					Position = UDim2.new(-1, 0, 0, 0),
				})

				task.wait(Library.TweenSpeed)

				local Size = Objects.holder.AbsoluteSize

				Objects.holder.AutomaticSize = Enum.AutomaticSize.None

				Objects.background:Destroy()

				Objects.holder.Size = UDim2.new(0, Size.X, 0, Size.Y)

				Library.Tween(Objects.holder, {
					Size = UDim2.new(0, Size.X, 0, 0),
				})

				task.wait(Library.TweenSpeed)

				Notification.Objects.holder:Destroy()
			end)

			return Notification
		end

		Library.ColorpickerWindow = Library.ColorpickerWindow()

		--

		function Library.GetConfig()
			local Config = { }

			for _,v in Library.ConfigFlags do
				local Value = Library.Flags[_]

				if type(Value) == "table" and Value["key"] then
					Config[_] = {value = Value.value, mode = Value.mode, key = tostring(Value.key)}
				elseif type(Value) == "table" and Value["a"] and Value["c"] then
					Config[_] = {a = Value.a, c = Value.c:ToHex()}
				else
					Config[_] = Value
				end
			end

			return HttpService:JSONEncode(Config)
		end

		function Library.GetTheme()
			local Theme = { }

			for theme,v in Library.Theme do
				if typeof(v) == "Color3" then
					Theme[theme] = v:ToHex()
				end
			end

			return HttpService:JSONEncode(Theme)
		end

		function Library.GetThemeData(data)
			data = HttpService:JSONDecode(data)

			local RawData = {  }
			for theme,v in data do
				RawData[theme] = Color3.fromHex(v)
			end

			return RawData
		end

		function Library.LoadConfig(data)
			data = HttpService:JSONDecode(data)

			for i,v in data do
				local Config = Library.ConfigFlags[i]

				if Config then
					if type(v) == "table" and v["a"] and v["c"] then
						Config({
							a = v.a,
							c = type(v.c) == "string" and Color3.fromHex(v.c) or v.c
						})
					elseif type(v) == "table" and v["key"] then
						Config({
							value = v.value,
							mode = v.mode,
							key = Utility.StringToEnum(v.key)
						}, true)
					else
						Config(v)
					end
				end
			end
		end

		function Library.Unload()
			for _,obj in Utility.Connections do
				obj:Disconnect()
			end

			for _,obj in Utility.Objects do
				obj:Destroy()
			end

			Env.Library = nil
		end
	end;
	Env.Library = Library
	Env.Utility = Library.Utility
	return Library, Library.Utility
end)();

local cloneref = cloneref or function(...) return ... end
local checkcaller = checkcaller
local getnamecallmethod = getnamecallmethod
local tablecreate = table.create
local mathfloor = math.floor
local mathround = math.round
local mathrandom = math.random
local tostring = tostring
local unpack = table.unpack
local getupvalues = debug.getupvalues
local getupvalue = debug.getupvalue
local setupvalue = debug.setupvalue
local getconstants = debug.getconstants
local getconstant = debug.getconstant
local setconstant = debug.setconstant
local getstack = debug.getstack
local setstack = debug.setstack
local getinfo = debug.getinfo
local debugtraceback = debug.traceback
local rawget = rawget

local workspace = cloneref(game:GetService("Workspace"))
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local HttpService = cloneref(game:GetService("HttpService"))
local GuiInset = cloneref(game:GetService("GuiService")):GetGuiInset()
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local _CFramenew = CFrame.new
local _Vector2new = Vector2.new
local _Vector3new = Vector3.new
local _IsDescendantOf = game.IsDescendantOf
local _FindFirstChild = game.FindFirstChild
local _FindFirstChildOfClass = game.FindFirstChildOfClass
local _Raycast = workspace.Raycast
local _IsKeyDown = UserInputService.IsKeyDown
local _WorldToViewportPoint = Camera.WorldToViewportPoint
local _Vector3zeromin = Vector3.zero.Min
local _Vector2zeromin = Vector2.zero.Min
local _Vector3zeromax = Vector3.zero.Max
local _Vector2zeromax = Vector2.zero.Max
local _VectorToObjectSpace = CFrame.new().VectorToObjectSpace
local _IsA = game.IsA

local cheat = {
	Library = nil,
	Toggles = nil,
	Options = nil,
	ThemeManager = nil,
	SaveManager = nil,
	connections = {
		heartbeats = {},
		renderstepped = {}
	},
	drawings = {},
	hooks = {}
}
cheat.utility = {} do
	cheat.utility.new_heartbeat = function(func)
		local obj = {}
		cheat.connections.heartbeats[func] = func
		function obj:Disconnect()
			if func then
				cheat.connections.heartbeats[func] = nil
				func = nil
			end
		end
		return obj
	end
	cheat.utility.new_renderstepped = function(func)
		local obj = {}
		cheat.connections.renderstepped[func] = func
		function obj:Disconnect()
			if func then
				cheat.connections.renderstepped[func] = nil
				func = nil
			end
		end
		return obj
	end
	cheat.utility.new_drawing = function(drawobj, args)
		local obj = Drawing.new(drawobj)
		for i, v in pairs(args) do
			obj[i] = v
		end
		cheat.drawings[obj] = obj
		return obj
	end
	cheat.utility.new_hook = function(f, newf, usecclosure) LPH_NO_VIRTUALIZE(function()
			if usecclosure then
				local old; old = hookfunction(f, newcclosure(function(...)
					return newf(old, ...)
				end))
				cheat.hooks[f] = old
				return old
			else
				local old; old = hookfunction(f, function(...)
					return newf(old, ...)
				end)
				cheat.hooks[f] = old
				return old
			end
		end)() end
	local connection; connection = RunService.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(delta)
		for _, func in pairs(cheat.connections.heartbeats) do
			func(delta)
		end
	end))
	local connection1; connection1 = RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(delta)
		for _, func in pairs(cheat.connections.renderstepped) do
			func(delta)
		end
	end))
	cheat.utility.unload = function()
		connection:Disconnect()
		connection1:Disconnect()
		for key, _ in pairs(cheat.connections.heartbeats) do
			cheat.connections.heartbeats[key] = nil
		end
		for key, _ in pairs(cheat.connections.renderstepped) do
			cheat.connections.heartbeats[key] = nil
		end
		for _, drawing in pairs(cheat.drawings) do
			drawing:Remove()
			cheat.drawings[_] = nil
		end
		for hooked, original in pairs(cheat.hooks) do
			if type(original) == "function" then
				hookfunction(hooked, clonefunction(original))
			else
				hookmetamethod(original["instance"], original["metamethod"], clonefunction(original["func"]))
			end
		end
	end
end
LPH_NO_VIRTUALIZE(function()
	local esp_table = {}
	local workspace = game:GetService("Workspace")
	local rservice = game:GetService("RunService")
	local plrs = game:GetService("Players")
	local lplr = plrs.LocalPlayer
	local container = Instance.new("Folder", game:GetService("CoreGui").RobloxGui)
	local gui_inset = game:GetService("GuiService"):GetGuiInset()

	if setfflag then
		setfflag("AdornShadingAPI", true) -- glowy chamsy
	end

	esp_table = {
		__loaded = false,
		registered_flags = {},
		settings = {
			enemy = {
				main_settings = {
					fade_time = 1,
					team_check = false,
					dead_check = false,
					dist_check = false,
					max_distance = 1000,
					skeleton_rate = 1e-10,
					gradient_spin = false,
					gradient_speed = 360, -- degrees per second, formula: tick() % 1 * speed
					holder_spin = false,
					holder_speed = 360 -- degrees per second, formula: tick() % 1 * speed
				},

				enabled = false,

				box = false,
				health_bar = false,
				name = false,
				health_text = false,
				distance = false,
				weapon = false,
				skeleton = false,
				flags = false,

				box_color = { Color3.new(1, 1, 1), Color3.new(1, 1, 1), 0 },
				health_bar_color = { Color3.new(1, 1, 1), Color3.new(1, 1, 1) },
				name_color = { Color3.new(1, 1, 1), 0 },
				health_text_color = { Color3.new(1, 1, 1), 0 },
				dist_color = { Color3.new(1, 1, 1), 0 },
				weapon_color = { Color3.new(1, 1, 1), 0 },
				skeleton_color = { Color3.new(1, 1, 1), 0 },
				flags_color = { Color3.new(1, 1, 1), 0 },

				box_rotation = 0,

				chams = false,
				chams_color = { Color3.new(1, 1, 1), 0 },
				chams_glow_factor = 2
			}
		}
	}

	local loaded_plrs = {}

	local VERTICES = {
		_Vector3new(-1, -1, -1),
		_Vector3new(-1, 1, -1),
		_Vector3new(-1, 1, 1),
		_Vector3new(-1, -1, 1),
		_Vector3new(1, -1, -1),
		_Vector3new(1, 1, -1),
		_Vector3new(1, 1, 1),
		_Vector3new(1, -1, 1)
	}
	local skeleton_order = {
		["LeftFoot"] = "LeftLowerLeg",
		["LeftLowerLeg"] = "LeftUpperLeg",
		["LeftUpperLeg"] = "LowerTorso",

		["RightFoot"] = "RightLowerLeg",
		["RightLowerLeg"] = "RightUpperLeg",
		["RightUpperLeg"] = "LowerTorso",

		["LeftHand"] = "LeftLowerArm",
		["LeftLowerArm"] = "LeftUpperArm",
		["LeftUpperArm"] = "UpperTorso",

		["RightHand"] = "RightLowerArm",
		["RightLowerArm"] = "RightUpperArm",
		["RightUpperArm"] = "UpperTorso",

		["LowerTorso"] = "UpperTorso",
		["UpperTorso"] = "Head"
	}
	local esp = {}
	esp.create_obj = function(new, args, tbl)
		local obj = Instance.new(new)
		for i, v in args do
			obj[i] = v
		end
		if tbl then table.insert(tbl, obj) end
		return obj
	end

	local function isBodyPart(name)
		return name == "Head" or name:find("Torso") or name:find("Leg") or name:find("Arm") or name:find("Hand") or name:find("Foot")
	end

	local function getBoundingBox(parts)
		local min, max
		for i, part in parts do
			local cframe, size = part[1], part[2]

			min = _Vector3zeromin(min or cframe.Position, (cframe - size * 0.5).Position)
			max = _Vector3zeromax(max or cframe.Position, (cframe + size * 0.5).Position)
		end

		local center = (min + max) * 0.5
		local front = _Vector3new(center.X, center.Y, max.Z)
		return _CFramenew(center, front), max - min
	end

	local function worldToScreen(world)
		local screen, inBounds = _WorldToViewportPoint(Camera, world)
		return _Vector2new(screen.X, screen.Y), inBounds, screen.Z
	end

	local function calculateCorners(cframe, size)
		local corners = table.create(#VERTICES)
		for i, vertice in VERTICES do
			corners[i] = worldToScreen((cframe + size * 0.5 * vertice).Position)
		end

		local min = _Vector2zeromin(Camera.ViewportSize, unpack(corners))
		local max = _Vector2zeromax(Vector2.zero, unpack(corners))
		return {
			corners = corners,
			topLeft = _Vector2new(min.X, min.Y),
			topRight = _Vector2new(max.X, min.Y),
			bottomLeft = _Vector2new(min.X, max.Y),
			bottomRight = _Vector2new(max.X, max.Y)
		}
	end

	local create_esp, destroy_esp;

	create_esp = function(plr_instance)
		loaded_plrs[plr_instance] = {
			obj = {},
			connections = {}
		}

		--[[for required, _ in next, skeleton_order do
			loaded_plrs[plr_instance].obj["skeleton_" .. required] = esp.create_obj("Line", { Visible = false, Thickness = 1 })
		end]]

		local flags_table = {}
		local chams_table = {}

		local registered_flags = esp_table.registered_flags

		local plr = loaded_plrs[plr_instance]
		local obj = plr.obj

		local main_holder = esp.create_obj("Frame", {
			Parent = container,
			ZIndex = 2,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(0, 0),
			Position = UDim2.fromScale(0, 0),
			BackgroundTransparency = 1,
			Visible = false
		}, obj)
		local box_holder = esp.create_obj("Frame", {
			Parent = main_holder,
			ZIndex = -1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, -2, 1, -2),
			Position = UDim2.new(0, 1, 0, 1),
			BackgroundTransparency = 1
		}, obj)
		local box_outline_holder = esp.create_obj("Frame", {
			Parent = main_holder,
			ZIndex = -1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(1, 1, 1),
			Size = UDim2.new(1, -4, 1, -4),
			Position = UDim2.new(0, 2, 0, 2),
			BackgroundTransparency = 1
		}, obj)

		local main_box = esp.create_obj("UIStroke", {
			Parent = box_holder,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new(1, 1, 1)
		}, obj)
		local main_box_color = esp.create_obj("UIGradient", {
			Parent = main_box,
			Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
			}
		}, obj)
		local main_box_outline_1 = esp.create_obj("UIStroke", {
			Parent = main_holder,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
		}, obj)
		local main_box_outline_2 = esp.create_obj("UIStroke", {
			Parent = box_outline_holder,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
		}, obj)

		local main_name = esp.create_obj("TextLabel", {
			Parent = main_holder,
			TextStrokeTransparency = 0,
			BorderSizePixel = 0,
			TextSize = 12,
			FontFace = Fonts.Get("TahomaXP"),
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(0, 10000, 0, 13),
			Text = plr_instance.Name,
			Position = UDim2.new(0.5, 0, 0, -17)
		}, obj)

		local main_distance = esp.create_obj("TextLabel", {
			Parent = main_holder,
			TextStrokeTransparency = 0,
			BorderSizePixel = 0,
			TextSize = 12,
			FontFace = Fonts.Get("TahomaXP"),
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(0, 10000, 0, 13),
			Text = "0m",
			Position = UDim2.new(0.5, 0, 1, 1)
		}, obj)

		local main_weapon = esp.create_obj("TextLabel", {
			Parent = main_holder,
			TextStrokeTransparency = 0,
			BorderSizePixel = 0,
			TextSize = 12,
			FontFace = Fonts.Get("TahomaXP"),
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(0, 10000, 0, 13),
			Text = "",
			Position = UDim2.new(0.5, 0, 1, 14)
		}, obj)

		local health_bar_holder = esp.create_obj("Frame", {
			Parent = main_holder,
			BackgroundColor3 = Color3.new(0, 0, 0),
			Size = UDim2.new(0, 1, 1, 0),
			Position = UDim2.new(0, -5, 0, 0),
			BorderSizePixel = 0
		}, obj)

		local health_bar_outline = esp.create_obj("UIStroke", {
			Parent = health_bar_holder,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
		}, obj)

		local main_health_bar = esp.create_obj("Frame", {
			Parent = health_bar_holder,
			ZIndex = 2,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0, 0, 0),
			Size = UDim2.new(1, 0, 0, 0)
		}, obj)

		local main_health_text = esp.create_obj("TextLabel", {
			Parent = main_health_bar,
			TextStrokeTransparency = 0,
			BorderSizePixel = 0,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Right,
			FontFace = Fonts.Get("TahomaXP"),
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 0),
			Size = UDim2.new(50, 0, 0, 6),
			Text = "100",
			Position = UDim2.new(-2, 0, 1, 0)
		}, obj)

		local health_bar_thing = esp.create_obj("Frame", {
			Parent = health_bar_holder,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(1, 1, 1),
			AnchorPoint = Vector2.new(0, 1),
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 1, 0)
		}, obj)

		local main_health_bar_color = esp.create_obj("UIGradient", {
			Parent = health_bar_thing,
			Rotation = 90,
			Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
				ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
			}
		}, obj)

		local flag_holder = esp.create_obj("Frame", {
			Parent = main_holder,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(1, 3, 0, -4),
			BackgroundTransparency = 1,
		}, obj)

		esp.create_obj("UIListLayout", {
			Parent = flag_holder,
			SortOrder = Enum.SortOrder.LayoutOrder
		}, obj)


		for i, v in registered_flags do
			table.insert(obj, esp.create_obj("TextLabel", {
				Parent = flag_holder,
				TextStrokeTransparency = 0,
				BorderSizePixel = 0,
				TextSize = 9,
				TextXAlignment = Enum.TextXAlignment.Left,
				FontFace = Fonts.Get("SmallestPixel7"),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 10),
				Text = v[1],
				Position = UDim2.new(0, 0, 0, -1)
			}, flags_table))
		end

		local main_wireframe = esp.create_obj("WireframeHandleAdornment", {
			Parent = container,
			Color3 = Color3.new(1, 1, 1),
			Transparency = 0,
			AlwaysOnTop = true,
			CFrame = CFrame.new(),
			Scale = Vector3.one,
			Thickness = 1,
			AdornCullingMode = Enum.AdornCullingMode.Automatic
		}, obj)

		--main_wireframe.Adornee = root

		local settings = esp_table.settings.enemy
		local main_settings = settings.main_settings

		local character, humanoid, head, root

		-- god forgive me
		local team_check, dead_check, dist_check = main_settings.team_check, main_settings.dead_check, main_settings.dist_check
		local skeleton_rate = main_settings.skeleton_rate <= 0 and 1e-10 or main_settings.skeleton_rate
		local max_distance, update_skeleton = main_settings.max_distance, settings.skeleton
		local weapon_enabled, box_rotation = settings.weapon, settings.box_rotation

		local gradient_spin, gradient_speed = main_settings.gradient_spin, main_settings.gradient_speed
		local holder_spin, holder_speed = main_settings.holder_spin, main_settings.holder_speed

		local get_character, get_root, get_humanoid = esp_table.get_character, esp_table.get_root, esp_table.get_humanoid
		local get_health, get_team, get_gun = esp_table.get_health, esp_table.get_team, esp_table.get_gun

		local setvis_cache, skeleton_tick = false, 0

		function plr:forceupdate()
			team_check, dead_check, dist_check = main_settings.team_check, main_settings.dead_check, main_settings.dist_check
			skeleton_rate = main_settings.skeleton_rate <= 0 and 1e-10 or main_settings.skeleton_rate
			max_distance, update_skeleton = main_settings.max_distance, settings.skeleton
			weapon_enabled, box_rotation = settings.weapon, settings.box_rotation

			gradient_spin, gradient_speed = main_settings.gradient_spin, main_settings.gradient_speed
			holder_spin, holder_speed = main_settings.holder_spin, main_settings.holder_speed

			main_box.Enabled = settings.box
			main_box_outline_1.Enabled = settings.box
			main_box_outline_2.Enabled = settings.box

			main_box.Transparency = settings.box_color[3]
			main_box_outline_1.Transparency = settings.box_color[3]
			main_box_outline_2.Transparency = settings.box_color[3]

			main_box_color.Rotation = box_rotation + (gradient_spin and tick() % 1 * gradient_speed or 0)
			main_box_color.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, settings.box_color[1]),
				ColorSequenceKeypoint.new(1, settings.box_color[2])
			}

			health_bar_holder.Visible = settings.health_bar
			main_health_bar_color.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, settings.health_bar_color[1]),
				ColorSequenceKeypoint.new(1, settings.health_bar_color[2])
			}

			main_health_text.Visible = settings.health_text
			main_health_text.TextColor3 = settings.health_text_color[1]
			main_health_text.TextTransparency = settings.health_text_color[2]

			main_name.Visible = settings.name
			main_name.TextColor3 = settings.name_color[1]
			main_name.TextTransparency = settings.name_color[2]

			main_distance.Visible = settings.distance
			main_distance.TextColor3 = settings.distance_color[1]
			main_distance.TextTransparency = settings.distance_color[2]

			main_weapon.Visible = settings.weapon
			main_weapon.TextColor3 = settings.weapon_color[1]
			main_weapon.TextTransparency = settings.weapon_color[2]

			main_wireframe.Visible = settings.skeleton
			main_wireframe.Color3 = settings.skeleton_color[1]
			main_wireframe.Transparency = settings.skeleton_color[2]

			flag_holder.Visible = settings.flags
			for _, flag in flags_table do
				flag.TextColor3 = settings.flags_color[1]
				flag.TextTransparency = settings.flags_color[2]
			end

			for part, cham in chams_table do
				cham.cham.Adornee = setvis_cache and settings.chams and part or nil
				cham.cham.Color3 = Color3.new(
					settings.chams_color[1].R * settings.chams_glow_factor,
					settings.chams_color[1].G * settings.chams_glow_factor,
					settings.chams_color[1].B * settings.chams_glow_factor
				)
			end
		end

		local destroy_cham_object = function(part)
			if not chams_table[part] then
				return --print("???????", part)
			end
			chams_table[part].connection:Disconnect()
			chams_table[part].cham:Destroy()
			chams_table[part] = nil
		end

		local create_cham_object = function(part)
			if not (_IsA(part, "BasePart") and isBodyPart(part.Name)) then return end
			if chams_table[part] then destroy_cham_object(part) end
			--print("hi", part)
			local cham = esp.create_obj("BoxHandleAdornment", {
				Parent = container,
				Size = part.Size * .95,
				Adornee = setvis_cache and settings.chams and part or nil,
				Color3 = Color3.new(
					settings.chams_color[1].R * settings.chams_glow_factor,
					settings.chams_color[1].G * settings.chams_glow_factor,
					settings.chams_color[1].B * settings.chams_glow_factor
				),
				Transparency = -1,
				Shading = Enum.AdornShading.XRayShaded,
				ZIndex = -1,
				AlwaysOnTop = false
			}, obj)

			chams_table[part] = {
				cham = cham,
				connection = part:GetPropertyChangedSignal("Size"):Connect(function()
					if not (cham and part) then return print("MEMORY LEAK!!!!!!", cham, part) end
					cham.Size = part.Size * .95
				end)
			}
		end

		function plr:togglevis(bool, fade)
			if setvis_cache == bool then return end
			setvis_cache = bool

			main_holder.Visible = bool
			for part, cham in chams_table do
				cham.cham.Adornee = bool and settings.chams and part or nil
			end
		end

		local character_added = function(character)
			for _, part in character:GetChildren() do
				create_cham_object(part)
			end
			plr.connections["character_childadded"] = character.ChildAdded:Connect(function(part)
				create_cham_object(part)
			end)
			plr.connections["character_childremoved"] = character.ChildRemoved:Connect(function(part)
				destroy_cham_object(part)
			end)
		end

		local character_removing = function(character)
			if plr.connections["character_childadded"] then plr.connections["character_childadded"]:Disconnect() end
			if plr.connections["character_childremoved"] then plr.connections["character_childremoved"]:Disconnect() end
			for part, _ in chams_table do
				destroy_cham_object(part)
			end
		end

		if plr_instance.Character then character_added(plr_instance.Character) end
		plr.connections["character_added"] = plr_instance.CharacterAdded:Connect(character_added)
		plr.connections["character_removing"] = plr_instance.CharacterRemoving:Connect(character_removing)

		plr.connections["render"] = cheat.utility.new_renderstepped(function(delta)
			skeleton_tick += delta

			if skeleton_tick > skeleton_rate then
				main_wireframe:Clear()
			end

			if not settings.enabled then
				return plr:togglevis(false)
			end

			character = get_character(plr_instance)

			if not (character) then
				return plr:togglevis(false)
			end

			root = get_root(plr_instance, character)
			humanoid = get_humanoid(plr_instance, character)

			if not (root) then
				return plr:togglevis(false)
			end
			
			local humanoid_health, humanoid_max_health
			if humanoid then 
				humanoid_health, humanoid_max_health = get_health(plr_instance, character, humanoid)
			end

			local humanoid_distance = (Camera.CFrame.Position - root.Position).Magnitude

			if (team_check) and get_team(plr_instance, character, humanoid) then
				return plr:togglevis(false)
			end

			if (dead_check) and (humanoid_health and humanoid_health <= 0) then
				return plr:togglevis(false)
			end

			if (dist_check) and (humanoid_distance > max_distance) then
				return plr:togglevis(false)
			end

			local _, onScreen = _WorldToViewportPoint(Camera, root.Position)

			if not onScreen then
				return plr:togglevis(false)
			end

			local corners, cache = {}, {}
			do
				local count = 0
				for _, part in character:GetChildren() do
					if _IsA(part, "BasePart") and isBodyPart(part.Name) then
						cache[part.Name] = {part.CFrame, part.Size}
						count += 1
					end
				end
				if count <= 0 then
					return plr:togglevis(false)
				end
				corners = calculateCorners(getBoundingBox(cache))
			end

			plr:togglevis(true)

			do
				main_holder.Rotation = holder_spin and tick() * holder_speed % 360 or 0
				main_box_color.Rotation = box_rotation + (gradient_spin and tick() * gradient_speed % 360 or 0)
			end

			do
				local pos = corners.topLeft
				local size = corners.bottomRight - corners.topLeft
				main_holder.Position = UDim2.fromOffset(pos.X - gui_inset.X, pos.Y - gui_inset.Y)
				main_holder.Size = UDim2.fromOffset(size.X, size.Y)
			end

			do
				local pos = (corners.bottomLeft + corners.bottomRight) * 0.5
				main_distance.Text = mathround(humanoid_distance) .. "m"
				if weapon_enabled then
					local gun = get_gun(plr_instance, character, humanoid)
					if gun then
						main_weapon.Text = gun
						main_weapon.Position = main_distance.Visible and UDim2.new(0.5, 0, 1, 14) or UDim2.new(0.5, 0, 1, 1)
						main_weapon.Visible = true
					else
						main_weapon.Visible = false
					end
				end
			end

			main_health_text.Text = humanoid_health and tostring(mathfloor(humanoid_health)) or "???"
			main_health_bar.Size = UDim2.fromScale(1, humanoid_health and (1 - humanoid_health / humanoid_max_health) or 1)

			for i, v in registered_flags do
				local show_flag, flag_text = v[2](plr_instance, character, humanoid)
				local flag = flags_table[i]
				if not show_flag then
					flag.Visible = false
					continue	
				end
				flag.Visible = true
				if flag_text then flag.Text = flag_text end
			end

			if update_skeleton and skeleton_tick > skeleton_rate then
				skeleton_tick = skeleton_tick % skeleton_rate
				local root_pos = root.CFrame
				main_wireframe.Adornee = root

				local points = {}
				local counter = 0

				for part_name, info in cache do 
					local parent_part = skeleton_order[part_name]
					local parent_info = parent_part and cache[parent_part]
					if not (parent_info) then
						continue
					end

					local part_pos, parent_pos = info[1], parent_info[1]

					points[counter + 1] = _VectorToObjectSpace(root_pos, part_pos.Position - root_pos.Position)
					points[counter + 2] = _VectorToObjectSpace(root_pos, parent_pos.Position - root_pos.Position)

					counter += 2
				end

				main_wireframe:AddLines(points)
			end
		end)

		plr:forceupdate()
	end

	destroy_esp = function(player)
		if not loaded_plrs[player] then return end
		for i,v in loaded_plrs[player].connections do
			v:Disconnect()
		end
		for i,v in loaded_plrs[player].obj do
			v:Remove()
		end
		loaded_plrs[player] = nil
	end

	function esp_table.load()
		assert(not esp_table.__loaded, "[ESP] already loaded");

		for _, player in plrs:GetPlayers() do
			if lplr ~= player then
				create_esp(player)
			end
		end

		esp_table.playerAdded = plrs.PlayerAdded:Connect(create_esp)
		esp_table.playerRemoving = plrs.PlayerRemoving:Connect(destroy_esp)

		esp_table.__loaded = true;
	end

	function esp_table.unload()
		assert(esp_table.__loaded, "[ESP] not loaded yet");

		for player, v in next, loaded_plrs do
			destroy_esp(player)
		end

		esp_table.playerAdded:Disconnect()
		esp_table.playerRemoving:Disconnect()

		esp_table.__loaded = false;
	end

	esp_table.get_character = function(player)
		return player.Character
	end

	esp_table.get_root = function(player, character)
		return _FindFirstChild(character, "HumanoidRootPart")
	end

	esp_table.get_humanoid = function(player, character)
		return _FindFirstChildOfClass(character, "Humanoid")
	end

	esp_table.get_health = function(player, character, humanoid)
		return humanoid.Health, humanoid.MaxHealth
	end

	esp_table.get_team = function(player, character, humanoid)
		return LocalPlayer.Team and player.Team and LocalPlayer.Team == player.Team
	end

	esp_table.get_gun = function(player, character, humanoid)
		if not character then
			return
		end
		local tool = _FindFirstChildOfClass(character, "Tool")
		return tool and tool.Name
	end

	function esp_table.icaca()
		for _, v in loaded_plrs do
			task.spawn(function() v:forceupdate() end)
		end
	end

	function esp_table.register_flag(flag, func)
		assert(not esp_table.__loaded, "[ESP] tried adding flag after loading, add before loading")
		local registered_flags = esp_table.registered_flags
		registered_flags[#registered_flags + 1] = {flag, func}
	end

	cheat.EspLibrary = esp_table
end)();
LPH_NO_VIRTUALIZE(function()
	local camera = workspace.CurrentCamera

	local indicatorlib = {
		indicators = {}
	}

	function indicatorlib:new_indicator()
		local indicator = {
			enabled = false,

			followpart = false,
			target_part = nil,

			scale_x = 0.5,
			scale_y = 0.5,
			offset_x = 0,
			offset_y = 0,

			blink = false,
			blink_speed = 1, -- transparency revolution/second [[ 0 -> 1 -> 0 ]]
			blink_cycle = false,

			text = "",
			transparency = 1
		}

		indicator.drawing = cheat.utility.new_drawing("Text", { Visible = false })
		indicator.text = `indicator {tostring(indicator)}`

		indicatorlib.indicators[indicator] = indicator

		return indicator 
	end


	cheat.utility.new_renderstepped(function(delta)
		local viewportsize = camera and camera.ViewportSize
		if not viewportsize then
			camera = workspace.CurrentCamera;
			for _, indicator in indicatorlib.indicators do
				local drawing = indicator.drawing
				if not drawing then continue end

				drawing.Visible = false
			end
			return
		end
		local viewport_x = viewportsize.X
		local viewport_y = viewportsize.Y
		for _, indicator in indicatorlib.indicators do

			local drawing = indicator.drawing
			if not drawing then continue end

			if not indicator.enabled then
				drawing.Visible = false
				continue
			end

			drawing.Visible = true
			drawing.Text = indicator.text

			if indicator.followpart then
				local target_part = indicator.target_part
				if not target_part then
					drawing.Visible = false
					continue
				end
				local pos, onscreen = _WorldToViewportPoint(camera, target_part.CFrame.Position)
				if not onscreen then
					drawing.Visible = false
					continue
				end
				drawing.Position = _Vector2new(pos.X + indicator.offset_x, pos.Y + indicator.offset_y)
			else
				local calculated_x = viewport_x * indicator.scale_x + indicator.offset_x
				local calculated_y = viewport_y * indicator.scale_y + indicator.offset_y
				drawing.Position = _Vector2new(calculated_x, calculated_y)
			end

			if not indicator.blink then
				drawing.Transparency = indicator.transparency
				continue
			end

			local blink_speed = indicator.blink_speed

			if drawing.Transparency <= 0 then
				indicator.blink_cycle = true
			elseif drawing.Transparency >= 1 then
				indicator.blink_cycle = false
			end

			drawing.Transparency = drawing.Transparency + (blink_speed * (indicator.blink_cycle and 1 or -1)) * delta
		end
	end)


	cheat.IndicatorLibrary = indicatorlib
end)();

local ui = {
	window = Library:Window({
		namestart = "swim",
		nameend = "hub"
	})
}

ui.tabs = {
	combat = ui.window:Tab({name = "Combat", image = Images.Get("combat")}),
	visuals = ui.window:Tab({name = "Visuals", image = Images.Get("visuals")}),
	misc = ui.window:Tab({name = "Misc", image = Images.Get("misc")}),
	settings = ui.window:Tab({name = "Settings", image = Images.Get("config")})
}
ui.subtabs = {
	combat_aimbot = ui.tabs.combat:SubTab({Name = "Aimbot"}),
	combat_visuals = ui.tabs.combat:SubTab({Name = "Visuals"}),
	visuals_esp = ui.tabs.visuals:SubTab({Name = "ESP"}),
	visuals_lighting = ui.tabs.visuals:SubTab({Name = "Lighting"}),
	visuals_misc = ui.tabs.visuals:SubTab({Name = "Misc"}),
	misc_main = ui.tabs.misc:SubTab({Name = "Main"}),
	misc_exploit = ui.tabs.misc:SubTab({Name = "Exploits"}),
	settings_main = ui.tabs.settings:SubTab({Name = "Main"}),
	settings_theme = ui.tabs.settings:SubTab({Name = "Themeing"})
}
ui.sections = {
	aimbot_main = ui.subtabs.combat_aimbot:Section({Name = "Aimbot", Side = "Left"}),
	aimbot_checks = ui.subtabs.combat_aimbot:Section({Name = "Checks", Side = "Right"}),
	--aimbot_silent = ui.subtabs.combat_aimbot:Section({Name = "Silent", Side = "Right"}),
	hit_detection = ui.subtabs.combat_visuals:Section({Name = "Hit detection", Side = "Left"}),

	player_esp = ui.subtabs.visuals_esp:Section({Name = "Players", Side = "Left"}),
	esp_settings = ui.subtabs.visuals_esp:Section({Name = "Settings", Side = "Right"}),
	world_main_changer = ui.subtabs.visuals_lighting:Section({Name = "Lighting", Side = "Left"}),
	world_misc_changer = ui.subtabs.visuals_lighting:Section({Name = "Misc", Side = "Right"}),
	visuals_misc = ui.subtabs.visuals_misc:Section({Name = "View", Side = "Left"}),

	movement = ui.subtabs.misc_main:Section({Name = "Movement", Side = "Left"}),
	misc = ui.subtabs.misc_main:Section({Name = "Misc", Side = "Right"}),
	custom_desync = ui.subtabs.misc_exploit:Section({Name = "Custom desync", Side = "Left"}),
	exploit = ui.subtabs.misc_exploit:Section({Name = "Exploit", Side = "Right"}),

	settings_config = ui.subtabs.settings_main:Section({Name = "Config", Side = "Left"}),
	settings_personalization = ui.subtabs.settings_main:Section({Name = "Personalization", Side = "Right"}),
	theme_config = ui.subtabs.settings_theme:Section({Name = "Config", Side = "Left"}),
	theme_colors = ui.subtabs.settings_theme:Section({Name = "Colors", Side = "Right"})
}

do -- grr
	ui.tabs.combat.Set(true)

	ui.subtabs.combat_aimbot.Set(true)
	ui.subtabs.visuals_esp.Set(true)
	ui.subtabs.misc_main.Set(true)
	ui.subtabs.settings_main.Set(true)
end

--[[{
	name = "New Toggle",
	value = false,
	callback = function() end,
	flag = nil,
}]]

--[[
	local Tab = Window:Tab() do
		local SubTab = Tab:SubTab({Name = "Main"}) do
			local Section = SubTab:Section({Name = "Section"}) do
				local Toggle = Section:Toggle({ Name = "Toggle", Flag = "toggle_flag", Value = false, Callback = function(v) print("Toggle value:", v) end })

				Toggle:Keybind({
					Name = "Toggle Keybind",
					Key = Enum.KeyCode.B,
					Mode = "Toggle",
					Flag = "keybind_flag2",
					Value = false,
					Callback = function(v)
						print("Keybind value:", v)
					end
				})
				Toggle:Colorpicker({
					Name = "Colorpicker",
					Flag = "colorpicker_flag2",
					Value = Color3.fromRGB(255, 0, 0),
					Alpha = 0.5,
					UseAlpha = true,
					Callback = function(v)
						print("Colorpicker value:", v)
					end
				})
				
				Section:Slider({ Name = "Slider", Min = -100, Max = 100, Value = 0, Float = 1, Flag = "slider_flag", Callback = function(v) print("Slider value:", v) end })
				Section:Button({ Name = "Button", Confirm = true, Callback = function() print("Button clicked") end })
				Section:Dropdown({ 
					Name = "Dropdown", 
					Values = { "Value 1", "Value 2", "Value 3", "Value 4", "Value 5", "Value 6", "Value 7", "Value 8", "Value 9", "Value 10" }, 
					Value = { "Value 1" }, 
					Flag = "dropdown_flag", 
					Multi = true,
					Callback = function(v) 
						print("Dropdown value:", v) 
					end 
				})
				Section:List({
					Name = "List",
					Values = { "Value 1", "Value 2", "Value 3", "Value 4", "Value 5", "Value 6", "Value 7", "Value 8", "Value 9", "Value 10" },
					Value = { "Value 1" },
					Flag = "list_flag",
					Multi = true,
					Size = 120,
					Search = true,
					Callback = function(v)
						print("List value:", v)
					end
				})
				Section:Textbox({
					Name = "Textbox",
					Value = "",
					Flag = "textbox_flag",
					Callback = function(v)
						print("Textbox value:", v)
					end
				})
				Section:Keybind({
					Name = "Keybind",
					Key = Enum.KeyCode.E,
					Flag = "keybind_flag",
					Mode = "Toggle",
					Value = false,
					Callback = function(v)
						print("Keybind value:", v)
					end
				})
				Section:Colorpicker({
					Name = "Colorpicker",
					Flag = "colorpicker_flag",
					Value = Color3.fromRGB(255, 0, 0),
					Alpha = 0.5,
					UseAlpha = true,
					Callback = function(v)
						print("Colorpicker value:", v)
					end
				})
			end
			local Section = SubTab:Section({Name = "Section", Side = "Right"}) do

			end
		end
		local Other = Tab:SubTab({Name = "Other"}) do

		end
		SubTab.Set(true)
	end

Library.Notification("This is a notification.", 3)
Library.Notification( string.format(
	"Hit %s in the %s for %s damage (%s health remaining)", 
	Utility.RichText("Dean", Library.Theme.accent), 
	Utility.RichText("Head", Library.Theme.accent), 
	Utility.RichText("102", Library.Theme.accent), 
	Utility.RichText("0", Library.Theme.accent)
), 5 )
]]

cheat.player_list = {}
local hit_detection = function(...)end
local get_closest_target = function(...)end
do
	local player_list = cheat.player_list
	local esp_table = cheat.EspLibrary

	if game.GameId == 104984488 then
		esp_table.get_character = function(player)
			local focus = player.ReplicationFocus
			return focus and _FindFirstChild(focus, "Visuals")
		end
		esp_table.get_team = function(player, character, humanoid)
			return false
		end
	end

	local get_character, get_root, get_humanoid = esp_table.get_character, esp_table.get_root, esp_table.get_humanoid
	local get_health, get_team, get_gun = esp_table.get_health, esp_table.get_team, esp_table.get_gun

	local add_player = function(player)
		local character, humanoid
		local old_health
		player_list[player] = {
			premium = player.MembershipType == Enum.MembershipType.Premium,
			friend = player:IsFriendsWith(LocalPlayer.UserId),
			update_loop = cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function(delta)
				character = get_character(player)
				if not character then return end
				humanoid = _FindFirstChildOfClass(character, "Humanoid")
				if not humanoid then return end
				if not old_health then old_health = humanoid.Health end
				local new_health = humanoid.Health
				if new_health ~= old_health then
					hit_detection(player, new_health, old_health)
					old_health = new_health
				end
			end))
		}
	end
	for _, player in Players:GetPlayers() do
		task.spawn(add_player, player)
	end

	Players.PlayerAdded:Connect(add_player)
	Players.PlayerRemoving:Connect(function(player)
		local object = player_list[player]
		object.update_loop:Disconnect()
		player_list[player] = nil
	end)

	

	--[[esp_table.get_character = function(player)
		return player.Character
	end

	esp_table.get_root = function(player, character)
		return _FindFirstChild(character, "HumanoidRootPart")
	end

	esp_table.get_humanoid = function(player, character)
		return _FindFirstChildOfClass(character, "Humanoid")
	end

	esp_table.get_health = function(player, character, humanoid)
		return humanoid.Health, humanoid.MaxHealth
	end

	esp_table.get_team = function(player, character, humanoid)
		return LocalPlayer.Team and player.Team and LocalPlayer.Team == player.Team
	end]]

	get_closest_target = function(fov_size, aimpart, team_check, dead_check, dist_check, max_distance)
		local ermm_part, plr_instance, collider
		local maximum_distance = fov_size
		local mousepos = UserInputService:GetMouseLocation()
		local campos = Camera.CFrame.Position
		
		LPH_NO_VIRTUALIZE(function()
			for _, player in Players:GetPlayers() do
				if not (player and player ~= LocalPlayer) then continue end

				local character = get_character(player)

				if not (character) then
					continue
				end

				local root = get_root(player, character)
				local aimpart = _FindFirstChild(character, aimpart)
				local mainpart = aimpart or root

				local humanoid = get_humanoid(player, character)

				if not (mainpart) then
					continue
				end

				local health, max_health
				if humanoid then
					health, max_health = health, max_health
				end

				if not (mainpart) then continue end

				if (team_check) and get_team(player) then
					continue
				end

				if (dead_check) and (health and health <= 0) then
					continue
				end
				if (dist_check) and ((campos - mainpart.Position).Magnitude > max_distance) then
					continue
				end

				local position, onscreen = _WorldToViewportPoint(Camera, mainpart.Position)
				local distance = (_Vector2new(position.X, position.Y) - mousepos).Magnitude

				if onscreen and distance <= maximum_distance then
					plr_instance = player
					ermm_part = mainpart
					collider = root
					maximum_distance = distance
				end
			end
		end)()
		return ermm_part, plr_instance, collider
	end
end

local aimbot_mode
local target_part, target_player, target_collider
local silent_mode, silent_projectionoverride, silent_wallbang, silent_magicbullet = "None", false, false, false
local silent_methods = {
	["Raycast"] = false,
	["FindPartOnRayWithWhitelist"] = false,
	["FindPartOnRayWithIgnoreList"] = false,
	["FindPartOnRay"] = false,
	["ScreenPointToRay"] = false,
	["ViewportPointToRay"] = false
}
do
	local aimsec = ui.sections.aimbot_main
	local chksec = ui.sections.aimbot_checks
	local samsec = ui.sections.aimbot_silent
	local hitsec = ui.sections.hit_detection
	local gunsec = ui.sections.gunmods

	local aimbot_enabled, aimbot_enabled_key, aimbot_part, aimbot_mode, aimbot_smoothness = false, false, "Head", "Mouse", 0.7
	local aimbot_team_check, aimbot_dead_check, aimbot_dist_check, aimbot_max_distance = false, false, false, 600
	local fov_show, fov_color, fov_outline, fov_size = false, Color3.new(1,1,1), false, 100
	local indicator = cheat.IndicatorLibrary:new_indicator()

	do
		aimsec:Toggle({Name = "Enabled", Value = false, Flag = "aimbot_enable", Callback = function(bool)
			aimbot_enabled = bool
		end}):Keybind({Name = "Aimbot", Mode = "Hold", Key = Enum.KeyCode.E, Value = false, Flag = "aimbot_enabled_keybind", Callback = function(bool)
			aimbot_enabled_key = bool
		end})
		aimsec:Dropdown({Name = "Hitpart", Values = {"Head", "UpperTorso"}, Value = "Head", Flag = "aimbot_hitpart", Multi = false, Callback = function(str)
			aimbot_part = str
		end})
		aimsec:Dropdown({Name = "Aim mode", Values = {"Camera", "Mouse", "Silent"}, Value = "Camera", Flag = "aimbot_mode", Multi = false, Callback = function(str)
			aimbot_mode = str
		end})
		aimsec:Slider({Name = "Aim smoothness", Min = 0.01, Max = 1, Float = 0.01, Value = 0.7, Flag = "aimbot_smoothness", Suffix = "%s\194\176" --[[degree symbol (°)]], Callback = function(int)
			aimbot_smoothness = int
		end})
	end
	do
		chksec:Dropdown({Name = "Checks", Values = {"Team check", "Dead check", "Distance check"}, Value = {}, Flag = "aimbot_checks", Multi = true, Callback = function(tbl)
			local funny = {
				["Team check"] = "team_check",
				["Dead check"] = "dead_check",
				["Distance check"] = "dist_check"
			}
			local uhh = {}
			for flag_text, esp_var in funny do
				uhh[esp_var] = false
			end
			for flag_text, esp_var in funny do
				for _, check_name in tbl do
					if (check_name ~= flag_text or uhh[esp_var]) then
						continue
					end
					uhh[esp_var] = true
				end
			end
			aimbot_team_check = uhh["team_check"]
			aimbot_dead_check = uhh["dead_check"]
			aimbot_dist_check = uhh["dist_check"]
		end})
		chksec:Slider({Name = "Max distance", Min = 0, Max = 5000, Float = 100, Value = 600, Flag = "aimbot_max_distance", Callback = function(int)
			aimbot_max_distance = int
		end})
		chksec:Slider({Name = "Aim size", Min = 0, Max = 180, Float = 1, Value = 10, Flag = "aimbot_fov_size", Suffix = "%s\194\176" --[[degree symbol (°)]], Callback = function(int)
			fov_size = int
		end})
		chksec:Toggle({Name = "FOV", Value = false, Flag = "fov_enabled", Callback = function(bool)
			fov_show = bool
		end}):Colorpicker({Name = "FOV Color", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "fov_color", Callback = function(color)
			fov_color = color.c
		end})
		chksec:Toggle({Name = "Outline", Value = false, Flag = "fov_outline", Callback = function(bool)
			fov_outline = bool
		end})
	end
	do
		local hit_logs, hit_logs_duration = false, 0
		local hit_chams, hit_skeletons = false, false
		hitsec:Toggle({Name = "Hitlogs", Value = false, Flag = "hit_logs", Callback = function(bool)
			hit_logs = bool
		end})
		hitsec:Slider({Name = "Log duration", Min = 0, Max = 10, Float = 0.1, Value = 5, Flag = "hit_logs_duration", Suffix = "%ss", Callback = function(int)
			hit_logs_duration = int
		end})

		hit_detection = function(player, new_health, old_health)
			if not target_player or player ~= target_player then
				return
			end
			if new_health >= old_health then
				return
			end
			Library.Notification(string.format(
				"Hit %s in the %s for %s damage (%s health remaining)", 
				Utility.RichText(player.Name, Library.Theme.accent), 
				Utility.RichText(aimbot_part, Library.Theme.accent), 
				Utility.RichText(tostring(math.floor(old_health - new_health)), Library.Theme.accent), 
				Utility.RichText(tostring(math.floor(new_health)), Library.Theme.accent)
				), hit_logs_duration)
		end
	end
	
	do
		chksec:Dropdown({Name = "Silent mode", Values = {
			"Raycast",
			"FindPartOnRayWithIgnoreList",
			"FindPartOnRayWithWhitelist",
			"FindPartOnRay",
			"ScreenPointToRay",
			"ViewportPointToRay",
			"Mouse",
			"Ray"
		}, Value = {}, Flag = "aimbot_silent_mode", Multi = true, Callback = function(tbl)
				for i, v in silent_methods do
					silent_methods[i] = false
				end
				print('--------------------------------')
				for _, value in tbl do
					silent_methods[value] = true
					print(value)
				end
			end})
		chksec:Toggle({Name = "Projection override", Value = false, Flag = "silent_projectionoverride", Callback = function(bool)
			silent_projectionoverride = bool
		end})
		chksec:Toggle({Name = "Wallbang", Value = false, Flag = "silent_wallbang", Callback = function(bool)
			silent_wallbang = bool
		end})
		chksec:Toggle({Name = "Magic bullet (UNSTABLE)", Value = false, Flag = "silent_magicbullet", Callback = function(bool)
			silent_magicbullet = bool
		end})
	end

	local CircleOutline = cheat.utility.new_drawing("Circle", {
		Thickness = 3,
		Color = Color3.new(),
		ZIndex = 1
	})
	local CircleInline = cheat.utility.new_drawing("Circle", {
		Transparency = 1,
		Thickness = 1,
		ZIndex = 2
	})

	cheat.utility.new_heartbeat(LPH_NO_VIRTUALIZE(function()
		local indtxt = ""
		if aimbot_enabled then
			local viewportsize = Camera.ViewportSize
			local new_fov_size = (viewportsize.X * (fov_size / Camera.FieldOfView)) / 2
			target_part, target_player, target_collider = get_closest_target(
				new_fov_size,
				aimbot_part or "Head",
				aimbot_team_check,
				aimbot_dead_check,
				aimbot_dist_check,
				aimbot_max_distance
			)

			if indicator.followpart then indicator.target_part = target_part end

			if target_part and target_collider then
				indtxt = target_player.Name
			end
		else
			target_part, target_player, target_collider = nil, nil, nil
		end

		indicator.text = indtxt
	end))
	cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function()
		local mpos = UserInputService:GetMouseLocation()
		local viewportsize = Camera.ViewportSize
		local new_fov_size = (viewportsize.X * (fov_size / Camera.FieldOfView)) / 2
		CircleInline.Position = mpos
		CircleInline.Radius = new_fov_size
		CircleInline.Color = fov_color
		CircleInline.Visible = fov_show
		CircleOutline.Position = mpos
		CircleOutline.Radius = new_fov_size
		CircleOutline.Visible = (fov_show and fov_outline)
		if aimbot_enabled and aimbot_enabled_key and target_part and target_collider then
			local new_pos = target_part.Position
			if aimbot_mode == "Mouse" then
				local pos = _WorldToViewportPoint(Camera, new_pos)
				local mpos = UserInputService:GetMouseLocation()
				mousemoverel(math.round((pos.X - mpos.X) * aimbot_smoothness), math.round((pos.Y - mpos.Y) * aimbot_smoothness))
			end
			if aimbot_mode == "Camera" then
				Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, new_pos), aimbot_smoothness)
			end
		end
	end))
end

local aspect_ratio, aspect_ratio_x, aspect_ratio_y = false, 1, 1
local thirdperson, thirdperson_key, thirdperson_distance = false, false, 10
do
	local espsec = ui.sections.player_esp
	local setsec = ui.sections.esp_settings
	local mscsec = ui.sections.visuals_misc

	local enemy_sets = cheat.EspLibrary.settings.enemy
	local enemy_main_sets = cheat.EspLibrary.settings.enemy.main_settings

	
	do
		espsec:Toggle({Name = "Enabled", Value = false, Flag = "esp_enabled", Callback = function(bool)
			enemy_sets.enabled = bool
			cheat.EspLibrary.icaca()
		end})

		do
			local toggle = espsec:Toggle({Name = "Box", Value = false, Flag = "esp_box", Callback = function(bool)
				enemy_sets.box = bool
				cheat.EspLibrary.icaca()
			end})
			toggle:Colorpicker({Name = "Box color left", Value = Color3.new(1, 1, 1), Usealpha = true, Flag = "esp_box_color_left", Callback = function(color)
				enemy_sets.box_color[1] = color.c
				enemy_sets.box_color[3] = color.a
				cheat.EspLibrary.icaca()
			end})
			toggle:Colorpicker({Name = "Box color right", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "esp_box_color_right", Callback = function(color)
				enemy_sets.box_color[2] = color.c
				cheat.EspLibrary.icaca()
			end})
			espsec:Slider({Name = "Box rotation", Min = 0, Max = 20, Float = 0.1, Value = 0, Flag = "esp_box_rotation", Callback = function(int)
				enemy_sets.box_rotation = int * 18
				cheat.EspLibrary.icaca()
			end})
		end

		do
			local toggle = espsec:Toggle({Name = "Health bar", Value = false, Flag = "esp_health_bar", Callback = function(bool)
				enemy_sets.health_bar = bool
				cheat.EspLibrary.icaca()
			end})
			toggle:Colorpicker({Name = "Bar color top", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "esp_health_bar_color_top", Callback = function(color)
				enemy_sets.health_bar_color[1] = color.c
				cheat.EspLibrary.icaca()
			end})
			toggle:Colorpicker({Name = "Bar color bottom", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "esp_health_bar_color_bottom", Callback = function(color)
				enemy_sets.health_bar_color[2] = color.c
				cheat.EspLibrary.icaca()
			end})
		end

		for _, element in {
			{"Name", "name"},
			{"Distance", "distance"},
			{"Weapon", "weapon"},
			{"Health text", "health_text"},
			{"Flags", "flags"},
			{"Skeleton", "skeleton"},
			} do
			espsec:Toggle({Name = element[1], Value = false, Flag = `esp_{element[2]}`, Callback = function(bool)
				enemy_sets[element[2]] = bool
				cheat.EspLibrary.icaca()
			end}):Colorpicker({Name = `{element[1]} color`, Value = Color3.new(1, 1, 1), Usealpha = true, Flag = `esp_{element[2]}_color`, Callback = function(color)
				enemy_sets[`{element[2]}_color`] = {color.c, color.a}
				cheat.EspLibrary.icaca()
			end})
		end

		espsec:Slider({Name = "Skeleton update rate", Min = 0, Max = 1, Float = 0.01, Value = 0, Flag = "esp_skeleton_rate", Callback = function(int)
			enemy_main_sets.skeleton_rate = int
			cheat.EspLibrary.icaca()
		end})

		espsec:Toggle({Name = "Chams", Value = false, Flag = "esp_chams", Callback = function(bool)
			enemy_sets.chams = bool
			cheat.EspLibrary.icaca()
		end})
		espsec:Colorpicker({Name = "Chams color", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "esp_chams_color", Callback = function(color)
			enemy_sets.chams_color = {color.c, color.a}
			cheat.EspLibrary.icaca()
		end})
		espsec:Slider({Name = "Chams glow factor", Min = 0, Max = 100, Float = 0.1, Value = 3, Flag = "esp_chams_glow_factor", Callback = function(int)
			enemy_sets.chams_glow_factor = int
			cheat.EspLibrary.icaca()
		end})
	end
	do
		local player_list = cheat.player_list
		local flag_settings = {
			["Target"] = false,
			["Team"] = false,
			["Friend"] = false,
			["Forcefield"] = false,
			["Premium"] = false
		}
		setsec:Dropdown({Name = "Flags", Values = {"Target", "Team", "Friend", "Forcefield", "Premium"}, Value = {}, Flag = "esp_selected_flags", Multi = true, Callback = function(tbl)
			for flag, value in flag_settings do
				flag_settings[flag] = false
			end
			for _, flag in tbl do
				flag_settings[flag] = true
			end
		end})

		local get_team = cheat.EspLibrary.get_team
		cheat.EspLibrary.register_flag("TARGET", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			return flag_settings["Target"] and player == target_player
		end))
		cheat.EspLibrary.register_flag("TEAM", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			return flag_settings["Team"] and get_team(player)
		end))
		cheat.EspLibrary.register_flag("FRIEND", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			return flag_settings["Friend"] and player_list[player] and player_list[player].friend
		end))
		cheat.EspLibrary.register_flag("FF", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			return flag_settings["Forcefield"] and not not _FindFirstChildOfClass(character, "ForceField")
		end))
		cheat.EspLibrary.register_flag("PREM", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			return flag_settings["Premium"] and player_list[player] and player_list[player].premium
		end))
	end
	do
		setsec:Dropdown({Name = "Checks", Values = {"Team check", "Dead check", "Distance check"}, Value = {}, Flag = "esp_checks", Multi = true, Callback = function(tbl)
			local funny = {
				["Team check"] = "team_check",
				["Dead check"] = "dead_check",
				["Distance check"] = "dist_check"
			}
			for flag_text, esp_var in funny do
				enemy_main_sets[esp_var] = false
			end
			for flag_text, esp_var in funny do -- O^2 my beloved... its 3 elements so i don't really care (9)
				for _, check_name in tbl do
					if (check_name ~= flag_text or enemy_main_sets[esp_var]) then
						continue
					end
					enemy_main_sets[esp_var] = true
					--print(esp_var)
				end
			end
			cheat.EspLibrary.icaca()
		end})
		setsec:Slider({Name = "Max distance", Min = 0, Max = 5000, Float = 100, Value = 600, Flag = "esp_max_distance", Callback = function(int)
			enemy_main_sets.max_distance = int
			cheat.EspLibrary.icaca()
		end})
		setsec:Toggle({Name = "Gradient spin", Value = false, Flag = "esp_gradient_spin", Callback = function(bool)
			enemy_main_sets.gradient_spin = bool
			cheat.EspLibrary.icaca()
		end})
		setsec:Slider({Name = "Gradient speed", Min = -20, Max = 20, Float = 0.1, Value = 0, Flag = "esp_gradient_speed", Callback = function(int)
			enemy_main_sets.gradient_speed = int * 18
			cheat.EspLibrary.icaca()
		end})
		setsec:Toggle({Name = "Holder spin", Value = false, Flag = "esp_holder_spin", Callback = function(bool)
			enemy_main_sets.holder_spin = bool
			cheat.EspLibrary.icaca()
		end})
		setsec:Slider({Name = "Holder speed", Min = -20, Max = 20, Float = 0.1, Value = 0, Flag = "esp_holder_speed", Callback = function(int)
			enemy_main_sets.holder_speed = int * 18
			cheat.EspLibrary.icaca()
		end})
	end
	do
		local old_fov = Camera.FieldOfView
		local fov_changer, fov_changer_size = false, 100
		mscsec:Toggle({Name = "FOV Changer", Value = false, Flag = "view_fov_changer", Callback = function(bool)
			fov_changer = bool
			Camera.FieldOfView = fov_changer and fov_changer_size or old_fov
		end})
		mscsec:Slider({Name = "Desired FOV", Min = 10, Max = 120, Float = 1, Value = 100, Flag = "view_fov_changer_size", Callback = function(int)
			fov_changer_size = int
			Camera.FieldOfView = fov_changer and fov_changer_size or old_fov
		end})
		mscsec:Toggle({Name = "Aspect ratio", Value = false, Flag = "view_aspect_ratio", Callback = function(bool)
			aspect_ratio = bool
		end})
		mscsec:Slider({Name = "Aspect X", Min = 0.01, Max = 1.1, Float = 0.01, Value = 1, Flag = "aspect_ratio_x", Callback = function(int)
			aspect_ratio_x = int
		end})
		mscsec:Slider({Name = "Aspect Y", Min = 0.01, Max = 1.1, Float = 0.01, Value = 1, Flag = "aspect_ratio_y", Callback = function(int)
			aspect_ratio_y = int
		end})
		mscsec:Toggle({Name = "Thirdperson", Value = false, Flag = "view_thirdperson", Callback = function(bool)
			thirdperson = bool
		end}):Keybind({Name = "Thirdperson", Mode = "Toggle", Key = Enum.KeyCode.N, Value = false, Flag = "view_thirdperson_keybind", Callback = function(bool)
			thirdperson_key = bool
		end})
		mscsec:Slider({Name = "Thirdperson distance", Min = 1, Max = 50, Float = 1, Value = 10, Flag = "view_thirdperson_distance", Callback = function(int)
			thirdperson_distance = int
		end})
		Camera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
			if Camera.FieldOfView ~= fov_changer_size then
				old_fov = Camera.FieldOfView
			end
			if not fov_changer then return end 
			Camera.FieldOfView = fov_changer_size
		end)
	end

end

do
	local movebox = ui.sections.movement
	local miscbox = ui.sections.misc
	local itembox = ui.sections.item

	local speedhack, speedhack_key, speedhack_speed = false, false, 100
	local flyhack, flyhack_key, flyhack_speed, flyhack_speed_y = false, false, 100, 100
	local bunnyhop = false

	--[[miscbox:Toggle({Name = "Roll view for spectators", Value = false, Flag = "anti_spectate", Callback = function(bool)
		projectscp.anti_spectate = bool
	end})
	miscbox:Toggle({Name = "Bypass speed restriction", Value = false, Flag = "movement_bypass", Callback = function(bool)
		movement_bypass = bool
	end})
	miscbox:Toggle({Name = "Anti SCP-096", Value = false, Flag = "anti_096", Callback = function(bool)
		projectscp.anti_096 = bool
	end})]]
	miscbox:Button({Name = "Rejoin", Confirm = true, Callback = function()
		if #Players:GetPlayers() <= 1 then
			LocalPlayer:Kick("\nRejoining...")
			wait()
			game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
		else
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
		end
	end})
	miscbox:Toggle({Name = "Bunnyhop", Value = false, Flag = "bunnyhop", Callback = function(bool)
		bunnyhop = bool
	end})

	movebox:Toggle({Name = "Speedhack", Value = false, Flag = "speedhack", Callback = function(bool)
		speedhack = bool
	end}):Keybind({Name = "Speedhack", Mode = "Toggle", Key = Enum.KeyCode.X, Value = false, Flag = "speedhack_key", Callback = function(bool)
		speedhack_key = bool
	end})
	movebox:Slider({Name = "Speedhack speed", Min = 0, Max = 500, Float = 1, Value = 100, Flag = "speedhack_speed", Callback = function(int)
		speedhack_speed = int
	end})

	movebox:Toggle({Name = "Flyhack", Value = false, Flag = "flyhack", Callback = function(bool)
		flyhack = bool
	end}):Keybind({Name = "Flyhack", Mode = "Toggle", Key = Enum.KeyCode.V, Value = false, Flag = "flyhack_key", Callback = function(bool)
		flyhack_key = bool
	end})
	movebox:Slider({Name = "Flyhack speed", Min = 0, Max = 500, Float = 1, Value = 100, Flag = "flyhack_speed", Callback = function(int)
		flyhack_speed = int
	end})
	movebox:Slider({Name = "Flyhack speed Y", Min = 0, Max = 500, Float = 1, Value = 100, Flag = "flyhack_speed_y", Callback = function(int)
		flyhack_speed_y = int
	end})

	cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function(delta)
		local hrp = LocalPlayer.Character and _FindFirstChild(LocalPlayer.Character, "HumanoidRootPart")
		local hum = LocalPlayer.Character and _FindFirstChildOfClass(LocalPlayer.Character, "Humanoid")

		if hum and bunnyhop and _IsKeyDown(UserInputService, Enum.KeyCode.Space) then
			hum.Jump = true
		end
		if not hrp then return end

		local cameralook = (_Vector3new(1, 0, 1) * Camera.CFrame.LookVector).Unit
		local direction = Vector3.zero
		direction = _IsKeyDown(UserInputService, Enum.KeyCode.W) and direction + cameralook or direction;
		direction = _IsKeyDown(UserInputService, Enum.KeyCode.S) and direction - cameralook or direction;
		direction = _IsKeyDown(UserInputService, Enum.KeyCode.D) and direction + _Vector3new(-cameralook.Z, 0, cameralook.X) or direction;
		direction = _IsKeyDown(UserInputService, Enum.KeyCode.A) and direction + _Vector3new(cameralook.Z, 0, -cameralook.X) or direction;
		if direction ~= Vector3.zero then
			direction = direction.Unit
		end
		if flyhack and flyhack_key then
			local ydir = Vector3.zero
			ydir = _IsKeyDown(UserInputService, Enum.KeyCode.Space)	 and ydir + Vector3.yAxis or ydir;
			ydir = _IsKeyDown(UserInputService, Enum.KeyCode.LeftShift) and ydir - Vector3.yAxis or ydir;
			hrp.AssemblyLinearVelocity = _Vector3new(1, 0, 1) * direction * flyhack_speed + flyhack_speed_y * ydir
		elseif speedhack and speedhack_key then
			hrp.AssemblyLinearVelocity = _Vector3new(1, 0, 1) * direction * speedhack_speed + hrp.AssemblyLinearVelocity.Y * Vector3.yAxis
		end
	end))
end

local desync_enabled, desync_enabled_key = false, false
local character, hrp, head
local old_cframe, old_velocity, hrp_offset

do
	local dscsec = ui.sections.custom_desync
	local expsec = ui.sections.exploit

	local desync_visualize = false
	local desync_x_offset, desync_y_offset, desync_z_offset = 0, 0, 0
	local desync_x_rotate, desync_y_rotate, desync_z_rotate = 0, 0, 0
	local desync_random_rotation, desync_random_position = false, false
	local desync_random_position_range = 5

	local desync_velocity = false
	local desync_velocity_x, desync_velocity_y, desync_velocity_z = 0, 0, 0

	local forced_cframe

	local raksync, raksync_key, raksync_replicate_next = false, false, false

	local main_wireframe = Instance.new("WireframeHandleAdornment")
	main_wireframe.Parent = game:GetService("CoreGui").RobloxGui
	main_wireframe.Adornee = workspace
	main_wireframe.Color3 = Color3.new(1, 1, 1)
	main_wireframe.Transparency = 0
	main_wireframe.AlwaysOnTop = true
	main_wireframe.CFrame = CFrame.new()
	main_wireframe.Scale = Vector3.one
	main_wireframe.Thickness = 1
	main_wireframe.AdornCullingMode = Enum.AdornCullingMode.Automatic

	do --if SWG_Note:find("alpha") then
		local original_rate, original_bandwidth = getfflag("S2PhysicsSenderRate"), getfflag("PhysicsSenderMaxBandwidthBps")

		local desync_freeze, desync_freeze_key, desync_freeze_factor = false, false, 100
		local desync_ready, desync_turned_on = true, false

		local set_physics_rate = function(rate, bandwidth)
			print(rate, bandwidth)
			setfflag("S2PhysicsSenderRate", tostring(rate))
			setfflag("PhysicsSenderMaxBandwidthBps", tostring(bandwidth))
		end

		local get_hrp = function()
			local character = LocalPlayer.Character
			return character and _FindFirstChild(character, "HumanoidRootPart")
		end

		local toggle_desync = function(state, reason)
			if not state then
				desync_turned_on = false
				if reason then
					Library.Notification(reason, 2.5)
				end
				return set_physics_rate(original_rate, original_bandwidth)
			end

			local hrp = get_hrp()
			if not hrp then return toggle_desync(false, "No character found.") end

			forced_cframe = nil

			set_physics_rate(32767, 32767 * 32)

			desync_turned_on = true
			RunService.Heartbeat:Wait()

			for _ = 1, 3 do
				hrp.AssemblyLinearVelocity += Vector3.new(0, 1, 0)
				RunService.Heartbeat:Wait()
				if not hrp then
					return toggle_desync(false, "Character destroyed in preparation process.")
				end
			end

			desync_ready = false
			forced_cframe = hrp.CFrame

			local recorded_time = tick()
			repeat until tick() - recorded_time > 0.8

			Library.Notification("Don't move for until this notification goes away.", 3)

			task.wait(3)

			set_physics_rate(15, 15 * 32)

			desync_ready = true
			forced_cframe = nil
		end

		expsec:Toggle({Name = "Freeze desync", Value = false, Flag = "desync_freeze", Callback = function(bool)
			desync_freeze = bool
			if not desync_freeze then
				toggle_desync(false)
			end
		end}):Keybind({Name = "Freeze desync", Mode = "Toggle", Key = Enum.KeyCode.M, Value = false, Flag = "desync_freeze_key", Callback = function(bool)
			if not desync_ready then
				return Library.Notification("Freeze is not ready yet!", 2.5)
			end

			desync_freeze_key = bool
			if desync_freeze then
				task.spawn(toggle_desync, desync_freeze_key)
			end
		end})

		expsec:Slider({Name = "Freeze factor", Min = 0, Max = 500, Float = 10, Value = 100, Flag = "desync_freeze_factor", Callback = function(int)
			desync_freeze_factor = int
		end})

		local old = 0
		local isSleeping = false
		RunService.Heartbeat:Connect(function()
			if not (desync_turned_on) then
				return
			end

			local hrp = get_hrp()
			if not hrp then return end

			local now = tick()
			local factor = 1 / desync_freeze_factor
			if now - old >= factor then
				old = now
				isSleeping = not isSleeping
				sethiddenproperty(hrp, "NetworkIsSleeping", isSleeping)
				--[[sethiddenproperty(LocalPlayer, "MaximumSimulationRadius", 2^1023 * (isSleeping and 1 or -1)) 
				sethiddenproperty(LocalPlayer, "MaxSimulationRadius", 2^1023 * (isSleeping and 1 or -1)) 
				sethiddenproperty(LocalPlayer, "SimulationRadius", 2^1023 * (isSleeping and 1 or -1)) ]]
				--replicatesignal(game.Players.LocalPlayer.SimulationRadiusChanged, 2^1023 * (isSleeping and 1 or -1))
			end
		end)

		--[[RunService.Heartbeat:Connect(function()
			if not (desync_turned_on) then
				return
			end

			local hrp = get_hrp()
			if not hrp then return end

			if (forced_cframe) then
				hrp.CFrame = forced_cframe
				--hrp.AssemblyLinearVelocity = Vector3.zero
			end
		end)]]

		-- this desync was fucking made by D-D-D-D-DJ SWIMDROID
		-- ТЁЛКИ СНИМАЙТЕ ТРУСЫ		
	end
	
	if type(raknet) == "table" then
		expsec:Toggle({Name = "Raksync", Value = false, Flag = "desync_raksync", Callback = function(bool)
			raksync = bool
		end}):Keybind({Name = "Raksync", Mode = "Toggle", Key = Enum.KeyCode.M, Value = false, Flag = "desync_raksync_key", Callback = function(bool)
			raksync_key = bool
		end})
		--setfflag("S2PhysicsSenderRate", "15")

		local function disect(packetData)
			local iter = 0
			local hextable = {}
			local hex = buffer.tostring(packetData):gsub(".", function(char)
				iter += 1
				local st = string.format("%x", char:byte())
				local rs = (#st == 1 and "0" or "") .. st
				hextable[iter - 1] = rs
				return rs .. " " .. (iter % 8 == 0 and "\n" or "")
			end)
			return hextable, hex
		end
		
		local function write_timer(packetData, packet_timer)
			local axx = buffer.create(4)
			buffer.writeu32(axx, 0, packet_timer)
			local packet_timer_hex = disect(axx)
			for i = 0, 3 do
				local n = tonumber(packet_timer_hex[i], 16)
				buffer.writeu8(packetData, 8 - i --[[i + 5]], n)
			end
		end

		local old_packet_data, old_packet_timer
		local packet_timer_manipulation = tick()

		raknet.add_send_hook(function(packetData)
			local packetId = buffer.readu8(packetData, 0)
			if packetId == 0x1B then
				if not (raksync and raksync_key) then
					old_packet_timer = nil
					return true
				end
				
				local hextable, hex = disect(packetData)

				local packet_timer = ""
				local packet_id = ""
				for i = 1, 8 do
					packet_timer ..= hextable[i]
				end
				for i = 9, 16 do
					packet_id ..= hextable[i]
				end
				packet_timer, packet_id = tonumber(packet_timer, 16), tonumber(packet_id, 16)


				if not old_packet_timer then
					old_packet_timer = packet_timer
				end


				packet_timer = old_packet_timer
				write_timer(packetData, packet_timer)
				
				if tick() - packet_timer_manipulation >= 1 then
					old_packet_timer += 1
					packet_timer_manipulation = tick()
					old_packet_data = buffer.fromstring(buffer.tostring(packetData))
					raksync_replicate_next = true
				else
					old_packet_data = nil
					raksync_replicate_next = false
				end

			end
			return true
		end)
	end

	local shitcode, shitcode_tick, shitcode_factor = false, tick(), 60
	expsec:Toggle({Name = "FPS limiter", Flag = "old_swimhub_mode", Value = false, Callback = function(v)
		shitcode = v
		shitcode_tick = tick()
		task.spawn(function()
				while shitcode do
				if tick() - shitcode_tick > 1/shitcode_factor then
					shitcode_tick = tick()
					RunService.RenderStepped:Wait()
				end
			end
		end)
	end})
	expsec:Slider({Name = "FPS Limit", Min = 2, Max = 60, Float = 0.1, Value = 0, Flag = "shitcode_factor", Callback = function(int)
		shitcode_factor = int
	end})

	dscsec:Toggle({Name = "Enabled", Value = false, Flag = "desync_enabled", Callback = function(bool)
		desync_enabled = bool
	end}):Keybind({Name = "Desync", Mode = "Toggle", Key = Enum.KeyCode.B, Value = false, Flag = "desync_enabled_key", Callback = function(bool)
		desync_enabled_key = bool
	end})

	dscsec:Toggle({Name = "Visualize desync", Value = false, Flag = "desync_visualize", Callback = function(bool)
		desync_visualize = bool
	end}):Colorpicker({Name = "Visualization color", Value = Color3.new(1, 1, 1), Usealpha = true, Flag = "desync_visualize_color", Callback = function(color)
		main_wireframe.Color3 = color.c
		main_wireframe.Transparency = color.a
	end})

	dscsec:Slider({Name = "X offset", Min = -10, Max = 10, Float = 0.1, Value = 0, Flag = "desync_x_offset", Callback = function(int)
		desync_x_offset = int
	end})
	dscsec:Slider({Name = "Y offset", Min = -10, Max = 10, Float = 0.1, Value = 0, Flag = "desync_y_offset", Callback = function(int)
		desync_y_offset = int
	end})
	dscsec:Slider({Name = "Z offset", Min = -10, Max = 10, Float = 0.1, Value = 0, Flag = "desync_z_offset", Callback = function(int)
		desync_z_offset = int
	end})

	dscsec:Slider({Name = "X rotate", Min = 0, Max = 20, Float = 0.1, Value = 0, Flag = "desync_x_rotate", Callback = function(int)
		desync_x_rotate = math.rad(int * 18)
	end})
	dscsec:Slider({Name = "Y rotate", Min = 0, Max = 20, Float = 0.1, Value = 0, Flag = "desync_y_rotate", Callback = function(int)
		desync_y_rotate = math.rad(int * 18)
	end})
	dscsec:Slider({Name = "Z rotate", Min = 0, Max = 20, Float = 0.1, Value = 0, Flag = "desync_z_rotate", Callback = function(int)
		desync_z_rotate = math.rad(int * 18)
	end})

	dscsec:Toggle({Name = "Random rotation", Value = false, Flag = "desync_random_rotation", Callback = function(bool)
		desync_random_rotation = bool
	end})
	dscsec:Toggle({Name = "Random position", Value = false, Flag = "desync_random_position", Callback = function(bool)
		desync_random_position = bool
	end})
	dscsec:Slider({Name = "Random range", Min = 0, Max = 25, Float = 0.1, Value = 0, Flag = "desync_random_position_range", Callback = function(int)
		desync_random_position_range = int
	end})

	dscsec:Toggle({Name = "Velocity desync", Value = false, Flag = "desync_velocity", Callback = function(bool)
		desync_velocity = bool
	end})
	dscsec:Slider({Name = "Velocity X", Min = -16384, Max = 16384, Float = 512, Value = 0, Flag = "desync_velocity_x", Callback = function(int)
		desync_velocity_x = int
	end})
	dscsec:Slider({Name = "Velocity Y", Min = -16384, Max = 16384, Float = 512, Value = 0, Flag = "desync_velocity_y", Callback = function(int)
		desync_velocity_y = int
	end})
	dscsec:Slider({Name = "Velocity Z", Min = -16384, Max = 16384, Float = 512, Value = 0, Flag = "desync_velocity_z", Callback = function(int)
		desync_velocity_z = int
	end})

	RunService.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
		character = LocalPlayer.Character
		if not character then return end
		humanoid = _FindFirstChildOfClass(character, "Humanoid")
		hrp = _FindFirstChild(character, "HumanoidRootPart")
		head = _FindFirstChild(character, "Head")
		if not (humanoid and hrp) then return end
		if not (desync_enabled and desync_enabled_key) then return end
		if (forced_cframe) then return end

		old_cframe = hrp.CFrame
		old_velocity = hrp.AssemblyLinearVelocity

		if (raksync and raksync_key) and (not raksync_replicate_next) then return end
		
		hrp_offset = _CFramenew(
			desync_x_offset,
			desync_y_offset,
			desync_z_offset
		) * CFrame.Angles(
			desync_x_rotate,
			desync_y_rotate,
			desync_z_rotate
		)
		if desync_random_position then
			hrp_offset = hrp_offset + (
				CFrame.Angles(
					(mathrandom() - mathrandom()) * 2 * math.pi,
					(mathrandom() - mathrandom()) * 2 * math.pi,
					(mathrandom() - mathrandom()) * 2 * math.pi
				) * CFrame.new(0, 0, -desync_random_position_range)
			).Position
		end
		if desync_random_rotation then
			hrp_offset = hrp_offset * CFrame.Angles(
				(mathrandom() - mathrandom()) * 2 * math.pi,
				(mathrandom() - mathrandom()) * 2 * math.pi,
				(mathrandom() - mathrandom()) * 2 * math.pi
			)
		end

		hrp.CFrame = old_cframe * hrp_offset
		if desync_velocity then
			hrp.AssemblyLinearVelocity = _Vector3new(
				desync_velocity_x,
				desync_velocity_y,
				desync_velocity_z
			)
		end

		RunService.RenderStepped:Wait()
		if not hrp then return end

		hrp.CFrame = old_cframe
		if desync_velocity then
			hrp.AssemblyLinearVelocity = old_velocity
		end
	end))

	local VERTICES = {
		-- left face
		_Vector3new(-1,-1,-1), _Vector3new(-1, 1,-1),
		_Vector3new(-1, 1,-1), _Vector3new(-1, 1, 1),
		_Vector3new(-1, 1, 1), _Vector3new(-1,-1, 1),
		_Vector3new(-1,-1, 1), _Vector3new(-1,-1,-1),
		-- right face
		_Vector3new( 1,-1,-1), _Vector3new( 1, 1,-1),
		_Vector3new( 1, 1,-1), _Vector3new( 1, 1, 1),
		_Vector3new( 1, 1, 1), _Vector3new( 1,-1, 1),
		_Vector3new( 1,-1, 1), _Vector3new( 1,-1,-1),
		-- connections
		_Vector3new(-1,-1,-1), _Vector3new( 1,-1,-1),
		_Vector3new(-1, 1,-1), _Vector3new( 1, 1,-1),
		_Vector3new(-1, 1, 1), _Vector3new( 1, 1, 1),
		_Vector3new(-1,-1, 1), _Vector3new( 1,-1, 1),
	}

	local function isBodyPart(name)
		return name == "Head" or name:find("Torso") or name:find("Leg") or name:find("Arm") or name:find("Hand") or name:find("Foot")
	end

	cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function(delta)
		main_wireframe:Clear()

		if not (desync_visualize) then return end
		if not (desync_enabled and desync_enabled_key) then return end
		if not (old_cframe and hrp_offset) then return end

		local character = LocalPlayer.Character
		if not (character) then return end

		local parts = {}
		local c = 0
		for _, v in character:GetChildren() do
			if v:IsA("BasePart") and isBodyPart(v.Name) then
				c += 1
				parts[c] = {v.CFrame, v.Size}
			end
		end
		if c == 0 then return end

		local points = {}
		c = 0
		for _, part in parts do
			for _, vertex in VERTICES do
				c += 1
				points[c] = (old_cframe * hrp_offset):PointToWorldSpace(
					old_cframe:PointToObjectSpace(part[1]:PointToWorldSpace(vertex * part[2] * 0.5))
				) - workspace.WorldPivot.Position
			end
		end

		main_wireframe:AddLines(points)
	end))
end

do
	local worldbox = ui.sections.world_main_changer
	local miscbox = ui.sections.world_misc_changer
	do
		local lighting_changer, lighting_changing = false, false
		local old_lighting = {
			Ambient = Lighting.Ambient,
			OutdoorAmbient = Lighting.OutdoorAmbient,
			Brightness = Lighting.Brightness,
			ColorShift_Bottom = Lighting.ColorShift_Bottom,
			ColorShift_Top = Lighting.ColorShift_Top,
			GlobalShadows = Lighting.GlobalShadows,
			FogColor = Lighting.FogColor,
			FogEnd = Lighting.FogEnd,
			FogStart = Lighting.FogStart,
			ClockTime = Lighting.ClockTime,
		}
		local lighting_values = {
			Ambient = Color3.fromRGB(70, 70, 70),
			OutdoorAmbient = Color3.fromRGB(70, 70, 70),
			Brightness = 3,
			ColorShift_Bottom = Color3.new(),
			ColorShift_Top = Color3.new(),
			GlobalShadows = true,
			FogColor = Color3.fromRGB(192, 192, 192),
			FogEnd = 10000,
			FogStart = 0,
			ClockTime = 14.5,
		}

		local append_changes = function()
			lighting_changing = true
			for k, v in (lighting_changer and lighting_values or old_lighting) do
				Lighting[k] = v
			end
			lighting_changing = false
		end

		worldbox:Toggle({Name = 'Lighting changer', Flag = 'world_lighting_changer', Value = false, Callback = function(first)
			lighting_changer = first
			append_changes()
		end})
		worldbox:Colorpicker({Name = 'Ambient', Flag = 'world_lighting_ambient', Value = Color3.fromRGB(70, 70, 70), Usealpha = false, Callback = function(Value)
			lighting_values.Ambient = Value.c
			append_changes()
		end})
		worldbox:Colorpicker({Name = 'OutdoorAmbient', Flag = 'world_lighting_outdoorambient', Value = Color3.fromRGB(70, 70, 70), Usealpha = false, Callback = function(Value)
			lighting_values.OutdoorAmbient = Value.c
			append_changes()
		end})
		worldbox:Slider({Name = 'Brightness', Flag = 'world_lighting_brightness', Value = 1, Min = -5, Max = 15, Float = 0.01, Callback = function(State)
			lighting_values.Brightness = State
			append_changes()
		end})
		worldbox:Colorpicker({Name = 'ColorShift_Bottom', Flag = 'world_lighting_colorshift_bottom', Value = Color3.new(), Usealpha = false, Callback = function(Value)
			lighting_values.ColorShift_Bottom = Value.c
			append_changes()
		end})
		worldbox:Colorpicker({Name = 'ColorShift_Top', Flag = 'world_lighting_colorshift_top', Value = Color3.new(), Usealpha = false, Callback = function(Value)
			lighting_values.ColorShift_Bottom = Value.c
			append_changes()
		end})
		worldbox:Toggle({Name = 'GlobalShadows', Flag = 'world_lighting_globalshadows', Value = true, Callback = function(first)
			lighting_values.GlobalShadows = first
			append_changes()
		end})

		worldbox:Colorpicker({Name = 'FogColor', Flag = 'world_lighting_fogcolor', Value = Color3.fromRGB(192, 192, 192), Usealpha = false, Callback = function(Value)
			lighting_values.FogColor = Value.c
			append_changes()
		end})
		worldbox:Slider({Name = 'FogEnd', Flag = 'world_lighting_fogend', Value = 100,Min = 0,Max = 10000,Float = 100,Callback = function(State)
			lighting_values.FogEnd = State
			append_changes()
		end})
		worldbox:Slider({Name = 'FogStart', Flag = 'world_lighting_fogstart', Value = 0,Min = 0,Max = 10000,Float = 100,Callback = function(State)
			lighting_values.FogStart = State
			append_changes()
		end})

		worldbox:Slider({Name = 'ClockTime', Flag = 'world_lighting_clocktime', Value = 14.5,Min = 0,Max = 24,Float = 0.1,Callback = function(State)
			lighting_values.ClockTime = State
			append_changes()
		end})

		for _, method in {"Ambient", "OutdoorAmbient", "Brightness", "ColorShift_Bottom", "ColorShift_Top", "GlobalShadows", "FogColor", "FogEnd", "FogStart", "ClockTime"} do
			Lighting:GetPropertyChangedSignal(method):Connect(function()
				if not lighting_changing then
					old_lighting[method] = Lighting[method]
				end
				if not lighting_changer then return end
				Lighting[method] = lighting_values[method]
			end)
		end
	end

	do
		do
			local atmosphere = _FindFirstChildOfClass(Lighting, "Atmosphere")
			if not atmosphere then
				atmosphere = Instance.new("Atmosphere")
				atmosphere.Parent = Lighting
				--print('had to make a new atmosphere... collar is blue but reck is ned')
			end
			local atmosphere_changer, atmosphere_changing = false, false
			local old_atmosphere = {
				Density = atmosphere.Density,
				Offset = atmosphere.Offset,
				Color = atmosphere.Color,
				Decay = atmosphere.Decay,
				Glare = atmosphere.Glare,
				Haze = atmosphere.Haze
			}
			local atmosphere_values = {
				Density = 0.28,
				Offset = 1,
				Color = Color3.new(1, 1, 1),
				Decay = Color3.new(0.8, 0.8, 0.8),
				Glare = 1,
				Haze = 1
			}

			local append_changes = function()
				atmosphere_changing = true
				for k, v in (atmosphere_changer and atmosphere_values or old_atmosphere) do
					atmosphere[k] = v
				end
				atmosphere_changing = false
			end

			miscbox:Toggle({Name = 'Atmosphere changer', Flag = 'world_atmosphere_changer', Value = false,Callback = function(first)
				atmosphere_changer = first
				append_changes()
			end})
			miscbox:Slider({Name = 'Density', Flag = 'world_atmosphere_density', Value = 0.9,Min = 0,Max = 1,Float = 0.01,Callback = function(State)
				atmosphere_values.Density = State
				append_changes()
			end})
			miscbox:Slider({Name = 'Offset', Flag = 'world_atmosphere_offset', Value = 1,Min = 0,Max = 1,Float = 0.01,Callback = function(State)
				atmosphere_values.Offset = State
				append_changes()
			end})
			miscbox:Colorpicker({Name = 'Color', Flag = 'world_atmosphere_color', Value = Color3.new(1, 1, 1), Usealpha = false, Callback = function(Value)
				atmosphere_values.Color = Value.c
				append_changes()
			end})
			miscbox:Colorpicker({Name = 'Decay', Flag = 'world_atmosphere_decay', Value = Color3.new(0.8, 0.8, 0.8), Usealpha = false, Callback = function(Value)
				atmosphere_values.Decay = Value.c
				append_changes()
			end})
			miscbox:Slider({Name = 'Glare', Flag = 'world_atmosphere_glare', Value = 1,Min = 0,Max = 20,Float = 0.1,Callback = function(State)
				atmosphere_values.Glare = State
				append_changes()
			end})
			miscbox:Slider({Name = 'Haze', Flag = 'world_atmosphere_haze', Value = 1,Min = 0,Max = 20,Float = 0.1,Callback = function(State)
				atmosphere_values.Haze = State
				append_changes()
			end})

			for _, method in {"Density", "Offset", "Color", "Decay", "Glare", "Haze"} do
				atmosphere:GetPropertyChangedSignal(method):Connect(function()
					if not atmosphere_changing then
						old_atmosphere[method] = atmosphere[method]
					end
					if not atmosphere_changer then return end
					atmosphere[method] = atmosphere_values[method]
				end)
			end
		end
		do
			local bloom = _FindFirstChildOfClass(Lighting, "BloomEffect")
			if not bloom then
				bloom = Instance.new("BloomEffect")
				bloom.Parent = Lighting
				--print('had to make a new bloom... collar is blue but reck is ned')
			end
			local bloom_changer, bloom_changing = false, false
			local old_bloom = {
				Enabled = bloom.Enabled,
				Intensity = bloom.Intensity,
				Size = bloom.Size,
				Threshold = bloom.Threshold
			}
			local bloom_values = {
				Enabled = 0.28,
				Intensity = 1,
				Size = 56,
				Threshold = 2
			}

			local append_changes = function()
				bloom_changing = true
				for k, v in (bloom_changer and bloom_values or old_bloom) do
					bloom[k] = v
				end
				bloom_changing = false
			end

			miscbox:Toggle({Name = 'Bloom changer', Flag = 'world_bloom_changer', Value = false,Callback = function(first)
				bloom_changer = first
				append_changes()
			end})
			miscbox:Toggle({Name = 'Enabled', Flag = 'world_bloom_enabled', Value = false,Callback = function(first)
				bloom_values.Enabled = first
				append_changes()
			end})
			miscbox:Slider({Name = 'Intensity', Flag = 'world_bloom_intensity', Value = 1,Min = 0,Max = 5,Float = 0.01,Callback = function(State)
				bloom_values.Intensity = State
				append_changes()
			end})
			miscbox:Slider({Name = 'Size', Flag = 'world_bloom_size', Value = 56,Min = 0,Max = 80,Float = 1,Callback = function(State)
				bloom_values.Size = State
				append_changes()
			end})
			miscbox:Slider({Name = 'Threshold', Flag = 'world_bloom_threshold', Value = 2,Min = 0,Max = 10,Float = 0.1,Callback = function(State)
				bloom_values.Threshold = State
				append_changes()
			end})

			for _, method in {"Intensity", "Size", "Threshold"} do
				bloom:GetPropertyChangedSignal(method):Connect(function()
					if not bloom_changing then
						old_bloom[method] = bloom[method]
					end
					if not bloom_changer then return end
					bloom[method] = bloom_values[method]
				end)
			end
		end
	end
end

do
	local Settings = ui.tabs.settings do
		local Main = ui.subtabs.settings_main do
			local Config = ui.sections.settings_config do
				local _, Files = Utility.GetFiles(ConfigFolder, { ".cfg" })
				local LastFiles = Files
				local ConfigName;
				local ConfigList = Config:List({
					Values = Files,
					Value = Files[1] or "",
					Size = 135,
					Name = "",
					Flag = "settings_config_list",
					Search = true,
					Callback = function(v)
						if ConfigName and v then
							ConfigName.Set(v)
						end
					end
				})

				ConfigName = Config:Textbox({
					Name = "Name",
					Value = "",
					Flag = "settings_config_name"
				})

				Config:Button({
					Name = "Save",
					Confirm = true,
					Callback = function()
						local ConfigName = Library.Flags["settings_config_name"]

						if ConfigName and ConfigName ~= "" then
							local ConfigFilePath = string.format("%s%s.cfg", ConfigFolder, ConfigName)

							if isfile(ConfigFilePath) then
								writefile(ConfigFilePath, Library:GetConfig())

								Library.Notification(
									string.format( "Successfully saved config (%s.cfg).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)

								local _, Files = Utility.GetFiles(ConfigFolder, { ".cfg" })

								ConfigList.Refresh(Files)

								ConfigList.Set(ConfigName)
							else
								writefile(ConfigFilePath, Library:GetConfig())

								Library.Notification(
									string.format( "Successfully created config (%s.cfg).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)

								local _, Files = Utility.GetFiles(ConfigFolder, { ".cfg" })

								ConfigList.Refresh(Files)

								ConfigList.Set(ConfigName)
							end
						else
							Library.Notification(
								string.format( "Invalid config name (%s).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
							)
						end
					end, 
				})

				Config:Button({
					Name = "Load",
					Confirm = true,
					Callback = function()
						local ConfigName = Library.Flags["settings_config_list"]

						if ConfigName and ConfigName ~= "" then
							local ConfigFilePath = string.format("%s%s.cfg", ConfigFolder, ConfigName)

							if isfile(ConfigFilePath) then
								Library.LoadConfig(readfile(ConfigFilePath))

								Library.Notification(
									string.format( "Successfully loaded config (%s.cfg).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)
							else
								Library.Notification(
									string.format( "Couldn't find config (%s.cfg).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)
							end
						end
					end,
				})

				Config:Button({
					Name = "Delete",
					Confirm = true,
					Callback = function()
						local ConfigName = Library.Flags["settings_config_list"]

						if ConfigName and ConfigName ~= "" then
							local ConfigFilePath = string.format("%s%s.cfg", ConfigFolder, ConfigName)

							if isfile(ConfigFilePath) then
								delfile(ConfigFilePath)

								Library.Notification(
									string.format( "Successfully deleted config (%s.cfg).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)

								local _, Files = Utility.GetFiles(ConfigFolder, { ".cfg" })

								ConfigList.Refresh(Files)

								ConfigList.Set(Files[1] or "")
							end
						end
					end,
				})

				task.spawn(function()
					while task.wait(5) do
						if ui.window.Visible then
							local _, Files = Utility.GetFiles(ConfigFolder, { ".cfg" })

							if #Files ~= #LastFiles then
								LastFiles = Files

								ConfigList.Refresh(Files)

								ConfigList.Set(Files[1] or "")
							end
						end
					end
				end)
			end

			local Personalization = ui.sections.settings_personalization
			do
				local TweenTypes = {}
				for _,v in Enum.EasingStyle:GetEnumItems() do 
					table.insert(TweenTypes, v.Name)
				end
				Personalization:Keybind({Name = "Window Key", Ignore = true, Key = Enum.KeyCode.Delete, Flag = "menu_key", Callback = function()
					ui.window.Open()
				end})

				local Watermark = Library:Watermark({
					titlestart = "swim",
					titleend = "hub"
				})
				local WatermarkText;
				local shitcode, shitcode_tick, shitcode_factor = false, tick(), (mathrandom() - 0.5) * 5
				Personalization:Toggle({Name = "Old swimhub mode", Flag = "old_swimhub_mode", Value = false, Callback = function(v)
					shitcode = v
					shitcode_tick = tick()
					while shitcode do
						if tick() - shitcode_tick > 1/(21 + shitcode_factor) then
							shitcode_tick = tick()
							shitcode_factor = (mathrandom() - 0.5) * 5
							RunService.RenderStepped:Wait()
						end
					end
				end})
				Personalization:Toggle({Name = "Watermark", Flag = "menu_watermark", Value = true, Callback = function(v)
					Watermark.SetVisible(v)
					if WatermarkText then
						WatermarkText.State(v)
					end
				end})
				WatermarkText = Personalization:Textbox({
					Name = "Watermark Text",
					Value = "ping: {ping}ms | fps: {fps} | user: {user} | {date}",
					Flag = "menu_watermark_text",
					Callback = function(v)
						Watermark.SetText(v)
					end
				}) 
				Personalization:Toggle({Name = "Keybind List", Flag = "menu_keybind_list", Value = true, Callback = function(v)
					Library.KeybindsList.Status(v)
				end})
				Personalization:Slider({Name = "Animations", Min = 0, Max = 100, Value = 40, Flag = "menu_animation_speed", Callback = function(v)
					Library.TweenSpeed = v / 100
				end})
				Personalization:Dropdown({Name = "", Values = TweenTypes, Value = "Exponential", Flag = "menu_animation_type", Callback = function(v)
					Library.TweenStyle = Enum.EasingStyle[v]
				end})
			end
		end
		local Theme = ui.subtabs.settings_theme do
			local ThemeColorpickers = { }

			local Config = ui.sections.theme_config do
				local _, Files = Utility.GetFiles(ThemeFolder, { ".cfg" })
				local LastFiles = Files
				local ThemeName;
				local ThemeList = Config:List({
					Values = Files,
					Value = Files[1] or "",
					Size = 135,
					Name = "",
					Flag = "settings_theme_list",
					Search = true,
					Callback = function(v)
						if ThemeName and v then
							ThemeName.Set(v)
						end
					end
				})
				ThemeName = Config:Textbox({
					Name = "Name",
					Value = "",
					Flag = "settings_theme_name"
				})

				Config:Button({
					Name = "Save",
					Confirm = true,
					Callback = function()
						local ConfigName = Library.Flags["settings_theme_name"]

						if ConfigName and ConfigName ~= "" then
							local ConfigFilePath = string.format("%s%s.cfg", ThemeFolder, ConfigName)

							if isfile(ConfigFilePath) then
								writefile(ConfigFilePath, Library.GetTheme())

								Library.Notification(
									string.format( "Successfully saved theme (%s.theme).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)

								local _, Files = Utility.GetFiles(ThemeFolder, { ".cfg" })

								ThemeList.Refresh(Files)

								ThemeList.Set(ConfigName)
							else
								writefile(ConfigFilePath, Library.GetTheme())

								Library.Notification(
									string.format( "Successfully created theme (%s.theme).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)

								local _, Files = Utility.GetFiles(ThemeFolder, { ".cfg" })

								ThemeList.Refresh(Files)

								ThemeList.Set(ConfigName)
							end
						else
							Library.Notification(
								string.format( "Invalid theme name (%s).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
							)
						end
					end, 
				})

				Config:Button({
					Name = "Load",
					Confirm = true,
					Callback = function()
						local ConfigName = Library.Flags["settings_theme_list"]

						if ConfigName and ConfigName ~= "" then
							local ConfigFilePath = string.format("%s%s.cfg", ThemeFolder, ConfigName)

							if isfile(ConfigFilePath) then
								local Data = Library.GetThemeData(readfile(ConfigFilePath))

								for theme, v in Data do
									ThemeColorpickers[theme].Set({c = v, a = 0})
								end

								Library.Notification(
									string.format( "Successfully loaded theme (%s.theme).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)
							else
								Library.Notification(
									string.format( "Couldn't find theme (%s.theme).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)
							end
						end
					end,
				})

				Config:Button({
					Name = "Delete",
					Confirm = true,
					Callback = function()
						local ConfigName = Library.Flags["settings_theme_list"]

						if ConfigName and ConfigName ~= "" then
							local ConfigFilePath = string.format("%s%s.cfg", ThemeFolder, ConfigName)

							if isfile(ConfigFilePath) then
								delfile(ConfigFilePath)

								Library.Notification(
									string.format( "Successfully deleted theme (%s.theme).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)

								local _, Files = Utility.GetFiles(ThemeFolder, { ".cfg" })

								ThemeList.Refresh(Files)

								ThemeList.Set(Files[1] or "")
							end
						end
					end,
				})

				task.spawn(function()
					while task.wait(5) do
						if ui.window.Visible then
							local _, Files = Utility.GetFiles(ThemeFolder, { ".cfg" })

							if #Files ~= #LastFiles then
								LastFiles = Files

								ThemeList.Refresh(Files)

								ThemeList.Set(Files[1] or "")
							end
						end
					end
				end)
			end

			local Colors = ui.sections.theme_colors do
				for theme, color in pairs(Library.Theme) do
					ThemeColorpickers[theme] = Colors:Colorpicker({Name = Utility.ToTitleCase(theme), Flag = "settings_" .. theme, Usealpha = true, Ignore = true, Value = color, Callback = function(v)
						Library.UpdateTheme(theme, v.c)
					end})
				end
			end
		end
	end
end

local __newindex; __newindex = hookmetamethod(game, "__newindex", newcclosure(LPH_NO_VIRTUALIZE(function(self, idx, val)
	if self == Camera and idx == "CFrame" then
		if thirdperson and thirdperson_key then
			val = val + (val.LookVector * -thirdperson_distance)
		end
		if aspect_ratio then
			val = val * _CFramenew(
				0, 0, 0,
				aspect_ratio_x, 0, 0,
				0, aspect_ratio_y, 0,
				0, 0, 1
			)
		end;
	end
	return __newindex(self, idx, val)
end)))

local __index; __index = hookmetamethod(game, '__index', newcclosure(LPH_NO_VIRTUALIZE(function(self, key)
	if checkcaller() then return __index(self, key) end
	if key == 'CFrame' and (self == hrp or self == head) and desync_enabled and desync_enabled_key and old_cframe then
		if self == hrp then
			return old_cframe or _CFramenew()
		end
		if self == head then
			return old_cframe and old_cframe * _CFramenew(
				0,
				hrp.Size.Y / 2 + head.Size.Y / 2,
				0
			) or _CFramenew()
		end
	end
	return __index(self, key)
end)))

local __namecall; __namecall = hookmetamethod(game, "__namecall", newcclosure(LPH_NO_VIRTUALIZE(function(self,...)
	if checkcaller() then return __namecall(self, ...) end
	local args = {...}
	local method = getnamecallmethod()
	if silent_methods[method] and aimbot_mode == "Silent" then
		local hitpart = target_part
		local traceback = debugtraceback()
		if not (hitpart --[[and (global_vars.stack_check == "" or traceback and traceback:find(global_vars.stack_check))]]) then
			return __namecall(self, ...)
		end
		print(traceback)

		local hitsize = hitpart.Size
		local orgpos = hitpart.Position
		local hitpos = orgpos + _Vector3new(
			(mathrandom() - mathrandom()) * (hitsize.X / 10),
			(mathrandom() - mathrandom()) * (hitsize.Y / 10),
			(mathrandom() - mathrandom()) * (hitsize.Z / 10)
		)

		if method == "Raycast" then
			local origin = args[1]
			local direction = args[2]
			local new_dir = silent_projectionoverride and (hitpos - origin) or (hitpos - origin).Unit * direction.Magnitude
			if silent_wallbang and new_dir.Magnitude >= direction.Magnitude then
				return {
					Instance = hitpart,
					Position = silent_magicbullet and _Vector3new(0/0, 0/0, 0/0) or hitpos,
					Distance = (hitpos - args[1]).Magnitude,
					Normal = (hitpos - orgpos).Unit,
					Material = hitpart.Material
				}
			end
			args[2] = new_dir
			return __namecall(self, unpack(args))
		end

		if method == "ScreenPointToRay" or method == "ViewportPointToRay" then
			local ray = __namecall(self, unpack(args))
			local origin = ray.Origin
			local direction = ray.Direction
			local new_dir = silent_projectionoverride and (hitpos - origin) or (hitpos - origin).Unit * direction.Magnitude
			if silent_wallbang and new_dir.Magnitude >= direction.Magnitude then
				local new_origin = (hitpart.CFrame * CFrame.new(0, hitpart.Size.Y, 0)).Position
				return Ray.new(
					(hitpart.CFrame * CFrame.new(0, hitpart.Size.Y, 0)).Position,
					hitpos - new_origin
				)
			end
			return Ray.new(origin, new_dir)
		end

		local ray = args[1]
		local origin = ray.Origin
		local direction = ray.Direction
		local new_dir = silent_projectionoverride and (hitpos - origin) or (hitpos - origin).Unit * direction.Magnitude
		if silent_wallbang and new_dir.Magnitude >= direction.Magnitude then
			return hitpart, silent_magicbullet and _Vector3new(0/0, 0/0, 0/0) or hitpos, (hitpos - orgpos).Unit, hitpart.Material
		end
		args[1] = Ray.new(origin, new_dir)
		return __namecall(self, unpack(args))
	end
	return __namecall(self, ...)
end)))

cheat.EspLibrary.load()
