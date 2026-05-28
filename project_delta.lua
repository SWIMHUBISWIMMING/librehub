--!native
--!optimize 2


-- FABRICATED VALUES!!!
-- ^^^ this line is official 2 years old

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

local Folder = "moneyblox"
makefolder(Folder)

local ImagesFolder = string.format( "%s\\%s\\", Folder, "Images" )
makefolder(ImagesFolder)

local FontsFolder = string.format( "%s\\%s\\", Folder, "FontsFolder" )
makefolder(FontsFolder)

local HitsoundFolder = string.format( "%s\\%s\\", Folder, "Hitsounds" )
makefolder(HitsoundFolder)

local PicturesOnKillFolder = string.format( "%s\\%s\\", Folder, "PicturesOnKill" )

local CREATE_PRESET_IMAGES = isfolder(PicturesOnKillFolder)
makefolder(PicturesOnKillFolder)

local TempFolder = string.format( "%s\\%s\\", Folder, "TempFolder" )
makefolder(TempFolder)

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

				local temp_TTF = string.format("%s%s.ttf", TempFolder, font)
				local temp_JSON = string.format("%s%s.json", TempFolder, font)
				writefile(temp_TTF, readfile(TTF))
				writefile(temp_JSON, HttpService:JSONEncode({
					name = font,
					faces = {{
						name = "Regular",
						weight = 400,
						style = "normal",
						assetId = getcustomasset(temp_TTF)
					}}
				}))

				Fonts.Data[font] = Font.new(getcustomasset(temp_JSON), Enum.FontWeight.Regular)
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

			for _, v in Library.ConfigFlags do
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
local PicturesOnKill = LPH_JIT(function()
	local RunService = game:GetService("RunService")
	local HttpService = game:GetService("HttpService")
	local TweenService = game:GetService("TweenService")


	local PicturesOnKill = {
		URL = "https://raw.githubusercontent.com/SWIMHUBISWIMMING/librehub/refs/heads/main/assets/",

		DefaultImages = {
			"sigil.png",
			"cat.jpg"
		},

		Data = {}
	}
	do
		local current_image_index = 1
		local max_image_index = 1

		function PicturesOnKill.Reload()
			table.clear(PicturesOnKill.Data)
			current_image_index = 1
			max_image_index = 0

			local Pictures = Utility.GetFiles(PicturesOnKillFolder, { ".png", ".jpg", ".jpeg", ".webm" })

			for i, Picture in Pictures do
				max_image_index += 1
				PicturesOnKill.Data[max_image_index] = getcustomasset(Picture)
			end
		end

		function PicturesOnKill.GetNextPicture()
			if max_image_index < 1 then
				return
			end

			local Picture = PicturesOnKill.Data[current_image_index]
			
			current_image_index += 1

			if current_image_index > max_image_index then
				current_image_index = 1
			end

			return Picture
		end

		if not CREATE_PRESET_IMAGES then
			for _, image in PicturesOnKill.DefaultImages do
				local Picture = string.format("%s%s", PicturesOnKillFolder, image)
				if not isfile(Picture) then
					local success, data = pcall(function()
						return game:HttpGet( string.format( "%s%s", Images.URL, image ) )
					end)
					if success and data then
						writefile(Picture, base64_decode(data))
					end
				end
			end
		end

		PicturesOnKill.Reload()
	end
	
	return PicturesOnKill
end)();


local cloneref = cloneref or function(...) return ... end
local checkcaller = checkcaller
local getnamecallmethod = getnamecallmethod
local getcallingscript = getcallingscript
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
local tick = tick

local workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local GuiInset = game:GetService("GuiService"):GetGuiInset()
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

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
	hooks = {},
	hitsounds = {}
}

do
	local sounds = {}
	for name, id in {
        Bameware = "rbxassetid://3124331820",
        Bell = "rbxassetid://6534947240",
        Bubble = "rbxassetid://6534947588",
        Pick = "rbxassetid://1347140027",
        Pop = "rbxassetid://198598793",
        Rust = "rbxassetid://1255040462",
        Sans = "rbxassetid://3188795283",
        Fart = "rbxassetid://130833677",
        Big = "rbxassetid://5332005053",
        Vine = "rbxassetid://5332680810",
        Bruh = "rbxassetid://4578740568",
        Skeet = "rbxassetid://5633695679",
        Neverlose = "rbxassetid://6534948092",
        Fatality = "rbxassetid://6534947869",
        Bonk = "rbxassetid://5766898159",
        Minecraft = "rbxassetid://4018616850",
    } do
		local sound = Instance.new("Sound")
		sound.SoundId = id
		cheat.hitsounds[name] = sound
		table.insert(sounds, sound)
	end

	task.spawn(function()
		game:GetService("ContentProvider"):PreloadAsync(sounds, function(...)end)
	end)
end

local project_delta = {
	fps_object = nil,
	fps_hooks = {},
	fps_module = require(game:GetService("ReplicatedStorage").Modules.FPS),
	universaltable_module = require(game:GetService("ReplicatedStorage").Modules:WaitForChild("UniversalTables")),
	reload_remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Reload"),
	equip_remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Equip"),
	updatetilt_remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UpdateTilt"),
	inventorymove_remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InventoryMove"),
	aizones = workspace:WaitForChild("AiZones"),
	droppeditems = workspace:WaitForChild("DroppedItems"),
	itemslist = game:GetService("ReplicatedStorage"):WaitForChild("ItemsList"),
	hitboxes_priority = {
		"FaceHitBox",
		"HeadTopHitBox",
		"Head",
		"UpperTorso",
		"LowerTorso",
		"LeftUpperArm",
		"LeftLowerArm",
		"LeftHand",
		"RightUpperArm",
		"RightLowerArm",
		"RightHand",
		"RightUpperLeg",
		"RightLowerLeg",
		"RightFoot",
		"LeftUpperLeg",
		"LeftLowerLeg",
		"LeftFoot"
	},
	hitboxes = {
		["FaceHitBox"] = true,
		["HeadTopHitBox"] = true,
		["Head"] = true,
		["UpperTorso"] = true,
		["LowerTorso"] = true,
		["LeftUpperArm"] = true,
		["LeftLowerArm"] = true,
		["LeftHand"] = true,
		["RightUpperArm"] = true,
		["RightLowerArm"] = true,
		["RightHand"] = true,
		["RightUpperLeg"] = true,
		["RightLowerLeg"] = true,
		["RightFoot"] = true,
		["LeftUpperLeg"] = true,
		["LeftLowerLeg"] = true,
		["LeftFoot"] = true
	}
}

for i, v in getgc(true) do
	if type(v) == "table" then
		if rawget(v, "springs") and rawget(v, "characterAnimations") then
			project_delta.fps_object = v
		end
		if type(rawget(v, "RangedWeaponDefault")) == "function" and type(rawget(v, "MeleeWeaponDefault")) == "function" then
			project_delta.fps_usetypes = v
		end
		if rawget(v, "loadByHand") and type(rawget(v, "magazine")) == "function" then
			--[[print("got reload")
			table.foreach(v, print)]]
			project_delta.fps_reloadtypes = v
		end
	end
end

-- from desync section
local desync_enabled, desync_enabled_key = false, false
local old_cframe, old_velocity, replicated_hrp_cframe, forced_cframe

do
	project_delta.fps_bindable = Instance.new("BindableEvent")

	project_delta.add_fps_hook = function(f)
		project_delta.fps_bindable.Event:Connect(f)
	end

	local fps_module = project_delta.fps_module
	local old = fps_module.new

	project_delta.update_fps = getupvalue(old, 5)
	project_delta.remove_bullet = getupvalue(project_delta.fps_usetypes.RangedWeaponDefault, 4)

	fps_module.new = function(player, character)
		local returns = old(player, character)
		task.delay(0.5, function()
			project_delta.fps_object = returns
			project_delta.fps_bindable:Fire()
		end)
		return returns
	end

	local player_folder = game:GetService("ReplicatedStorage"):WaitForChild("Players")
	local local_game_data = player_folder:WaitForChild(LocalPlayer.Name, 9e9)

	project_delta.local_game_data = local_game_data

	project_delta.FindFirstChildOfSlotType = LPH_NO_VIRTUALIZE(function(instance, slottype)
		for _, v in instance:GetChildren() do
			if v:GetAttribute("SlotType") == slottype then
				return v
			end
			if v:GetAttribute("Slot") == slottype then
				return v
			end
		end
	end)

	local findfirstchildofslottype = project_delta.FindFirstChildOfSlotType
	project_delta.get_visor_status = LPH_NO_VIRTUALIZE(function(inventory)
		local helmet_visor = findfirstchildofslottype(inventory, "ClothingHeadware")
		if not helmet_visor then
			return false
		end

		local attachments = _FindFirstChild(helmet_visor, "Attachments")
		if not attachments then
			return false
		end

		if not attachments:GetAttribute("Visor") then
			return false
		end

		helmet_visor = findfirstchildofslottype(attachments, "Visor")

		return (helmet_visor and helmet_visor:GetAttribute("Toggle") or false)
	end)

	project_delta.get_current_magazine = LPH_NO_VIRTUALIZE(function(gun)
		return findfirstchildofslottype(gun, "Magazine")
	end)
	

	project_delta.calculate_speed = LPH_NO_VIRTUALIZE(function(hrp)
		local external_mod = hrp:GetAttribute("MovementModifier")
		local movement_mod = project_delta.fps_object and project_delta.fps_object.movementModifier or 0
		local total_mod = external_mod + math.clamp(movement_mod, -10, 0)
		if local_game_data.Status.GameplayVariables.Buffs:GetAttribute("SerumRed") then
			total_mod = total_mod * 0.5 + 1
		end
		return 18.2 + total_mod
	end)

	project_delta.get_compatible_mag = LPH_NO_VIRTUALIZE(function(fps_object)
		local chosen_mag, loaded_mag_ammo = nil, 0
		local compatable_mags = fps_object.itemProperties.CompatibleMagazines
		for _, container in local_game_data.Inventory:GetChildren() do
			local inventory = _FindFirstChild(container, "Inventory")
			if not inventory then continue end
			for _, item in inventory:GetChildren() do
				if not compatable_mags:GetAttribute(item.Name) then continue end

				local loaded_ammo = item:GetAttribute("LoadedAmmo") or 0
				if chosen_mag and (loaded_ammo <= 0 or loaded_mag_ammo >= loaded_ammo) then continue end

				chosen_mag = item
				loaded_mag_ammo = loaded_ammo
			end
		end
		return chosen_mag, loaded_mag_ammo
	end)

	project_delta.get_compatible_ammo = LPH_NO_VIRTUALIZE(function(fps_object, arg_ammo)
		local needed_ammo = fps_object.MaxAmmo - fps_object.Bullets
		local chosen_ammo, ammo_amount = arg_ammo, arg_ammo and arg_ammo:GetAttribute("Amount") or 0

		if needed_ammo <= 0 or (chosen_ammo and ammo_amount) then
			return chosen_ammo, needed_ammo > ammo_amount and ammo_amount or needed_ammo
		end

		local item_properties = fps_object.itemProperties
		local compatible_ammo = item_properties.CompatibleAmmo
		local preferred_ammo = item_properties:GetAttribute("PreferredAmmo")
		for _, container in local_game_data.Inventory:GetChildren() do
			local inventory = _FindFirstChild(container, "Inventory")
			if not inventory then continue end

			for _, item in inventory:GetChildren() do
				if not compatible_ammo:GetAttribute(item.Name) then continue end
				if preferred_ammo and preferred_ammo ~= item.Name then continue end

				local loaded_ammo = (item:GetAttribute("Amount") or 0)
				if chosen_ammo and ammo_amount >= loaded_ammo then continue end

				ammo_amount = loaded_ammo
				chosen_ammo = item
			end
		end

		return chosen_ammo, needed_ammo > ammo_amount and ammo_amount or needed_ammo
	end)

	project_delta.get_mags_ammo = LPH_NO_VIRTUALIZE(function()
		local mags, ammo = {}, {}
		for _, container in local_game_data.Inventory:GetChildren() do
			local inventory = _FindFirstChild(container, "Inventory")
			if not inventory then continue end
			for _, item in inventory:GetChildren() do
				local item_prop = item.Value
				if not item_prop then continue end

				local item_type = item_prop:GetAttribute("ItemType")
				if item_type == "Magazine" then
					table.insert(mags, {item:GetAttribute("LoadedAmmo"), item:GetAttribute("AmmoType"), item:GetAttribute("Slot"), item, item_prop})
				elseif item_type == "Ammo" then
					table.insert(ammo, {item:GetAttribute("Amount"), item:GetAttribute("SlotType"), item:GetAttribute("Slot"), item, item_prop})
				end
			end
		end
		return mags, ammo
	end)
	
	local wallpen_params = RaycastParams.new()
	wallpen_params.FilterType = Enum.RaycastFilterType.Include
	wallpen_params.IgnoreWater = true
	wallpen_params.CollisionGroup = "WeaponRay"
	
	local material_ballistics = project_delta.universaltable_module.UniversalTable.MaterialBallistics
	local global_ignorelist_proj = project_delta.universaltable_module.UniversalTable.GlobalIgnoreListProjectile
	
	project_delta.calculate_penetration = LPH_NO_VIRTUALIZE(function(hit_part, hit_position, direction_vector, penetration_power)
		if hit_part:GetAttribute("NoPen") then return 0 end
		
		wallpen_params.FilterDescendantsInstances = { hit_part }

		local backwards_ray_origin = hit_position + direction_vector * 5
		local reverse_direction = -direction_vector
			
		local exit_ray_result = _Raycast(workspace, backwards_ray_origin, reverse_direction * 5, wallpen_params)

		if not exit_ray_result then return 0 end

		local exit_part = exit_ray_result.Instance
		local exit_position = exit_ray_result.Position
		local exit_normal = exit_ray_result.Normal
		local exit_material = exit_ray_result.Material
		local thickness = (exit_position - hit_position).Magnitude
		local material_properties = material_ballistics[exit_material.Name]

		if not material_properties then return 0 end

		local penetration_cost = hit_part:GetAttribute("PenResistance") and hit_part:GetAttribute("PenResistance") * thickness or material_properties.StrengthPerStud * thickness

		if not (penetration_cost and penetration_cost < penetration_power) then return 0 end

		return penetration_power - penetration_cost, hit_position + direction_vector * 0.03
	end)

	local weapon_params = RaycastParams.new()
	weapon_params.FilterType = Enum.RaycastFilterType.Exclude
	weapon_params.IgnoreWater = false
	weapon_params.CollisionGroup = "WeaponRay"

	local calculate_penetration, hitboxes = project_delta.calculate_penetration, project_delta.hitboxes

	project_delta.target_wall_penetration = LPH_NO_VIRTUALIZE(function(origin, target_character, target_part, target_position, bullet_stats)
		local character = LocalPlayer.Character
		weapon_params.FilterDescendantsInstances = { character, Camera, global_ignorelist_proj }

		local penetration_power, muzzle_velocity = bullet_stats:GetAttribute("ArmorPen"), bullet_stats:GetAttribute("MuzzleVelocity")
		
		local direction = (target_position - origin).Unit * muzzle_velocity * 1/120
		while true do
			local raycast_result = _Raycast(workspace, origin, direction, weapon_params)
			
			if not raycast_result then
				origin += direction 
				continue
			end

			local hit_instance, hit_pos = raycast_result.Instance, raycast_result.Position
			
			if _IsDescendantOf(hit_instance, target_character) and hitboxes[hit_instance.Name] then
				return true
			end

			local pen_rem, pen_pos = calculate_penetration(hit_instance, hit_pos, direction, penetration_power)
			penetration_power = pen_rem
			
			if penetration_power <= 0 then
				return false
			end

			origin = pen_pos
		end

		return false
	end)

	local noclip_params = RaycastParams.new()
	noclip_params.FilterType = Enum.RaycastFilterType.Exclude
	noclip_params.IgnoreWater = true
	noclip_params.CollisionGroup = "NoclipRay"

	project_delta.get_estimated_origin = LPH_NO_VIRTUALIZE(function(player, position)
		local character = player.Character
		local leaning_factor = character:GetAttribute("Leaning") or 0
		local hrp = character.HumanoidRootPart
		local hum = character.Humanoid;
		local estimated_camera = (position or (
			player == LocalPlayer and replicated_hrp_cframe and replicated_hrp_cframe.Position or hrp.Position)
		) + (hum:GetAttribute("Crouch") and _Vector3new(0, 0.6, 0, 0) or _Vector3new(0, 1.6, 0, 0))
		if leaning_factor == 0 then
			return estimated_camera
		else
			noclip_params.FilterDescendantsInstances = { workspace.NoCollision, workspace.DroppedItems, Camera }
			local new_camera = _CFramenew(estimated_camera - hrp.CFrame.RightVector * leaning_factor * 1.18).Position
			local result = _Raycast(workspace, estimated_camera, (new_camera - estimated_camera), noclip_params)
			if result then
				return (estimated_camera + result.Position) * 0.8
			else
				return new_camera
			end
		end
	end)
end

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
		for i, v in (args) do
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
		for _, func in (cheat.connections.heartbeats) do
			func(delta)
		end
	end))
	local connection1; connection1 = RunService.PreRender:Connect(LPH_NO_VIRTUALIZE(function(delta)
		for _, func in (cheat.connections.renderstepped) do
			func(delta)
		end
	end))
	cheat.utility.unload = function()
		connection:Disconnect()
		connection1:Disconnect()
		for key, _ in (cheat.connections.heartbeats) do
			cheat.connections.heartbeats[key] = nil
		end
		for key, _ in (cheat.connections.renderstepped) do
			cheat.connections.heartbeats[key] = nil
		end
		for _, drawing in (cheat.drawings) do
			drawing:Remove()
			cheat.drawings[_] = nil
		end
		for hooked, original in (cheat.hooks) do
			if type(original) == "function" then
				hookfunction(hooked, clonefunction(original))
			else
				hookmetamethod(original["instance"], original["metamethod"], clonefunction(original["func"]))
			end
		end
	end
end

local notification_queue = {}

do
    cheat.utility.new_renderstepped(function()
        for i, v in notification_queue do
			Library.Notification(v.text, v.duration)
            notification_queue[i] = nil
        end
    end)
	cheat.utility.new_heartbeat(function()
		Camera = workspace.CurrentCamera
	end)
end


if setfflag then
	setfflag("AdornShadingAPI", "true") -- glowy chamsy
end

LPH_NO_VIRTUALIZE(function()
	local esp_table = {}
	local workspace = game:GetService("Workspace")
	local rservice = game:GetService("RunService")
	local plrs = game:GetService("Players")
	local lplr = plrs.LocalPlayer
	local container = Instance.new("Folder", game:GetService("CoreGui").RobloxGui)
	local gui_inset = game:GetService("GuiService"):GetGuiInset()

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
					npc_check = false,
					max_distance = 1000,
					skeleton_rate = 1e-10,
					gradient_spin = false,
					gradient_speed = 360, -- degrees per second, formula: tick() % 1 * speed
					holder_spin = false,
					holder_speed = 360 -- degrees per second, formula: tick() % 1 * speed
				},

				enabled = false,

				box = false,
				box_outline = false,
				health_bar = false,
				name = false,
				health_text = false,
				distance = false,
				weapon = false,
				skeleton = false,
				flags = false,

				box_color = { Color3.new(1, 1, 1), Color3.new(1, 1, 1), 0 },
				box_outline_color = { Color3.new(1, 1, 1), 0, Color3.new(1, 1, 1), 0 },
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
			},
			item = {
				main_settings = {
					dist_check = true,
					max_distance = 100
				},

				enabled = true,

				distance = true,
				amount = true,
				durability = true,
				durability_bar = true,

				text_color = { Color3.new(1, 1, 1), 0.7 }
			},
			corpse = {
				main_settings = {
					dist_check = false,
					max_distance = 100
				},

				enabled = true,

				distance = true,

				text_color = { Color3.new(1, 1, 1), 0.5 }
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

	local valid_parts = {
		["LeftFoot"] = true,
		["LeftLowerLeg"] = true,
		["LeftUpperLeg"] = true,
		["RightFoot"] = true,
		["RightLowerLeg"] = true,
		["RightUpperLeg"] = true,
		["LeftHand"] = true,
		["LeftLowerArm"] = true,
		["LeftUpperArm"] = true,
		["RightHand"] = true,
		["RightLowerArm"] = true,
		["RightUpperArm"] = true,
		["LowerTorso"] = true,
		["UpperTorso"] = true,
		["Head"] = true
	}

	local function isBodyPart(name)
		return valid_parts[name]
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
		local screen, inBounds = Camera:WorldToScreenPoint(world)
		return _Vector2new(screen.X, screen.Y) + gui_inset, inBounds, screen.Z
	end

	local function calculateCorners(cframe, size)
		local corners = table.create(#VERTICES)
		for i, vertice in VERTICES do
			corners[i] = worldToScreen((cframe + size * 0.5 * vertice).Position)
		end

		return _Vector2zeromin(Camera.ViewportSize, unpack(corners)), _Vector2zeromax(Vector2.zero, unpack(corners))
	end

	local create_esp, create_object_esp, create_corpse_esp, create_item_esp, destroy_esp;

	create_esp = function(plr_instance)
		local is_npc = plr_instance.ClassName == "Model"
		local is_helicopter = is_npc and plr_instance.Name == "MI24V"

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

		esp.create_obj("UIStroke", {
			Parent = main_name,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
		}, obj)

		esp.create_obj("UIStroke", {
			Parent = main_distance,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
		}, obj)

		esp.create_obj("UIStroke", {
			Parent = main_weapon,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
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

		esp.create_obj("UIStroke", {
			Parent = main_health_text,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
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
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalFlex = Enum.UIFlexAlignment.None,
			Padding = UDim.new(0, -2)
		}, obj)


		for i, v in registered_flags do
			local flag = esp.create_obj("TextLabel", {
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
			}, flags_table)
			table.insert(obj, flag)
			esp.create_obj("UIStroke", {
				Parent = flag,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
				LineJoinMode = Enum.LineJoinMode.Miter,
				Color = Color3.new()
			}, obj)
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
		local team_check, dead_check, dist_check, npc_check = main_settings.team_check, main_settings.dead_check, main_settings.dist_check, main_settings.npc_check
		local skeleton_rate = main_settings.skeleton_rate <= 0 and 1e-10 or main_settings.skeleton_rate
		local max_distance, update_skeleton = main_settings.max_distance, settings.skeleton
		local weapon_enabled, box_rotation = settings.weapon, settings.box_rotation

		local gradient_spin, gradient_speed = main_settings.gradient_spin, main_settings.gradient_speed
		local holder_spin, holder_speed = main_settings.holder_spin, main_settings.holder_speed

		local get_team, get_gun = esp_table.get_team, esp_table.get_gun

		local setvis_cache, skeleton_tick = false, 0

		function plr:forceupdate()
			team_check, dead_check, dist_check, npc_check = main_settings.team_check, main_settings.dead_check, main_settings.dist_check, main_settings.npc_check
			skeleton_rate = main_settings.skeleton_rate <= 0 and 1e-10 or main_settings.skeleton_rate
			max_distance, update_skeleton = main_settings.max_distance, settings.skeleton
			weapon_enabled, box_rotation = settings.weapon, settings.box_rotation

			gradient_spin, gradient_speed = main_settings.gradient_spin, main_settings.gradient_speed
			holder_spin, holder_speed = main_settings.holder_spin, main_settings.holder_speed

			main_box_outline_1.Enabled = settings.box_outline
			main_box_outline_1.Color = settings.box_outline_color[1]
			main_box_outline_1.Transparency = settings.box_outline_color[2]

			main_box_outline_2.Enabled = settings.box_outline
			main_box_outline_2.Color = settings.box_outline_color[3]
			main_box_outline_2.Transparency = settings.box_outline_color[4]

			main_box.Enabled = settings.box
			main_box.Transparency = settings.box_color[3]
			main_box_color.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, settings.box_color[1]),
				ColorSequenceKeypoint.new(1, settings.box_color[2])
			}
			main_box_color.Rotation = box_rotation + (gradient_spin and tick() % 1 * gradient_speed or 0)

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

			local conn = part:GetPropertyChangedSignal("Size"):Connect(function()
				if not (cham and part) then return print("MEMORY LEAK!!!!!!", cham, part) end
				cham.Size = part.Size * .95
			end)

			chams_table[part] = {
				cham = cham,
				connection = conn
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

		function plr:unload()
			if not loaded_plrs[plr_instance] then return end
			for i,v in chams_table do
				v.connection:Disconnect()
				chams_table[i] = nil
			end
			for i,v in plr.connections do
				v:Disconnect()
				plr.connections[i] = nil
			end
			for i,v in plr.obj do
				v:Remove()
				plr.obj[i] = nil
			end
			for i,v in plr do
				plr[i] = nil
			end
			loaded_plrs[plr_instance] = nil
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

		if is_npc or plr_instance.Character then character_added(is_npc and plr_instance or plr_instance.Character) end
		if not is_npc then
			plr.connections["character_added"] = plr_instance.CharacterAdded:Connect(character_added)
			plr.connections["character_removing"] = plr_instance.CharacterRemoving:Connect(character_removing)
		end

		plr.render = function(delta, camera_position, current_tick)
			skeleton_tick += delta

			if skeleton_tick > skeleton_rate then
				main_wireframe:Clear()
			end

			if not settings.enabled then
				return plr:togglevis(false)
			end

			if (npc_check) and (is_npc) then
				return plr:togglevis(false)
			end

			character = is_npc and plr_instance or plr_instance.Character
			root = is_helicopter and character.PrimaryPart or character and _FindFirstChild(character, "HumanoidRootPart")
			humanoid = character and _FindFirstChildOfClass(character, "Humanoid")

			if not (character and root and humanoid) then
				return plr:togglevis(false)
			end

			local humanoid_health = is_helicopter and root:GetAttribute("Health") or humanoid.Health
			local humanoid_max_health = is_helicopter and root:GetAttribute("MaxHealth") or humanoid.MaxHealth
			local humanoid_distance = (camera_position - root.Position).Magnitude

			if (not is_npc and team_check) and get_team(plr_instance, character, humanoid) then
				return plr:togglevis(false)
			end

			if (dead_check) and (humanoid_health <= 0) then
				return plr:togglevis(false)
			end

			if (dist_check) and (humanoid_distance > max_distance) then
				return plr:togglevis(false)
			end

			local _, on_screen = _WorldToViewportPoint(Camera, root.Position)

			if not on_screen then
				return plr:togglevis(false)
			end

			local topLeft, bottomRight, cache = nil, nil, table.create(15)
			do
				local count = 0
				for _, part in character:GetChildren() do
					if _IsA(part, "BasePart") and isBodyPart(part.Name) then
						cache[part.Name] = {part.CFrame, part.Size}
						count += 1
					end
				end
				if is_helicopter then
					cache[root.Name] = {root.CFrame, root.Size}
				end
				if count <= 0 then
					return plr:togglevis(false)
				end
				topLeft, bottomRight = calculateCorners(getBoundingBox(cache))
			end

			plr:togglevis(true)

			do
				main_holder.Rotation = holder_spin and current_tick * holder_speed % 360 or 0
				main_box_color.Rotation = box_rotation + (gradient_spin and current_tick * gradient_speed % 360 or 0)
			end

			do
				local pos = topLeft
				local size = bottomRight - topLeft
				main_holder.Position = UDim2.fromOffset(pos.X - gui_inset.X, pos.Y - gui_inset.Y)
				main_holder.Size = UDim2.fromOffset(size.X, size.Y)
			end

			do
				main_distance.Text = mathround(humanoid_distance / 3) .. "m"
				if weapon_enabled then
					local gun = is_npc and "???" or get_gun(plr_instance, character, humanoid)
					if gun then
						main_weapon.Text = gun
						main_weapon.Position = main_distance.Visible and UDim2.new(0.5, 0, 1, 14) or UDim2.new(0.5, 0, 1, 1)
						main_weapon.Visible = true
					else
						main_weapon.Visible = false
					end
				end
			end

			main_health_text.Text = tostring(mathfloor(humanoid_health))
			main_health_bar.Size = UDim2.fromScale(1, 1 - humanoid_health / humanoid_max_health)

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

			if not is_helicopter and update_skeleton and skeleton_tick > skeleton_rate then
				skeleton_tick = skeleton_tick % skeleton_rate
				local root_pos = root.CFrame
				main_wireframe.Adornee = root

				local points = table.create(15 * 2)
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
		end

		plr:forceupdate()
	end
	create_object_esp = function(model)
		--[[if _FindFirstChildOfClass(model, "Humanoid") then
			return model.Name.."'s corpse", _FindFirstChild(model, "UpperTorso")
		end
		if _FindFirstChildOfClass(model, "ObjectValue") then
			
		end]]
		local s = tick()
		while task.wait() and (tick() - s < 1) do
			if _FindFirstChildOfClass(model, "Humanoid") then
				return create_corpse_esp(model)
			end
			if _FindFirstChildOfClass(model, "ObjectValue") then
				return create_item_esp(model)
			end
		end

		print("unidentified object:", model:GetFullName())
	end
	create_corpse_esp = function(object)
		loaded_plrs[object] = {
			obj = {},
			connections = {}
		}

		local plr = loaded_plrs[object]
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

		esp.create_obj("UIListLayout", {
			Parent = main_holder,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder
		}, obj)

		local main_text = esp.create_obj("TextLabel", {
			Parent = main_holder,
			TextStrokeTransparency = 0,
			BorderSizePixel = 0,
			TextSize = 9,
			FontFace = Fonts.Get("SmallestPixel7"),
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(0, 10000, 0, 10),
			Text = object.Name
		}, obj)


		--main_wireframe.Adornee = root

		local settings = esp_table.settings.corpse
		local main_settings = settings.main_settings

		local main_part = _FindFirstChild(object, "UpperTorso")
		local corpse_name = object.Name

		-- god has forgiven me
		local dist_check, max_distance = main_settings.dist_check, main_settings.max_distance
		local distance_enabled = settings.distance

		local setvis_cache = false

		function plr:forceupdate()
			dist_check, max_distance = main_settings.dist_check, main_settings.max_distance
			distance_enabled = settings.distance

			main_holder.Visible = settings.enabled and setvis_cache

			main_text.TextColor3 = settings.text_color[1]
			main_text.TextTransparency = settings.text_color[2]
		end

		function plr:togglevis(bool, fade)
			if setvis_cache == bool then return end
			setvis_cache = bool

			main_holder.Visible = bool
		end

		plr.render = function(delta, camera_position, current_tick)
			if not settings.enabled then
				return plr:togglevis(false)
			end

			main_part = _FindFirstChild(object, "UpperTorso")
			if not (main_part) then
				return plr:togglevis(false)
			end

			local corpse_position = main_part.Position
			local screen_pos, on_screen = _WorldToViewportPoint(Camera, corpse_position)

			if not on_screen then
				return plr:togglevis(false)
			end

			screen_pos = _Vector2new(screen_pos.X, screen_pos.Y)

			local corpse_distance = (camera_position - corpse_position).Magnitude

			if (dist_check) and (corpse_distance > max_distance) then
				return plr:togglevis(false)
			end

			plr:togglevis(true)

			do
				main_holder.Position = UDim2.fromOffset(screen_pos.X - gui_inset.X, screen_pos.Y - gui_inset.Y)

				local text_buffer = ("%*'s corpse"):format(corpse_name)

				if distance_enabled then
					text_buffer ..= (" (%*m)"):format(mathround(corpse_distance / 3))
				end

				main_text.Text = text_buffer
			end
		end

		plr:forceupdate()
	end
	create_item_esp = function(object)
		loaded_plrs[object] = {
			obj = {},
			connections = {}
		}

		local plr = loaded_plrs[object]
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

		esp.create_obj("UIListLayout", {
			Parent = main_holder,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder
		}, obj)

		local main_text = esp.create_obj("TextLabel", {
			Parent = main_holder,
			TextStrokeTransparency = 0,
			BorderSizePixel = 0,
			TextSize = 9,
			FontFace = Fonts.Get("SmallestPixel7"),
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(0, 10000, 0, 10),
			Text = object.Name
		}, obj)

		local durability_holder = esp.create_obj("Frame", {
			Parent = main_holder,
			BackgroundColor3 = Color3.new(),
			BorderSizePixel = 0,
			Size = UDim2.new(0, 50, 0, 3),
			Visible = false
		})

		local current_durability = esp.create_obj("Frame", {
			Parent = durability_holder,
			BackgroundColor3 = Color3.fromRGB(206, 206, 206),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(0, -1, 0, 1)
		})

		local max_durability = esp.create_obj("Frame", {
			Parent = durability_holder,
			AnchorPoint = Vector2.new(1, 0),
			BackgroundColor3 = Color3.fromRGB(197, 60, 62),
			BorderSizePixel = 0,
			Position = UDim2.new(1, -1, 0, 1),
			Size = UDim2.new(0, 1, 0, 1)
		})

		esp.create_obj("UIStroke", {
			Parent = durability_holder,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			LineJoinMode = Enum.LineJoinMode.Miter,
			BorderOffset = UDim.new(0, -1),
			Thickness = 1
		})


		--main_wireframe.Adornee = root

		local settings = esp_table.settings.item
		local main_settings = settings.main_settings

		local main_part, main_value = object.PrimaryPart, _FindFirstChildOfClass(object, "ObjectValue")
		local item_name = object.Name

		-- god has forgiven me
		local dist_check, max_distance = main_settings.dist_check, main_settings.max_distance
		local distance_enabled, amount_enabled, durability_enabled = settings.distance, settings.amount, settings.durability
		local durability_bar_enabled = settings.durability_bar

		local setvis_cache = false

		function plr:forceupdate()
			dist_check, max_distance = main_settings.dist_check, main_settings.max_distance
			distance_enabled, amount_enabled, durability_enabled = settings.distance, settings.amount, settings.durability
			durability_bar_enabled = settings.durability_bar

			main_holder.Visible = settings.enabled and setvis_cache

			durability_holder.Visible = durability_bar_enabled

			main_text.TextColor3 = settings.text_color[1]
			main_text.TextTransparency = settings.text_color[2]
		end

		function plr:togglevis(bool, fade)
			if setvis_cache == bool then return end
			setvis_cache = bool

			main_holder.Visible = bool
		end

		plr.render = function(delta, camera_position, current_tick)
			local main_part, main_value = object.PrimaryPart, _FindFirstChildOfClass(object, "ObjectValue")

			if not (main_part and main_value) then
				return plr:togglevis(false)
			end

			if not settings.enabled then
				return plr:togglevis(false)
			end

			local item_position = main_part.Position
			local screen_pos, on_screen = _WorldToViewportPoint(Camera, item_position)

			if not on_screen then
				return plr:togglevis(false)
			end

			screen_pos = _Vector2new(screen_pos.X, screen_pos.Y)

			local item_distance = (camera_position - item_position).Magnitude

			if (dist_check) and (item_distance > max_distance) then
				return plr:togglevis(false)
			end

			plr:togglevis(true)

			local item_itemlist = main_value.Value
			local item_properties = item_itemlist and _FindFirstChild(item_itemlist, "ItemProperties")
			local item_amount = main_value:GetAttribute("Amount")
			local item_durability = main_value:GetAttribute("Durability")
			local item_maxdurability = main_value:GetAttribute("MaxDurability")
			local item_originalmaxdurability = item_properties and item_properties:GetAttribute("OriginalMaxDurability")
			do
				main_holder.Position = UDim2.fromOffset(screen_pos.X - gui_inset.X, screen_pos.Y - gui_inset.Y)

				local text_buffer = item_name

				if distance_enabled then
					text_buffer ..= (" (%*m)"):format(mathround(item_distance / 3))
				end
				if amount_enabled and item_amount then
					text_buffer ..= (" (%*x)"):format(item_amount)
				end
				if durability_enabled and item_durability and item_maxdurability then
					text_buffer ..= (" (%*/%*)"):format(item_durability, item_maxdurability)
				end

				main_text.Text = text_buffer
			end

			local should_durability = durability_bar_enabled and item_durability and item_maxdurability
			durability_holder.Visible = should_durability
			if should_durability then
				local curr_size = item_durability / item_originalmaxdurability
				local max_size = 1 - item_maxdurability / item_originalmaxdurability
				current_durability.Size = UDim2.new(curr_size, -2, 0, 1)
				max_durability.Size = UDim2.new(max_size, max_size == 0 and 0 or -1, 0, 1)
			end
		end

		plr:forceupdate()
	end

	destroy_esp = function(player)
		if not loaded_plrs[player] then return end
		if loaded_plrs[player].unload then
			return loaded_plrs[player]:unload()
		end
		local plr = loaded_plrs[player]
		for i,v in plr.connections do
			v:Disconnect()
			plr.connections[i] = nil
		end
		for i,v in plr.obj do
			v:Remove()
			plr.obj[i] = nil
		end
		for i,v in loaded_plrs[plr_instance] do
			loaded_plrs[plr_instance][i] = nil
		end
		loaded_plrs[plr_instance] = nil
	end

	function esp_table.load()
		assert(not esp_table.__loaded, "[ESP] already loaded");

		for _, player in plrs:GetPlayers() do
			if lplr ~= player then
				create_esp(player)
			end
		end

		for _, object in project_delta.droppeditems:GetChildren() do
			create_object_esp(object)
		end

		for _, aizone in project_delta.aizones:GetChildren() do
			for _, npc in aizone:GetChildren() do
				create_esp(npc)
			end
		end

		esp_table.connections = {}
		table.insert(esp_table.connections, plrs.PlayerAdded:Connect(create_esp))
		table.insert(esp_table.connections, plrs.PlayerRemoving:Connect(destroy_esp))
		table.insert(esp_table.connections, project_delta.droppeditems.ChildAdded:Connect(create_object_esp))
		table.insert(esp_table.connections, project_delta.droppeditems.ChildRemoved:Connect(destroy_esp))
		for _, aizone in project_delta.aizones:GetChildren() do
			table.insert(esp_table.connections, aizone.ChildAdded:Connect(create_esp))
			table.insert(esp_table.connections, aizone.ChildRemoved:Connect(destroy_esp))
		end

		table.insert(esp_table.connections, cheat.utility.new_renderstepped(function(delta)
			local camera_position = Camera.CFrame.Position
			local current_tick = tick()
			for _, plr in loaded_plrs do
				plr.render(delta, camera_position, current_tick)
			end
		end))

		esp_table.__loaded = true;
	end

	function esp_table.unload()
		assert(esp_table.__loaded, "[ESP] not loaded yet");

		for player, v in next, loaded_plrs do
			destroy_esp(player)
		end

		for _, connection in esp_table.connections do
			connection:Disconnect()
		end

		esp_table.__loaded = false;
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
				local pos, on_screen = _WorldToViewportPoint(camera, target_part.CFrame.Position)
				if not on_screen then
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

do
	local vischeck_params = RaycastParams.new()
	vischeck_params.FilterType = Enum.RaycastFilterType.Exclude
	vischeck_params.CollisionGroup = "WeaponRay"
	vischeck_params.IgnoreWater = true

	cheat.is_visible = LPH_NO_VIRTUALIZE(function(origin, target, target_part)
		vischeck_params.FilterDescendantsInstances = { workspace.NoCollision, Camera, LocalPlayer.Character }
		local castresults = _Raycast(workspace, origin, target_part.Position - origin, vischeck_params)
		return castresults and castresults.Instance and _IsDescendantOf(castresults.Instance, target), castresults
	end)

	cheat.is_pos_visible = LPH_NO_VIRTUALIZE(function(origin, target_pos, target)
		vischeck_params.FilterDescendantsInstances = { workspace.NoCollision, Camera, LocalPlayer.Character }
		local castresults = _Raycast(workspace, origin, target_pos - origin, vischeck_params)
		return castresults and castresults.Instance and _IsDescendantOf(castresults.Instance, target), castresults
	end)
end

cheat.make_beam = function(Origin, Position, Color)
	local part1, part2 = Instance.new("Part", workspace.NoCollision), Instance.new("Part", workspace.NoCollision)
	part1.CFrame = _CFramenew(Origin);
	part2.CFrame = _CFramenew(Origin); -- Position
	part1.Transparency = 1; part2.Transparency = 1;
	part1.CanCollide = false; part2.CanCollide = false;
	part1.Size = Vector3.zero; part2.Size = Vector3.zero;
	part1.Anchored = true; part2.Anchored = true;
	local OriginAttachment = Instance.new("Attachment", part1)
	local PositionAttachment = Instance.new("Attachment", part2)
	local Beam = Instance.new("Beam", workspace.NoCollision)
	Beam.Name = "Beam"
	Beam.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0,Color),
		ColorSequenceKeypoint.new(1,Color)
	};
	Beam.LightEmission = 9e9
	Beam.LightInfluence = 9e9
	Beam.TextureMode = Enum.TextureMode.Static
	Beam.TextureSpeed = 0
	--Beam.Texture = "http://www.roblox.com/asset/?id=446111271"
	Beam.Transparency = NumberSequence.new(0)
	Beam.Attachment0 = OriginAttachment
	Beam.Attachment1 = PositionAttachment
	Beam.FaceCamera = true
	Beam.Segments = 1
	Beam.Width0 = 0.2
	Beam.Width1 = 0.2
	local start_tick = tick()
	local speed = 50
	local connection; connection = cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function()
		local passed = tick() - start_tick
		local lv = (Position - Origin)
		local dist = passed * speed
		local newpos = (Position - Origin).Unit * dist
		part2.CFrame = _CFramenew(Origin + newpos)

		local dist_left = lv.Magnitude - dist
		local tp1 = math.clamp((dist - lv.Magnitude + speed) / speed, 0, 1)
		local tp2 = math.clamp((passed - (5 / 2)) * (5 * 2), 0, 1)
		local ctp = tp1 > tp2 and tp1 or tp2
		Beam.Transparency = NumberSequence.new(ctp)

		if ctp > 1 then
			Beam:Destroy()
			OriginAttachment:Destroy()
			PositionAttachment:Destroy()
			part1:Destroy()
			part2:Destroy()
			connection:Disconnect()
		end
	end))
end

cheat.report_list = {}
do
	local report_list = game:GetService("ReplicatedStorage").ReportList
	local most_wanted = report_list.MostWanted
	local recent_reports = report_list.Recent
	
	local player_report_list = cheat.report_list
	task.spawn(LPH_NO_VIRTUALIZE(function()
		while task.wait(0.25) do
			for i, v in player_report_list do
				v.rr = 0
				v.mw = 0
			end
			for i, v in recent_reports:GetChildren() do
				local username, report_id = v.Name:match("(.+)_([^_]+)$")
				local player_object = player_report_list[username]
				
				if not player_object then
					player_report_list[username] = {rr = 0, mw = 0}
					player_object = player_report_list[username]
				end

				player_object.rr += 1
			end
			for i, v in most_wanted:GetChildren() do
				local username, user_id = v.Name:match("(.+)_([^_]+)$")
				local player_object = player_report_list[username]
				
				if not player_object then
					player_report_list[username] = {rr = 0, mw = 0}
					player_object = player_report_list[username]
				end

				player_object.mw += 1
			end
		end
	end))
end

cheat.player_list = {}
local hit_detection = function(...)end
do
	local is_visible, get_visor_status = cheat.is_visible, project_delta.get_visor_status
	local player_list = cheat.player_list
	local player_folder = game:GetService("ReplicatedStorage"):WaitForChild("Players")
	local add_player = function(player)
		player_list[player] = {}
		local player_object = player_list[player]
		local game_data, game_uac, game_clan, game_inventory
		local character, humanoid
		local old_health
		player_object.premium = player.MembershipType == Enum.MembershipType.Premium
		player_object.update_loop = LPH_NO_VIRTUALIZE(function(delta, bullet_origin)

			local game_data = _FindFirstChild(player_folder, player.Name)
			local game_inventory = game_data and _FindFirstChild(game_data, "Inventory")
			local game_status = game_data and _FindFirstChild(game_data, "Status")
			local game_journey = game_data and _FindFirstChild(game_data, "Journey")
			local game_uac = game_status and _FindFirstChild(game_status, "UAC")
			local game_clan = game_journey and _FindFirstChild(game_journey, "Clan")

			player_object.game_data = game_data
			player_object.inventory = game_inventory

			if game_clan then
				local clan = game_clan:GetAttribute("CurrentClan")
				player_object.current_clan = clan ~= "nil" and clan
			end

			if game_uac then
				player_object.server_position = game_uac:GetAttribute("LastVerifiedPos")
				local reports = _FindFirstChild(game_uac, "Reports")
				if reports then
					local total_reports = 0
					for report_type, count in reports:GetAttributes() do
						total_reports += count
					end
					player_object.reports = total_reports
				end
			end

			if game_data then
				local status = _FindFirstChild(game_data, "Status")
				local gameplay = status and _FindFirstChild(status, "GameplayVariables")
				local equipped_tool = gameplay and _FindFirstChild(gameplay, "EquippedTool")
				player_object.current_weapon = equipped_tool and equipped_tool.Value
			end

			if game_inventory then
				player_object.visor = get_visor_status(game_inventory)
			end

			character = player.Character
			if not character then return end

			if bullet_origin then
				local hrp, head = _FindFirstChild(character, "HumanoidRootPart"), _FindFirstChild(character, "Head")
				player_object.visible = (hrp and is_visible(bullet_origin, character, hrp)) or (head and is_visible(bullet_origin, character, head))
			end

			humanoid = _FindFirstChildOfClass(character, "Humanoid")
			if not humanoid then return end
			if not old_health then old_health = humanoid.Health end
			local new_health = humanoid.Health
			if new_health ~= old_health then
				hit_detection(player, new_health, old_health)
				old_health = new_health
			end
		end)
		player_object.friend = player:IsFriendsWith(LocalPlayer.UserId)
	end

	for _, player in Players:GetPlayers() do
		task.spawn(add_player, player)
	end
	Players.PlayerAdded:Connect(add_player)

	Players.PlayerRemoving:Connect(function(player)
		local object = player_list[player]
		player_list[player] = nil
	end)

	local get_estimated_origin = project_delta.get_estimated_origin
	cheat.utility.new_heartbeat(LPH_NO_VIRTUALIZE(function(delta)
		local character = LocalPlayer.Character
		local hrp = character and _FindFirstChild(character, "HumanoidRootPart")
		local hmm_origin = hrp and get_estimated_origin(LocalPlayer)
		for i, v in player_list do
			v.update_loop(delta, hmm_origin)
		end
	end))

	local lp = player_list[LocalPlayer]
	cheat.EspLibrary.get_team = LPH_NO_VIRTUALIZE(function(player, character, humanoid)
		local tp = player_list[player]
		return tp and lp.current_clan and tp.current_clan and lp.current_clan == tp.current_clan
	end)

	cheat.EspLibrary.get_gun = LPH_NO_VIRTUALIZE(function(player, character, humanoid)
		local tp = player_list[player]
		local current_weapon = tp and tp.current_weapon
		return current_weapon and current_weapon.Name
	end)
end

cheat.bullet_infos = {}

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
	combat_misc = ui.tabs.combat:SubTab({Name = "Misc"}),
	visuals_esp = ui.tabs.visuals:SubTab({Name = "Player ESP"}),
	visuals_esp_misc = ui.tabs.visuals:SubTab({Name = "Misc ESP"}),
	visuals_lighting = ui.tabs.visuals:SubTab({Name = "Lighting"}),
	visuals_misc = ui.tabs.visuals:SubTab({Name = "Misc"}),
	misc_main = ui.tabs.misc:SubTab({Name = "Main"}),
	misc_antiaim = ui.tabs.misc:SubTab({Name = "Anti-aim"}),
	misc_exploit = ui.tabs.misc:SubTab({Name = "Exploits"}),
	settings_main = ui.tabs.settings:SubTab({Name = "Main"}),
	settings_theme = ui.tabs.settings:SubTab({Name = "Themeing"})
}
ui.sections = {
	aimbot_main = ui.subtabs.combat_aimbot:Section({Name = "Aimbot", Side = "Left"}),
	aimbot_misc = ui.subtabs.combat_aimbot:Section({Name = "Misc", Side = "Right"}),
	--aimbot_silent = ui.subtabs.combat_aimbot:Section({Name = "Silent", Side = "Right"}),
	aimbot_effects = ui.subtabs.combat_misc:Section({Name = "Effects/Logs", Side = "Left"}),
	gunmods = ui.subtabs.combat_misc:Section({Name = "Gun mods", Side = "Right"}),

	player_esp = ui.subtabs.visuals_esp:Section({Name = "Players", Side = "Left"}),
	esp_settings = ui.subtabs.visuals_esp:Section({Name = "Settings", Side = "Right"}),
	item_esp = ui.subtabs.visuals_esp_misc:Section({Name = "Items", Side = "Left"}),
	other_esp = ui.subtabs.visuals_esp_misc:Section({Name = "Other", Side = "Right"}),
	world_main_changer = ui.subtabs.visuals_lighting:Section({Name = "Lighting", Side = "Left"}),
	world_misc_changer = ui.subtabs.visuals_lighting:Section({Name = "Misc", Side = "Right"}),
	visuals_misc = ui.subtabs.visuals_misc:Section({Name = "View", Side = "Left"}),
	visuals_local = ui.subtabs.visuals_misc:Section({Name = "Local", Side = "Right"}),

	movement = ui.subtabs.misc_main:Section({Name = "Movement", Side = "Left"}),
	misc = ui.subtabs.misc_main:Section({Name = "Misc", Side = "Right"}),
	antiaim = ui.subtabs.misc_antiaim:Section({Name = "Antiaim", Side = "Left"}),
	antiaim_animations = ui.subtabs.misc_antiaim:Section({Name = "Animation", Side = "Right"}),
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

local get_targets_in_fov = LPH_NO_VIRTUALIZE(function(
	fov_size,
	aimbot_part,
	aimbot_team_check,
	aimbot_dead_check,
	aimbot_dist_check,
	aimbot_max_distance,
	aimbot_npc_check,
	aimbot_screen_check
)
	local player_list = Players:GetPlayers()
	local target_list = table.create(#player_list)

	local maximum_distance = fov_size

	local mousepos = UserInputService:GetMouseLocation()
	local campos = Camera.CFrame.Position

	local get_team = cheat.EspLibrary.get_team

	for _, player in player_list do
		if not (player and player ~= LocalPlayer) then continue end

		local character = player.Character
		local root = character and _FindFirstChild(character, "HumanoidRootPart")
		local humanoid = character and _FindFirstChildOfClass(character, "Humanoid")
		local aimpart = character and _FindFirstChild(character, aimbot_part or "Head")
		local mainpart = aimpart or root

		if not (mainpart) then continue end

		if (aimbot_team_check) and get_team(player) then
			continue
		end
		if (aimbot_dead_check) and (not humanoid or humanoid.Health <= 0) then
			continue
		end
		if (aimbot_dist_check) and ((campos - mainpart.Position).Magnitude > aimbot_max_distance) then
			continue
		end

		local position, on_screen = _WorldToViewportPoint(Camera, mainpart.Position)
		local distance = (
			_Vector2new(
				position.X, position.Y
			) - mousepos
		).Magnitude

		if (aimbot_screen_check or on_screen) and distance <= maximum_distance then
			table.insert(target_list, {mainpart, player, character, distance})
		end
	end

	if aimbot_npc_check then
		table.sort(target_list, function(a, b)
			return a[4] < b[4]
		end)
		return target_list
	end

	for _, aizone in project_delta.aizones:GetChildren() do
		for _, npc in aizone:GetChildren() do
			local root = _FindFirstChild(npc, "HumanoidRootPart")
			local humanoid = _FindFirstChildOfClass(npc, "Humanoid")
			local aimpart = _FindFirstChild(npc, aimbot_part or "Head")
			local mainpart = aimpart or root

			if not (mainpart) then continue end

			if (aimbot_dead_check) and (not humanoid or humanoid.Health <= 0) then
				continue
			end
			if (aimbot_dist_check) and ((campos - mainpart.Position).Magnitude > aimbot_max_distance) then
				continue
			end

			local position, on_screen = _WorldToViewportPoint(Camera, mainpart.Position)
			local distance = (
				_Vector2new(
					position.X, position.Y
				) - mousepos
			).Magnitude

			if (aimbot_screen_check or on_screen) and distance <= maximum_distance then
				table.insert(target_list, {mainpart, npc, npc, distance})
			end
		end
	end
	
	table.sort(target_list, function(a, b)
		return a[4] < b[4]
	end)
	return target_list
end)


local aimbot_mode = "Camera"
local target_part, target_player, target_character
local silent_forcehit = false
local instant_reload, instant_equip, instant_aim = false, false, false
local hit_sound, hit_sound_instance, hit_sound_speed, hit_sound_volume = false, cheat.hitsounds["Bameware"], 1, 1
local hit_logs, hit_logs_duration = false, 0
local no_recoil = false
do
	local aimsec = ui.sections.aimbot_main
	local mscsec = ui.sections.aimbot_misc
	local samsec = ui.sections.aimbot_silent
	local effsec = ui.sections.aimbot_effects
	local gunsec = ui.sections.gunmods

	local aimbot_enabled, aimbot_enabled_key, aimbot_part, aimbot_smoothness = false, false, "Head", 0.7
	local aimbot_team_check, aimbot_dead_check, aimbot_dist_check, aimbot_max_distance, aimbot_npc_check, aimbot_visible_check, aimbot_screen_check = false, false, false, 600, false, false, false
	local fov_show, fov_color, fov_outline, fov_size, fov_sides = false, Color3.new(1,1,1), false, 100, 67
	local autoshoot, autoshoot_key, autowall = false, false, false
	local hitscan_hitboxes = {"FaceHitBox", "HeadTopHitBox", "Head"}

	local indicator = cheat.IndicatorLibrary:new_indicator()

	do
		local desync_resolver, angle_resolver = false, false

		local aim_keybind; aim_keybind = aimsec:Toggle({Name = "Enabled", Value = false, Flag = "aimbot_enable", Callback = function(bool)
			aimbot_enabled = bool
		end}):Keybind({Name = "Aimbot", Mode = "Hold", Key = Enum.KeyCode.E, Value = false, Flag = "aimbot_enabled_keybind", Callback = function(bool)
			aimbot_enabled_key = aimbot_enabled and bool
			aim_keybind.Set(aimbot_enabled_key, true)
		end})
		aimsec:Dropdown({Name = "Aim part", Values = {"Head", "UpperTorso"}, Value = "Head", Flag = "aimbot_hitpart", Multi = false, Callback = function(str)
			aimbot_part = str
		end})
		aimsec:Dropdown({Name = "Aim mode", Values = {"Camera", "Mouse", "Silent"}, Value = "Camera", Flag = "aimbot_mode", Multi = false, Callback = function(str)
			aimbot_mode = str
		end})
		aimsec:Slider({Name = "Aim smoothness", Min = 0.01, Max = 1, Float = 0.01, Value = 0.7, Flag = "aimbot_smoothness", Suffix = "%sx" --[[degree symbol (°)]], Callback = function(int)
			aimbot_smoothness = int
		end})
		

		aimsec:Toggle({Name = "Desync resolver", Value = false, Flag = "desync_resolver", Callback = function(bool)
			desync_resolver = bool
		end})
		aimsec:Toggle({Name = "Angle resolver", Value = false, Flag = "angle_resolver", Callback = function(bool)
			angle_resolver = bool
		end})

		local player_list = cheat.player_list
		RunService.PreRender:Connect(LPH_JIT(function()
			for player, player_object in player_list do
				if player == LocalPlayer then continue end
				local server_position = player_object.server_position
				local character = player.Character
				local hrp = character and _FindFirstChild(character, "HumanoidRootPart")
				if desync_resolver and hrp and server_position then
					hrp.CFrame = _CFramenew(server_position) * hrp.CFrame.Rotation
				end
				if angle_resolver and character then
					character:SetAttribute("UpAngle", 0)
				end
			end
		end))
	end
	do
		mscsec:Dropdown({Name = "Checks", Values = {"Team check", "Dead check", "Distance check", "NPC check", "Include off-screen"}, Value = {}, Flag = "aimbot_checks", Multi = true, Callback = function(tbl)
			local funny = {
				["Team check"] = "team_check",
				["Dead check"] = "dead_check",
				["Distance check"] = "dist_check",
				["NPC check"] = "npc_check",
				["Include off-screen"] = "screen_check"
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
			aimbot_npc_check = uhh["npc_check"]
			aimbot_screen_check = uhh["screen_check"]
		end})
		mscsec:Slider({Name = "Max distance", Min = 0, Max = 2000, Float = 10, Value = 200, Flag = "aimbot_max_distance", Callback = function(int)
			aimbot_max_distance = int * 3
		end})
		mscsec:Slider({Name = "Aim size", Min = 0, Max = 180, Float = 1, Value = 10, Flag = "aimbot_fov_size", Suffix = "%s\194\176" --[[degree symbol (°)]], Callback = function(int)
			fov_size = int
		end})

		mscsec:Toggle({Name = "Silent force-hit", Value = false, Flag = "silent_forcehit", Callback = function(bool)
			silent_forcehit = bool
		end})
		

		local autoshoot_keybind; autoshoot_keybind = mscsec:Toggle({Name = "Silent auto-shoot", Value = false, Flag = "aimbot_autoshoot", Callback = function(bool)
			autoshoot = bool
		end}):Keybind({Name = "Auto-shoot", Mode = "Toggle", Key = Enum.KeyCode.G, Value = false, Flag = "aimbot_autoshoot_keybind", Callback = function(bool)
			autoshoot_key = autoshoot and bool
			autoshoot_keybind.Set(autoshoot_key, true)
		end})

		mscsec:Toggle({Name = "Auto-wall penetration", Value = false, Flag = "silent_autowall", Callback = function(bool)
			autowall = bool
		end})

		mscsec:Dropdown({Name = "Auto-shoot hitscan", Values = {
			"FaceHitBox",
			"HeadTopHitBox",
			"Head",
			"UpperTorso",
			"LowerTorso",
			"LeftUpperArm",
			"LeftLowerArm",
			"LeftHand",
			"RightUpperArm",
			"RightLowerArm",
			"RightHand",
			"RightUpperLeg",
			"RightLowerLeg",
			"RightFoot",
			"LeftUpperLeg",
			"LeftLowerLeg",
			"LeftFoot"
		}, Value = {"FaceHitBox", "HeadTopHitBox", "Head"}, Flag = "aimbot_autoshoot_hitscan", Multi = true, Callback = function(tbl)
			hitscan_hitboxes = {}
			for index, hitbox in project_delta.hitboxes_priority do
				for _, chosen in tbl do
					if chosen ~= hitbox then
						continue
					end
					table.insert(hitscan_hitboxes, chosen)
				end
			end
		end})

		do
			local holdbullets_keybind; holdbullets_keybind = mscsec:Toggle({Name = "Hold bullets", Value = false, Flag = "aimbot_holdbullets", Callback = function(bool)
				holdbullets = bool
			end}):Keybind({Name = "fye \240\159\169\184\240\159\169\184\240\159\169\184", Mode = "Toggle", Key = Enum.KeyCode.X, Value = false, Flag = "aimbot_holdbullets_keybind", Callback = function(bool)
				holdbullets_key = holdbullets and bool
				holdbullets_keybind.Set(holdbullets_key, true)
			end})

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

			cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function(delta)
				main_wireframe:Clear()
			end))
		end
	end
	do
		local bullet_tracers, bullet_tracers_color = false, Color3.new(1, 1, 1)
		--local hit_chams, hit_skeletons = false, false

		effsec:Toggle({Name = "Aimbot FOV", Value = false, Flag = "fov_enabled", Callback = function(bool)
			fov_show = bool
		end}):Colorpicker({Name = "FOV Color", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "fov_color", Callback = function(color)
			fov_color = color.c
		end})
		effsec:Toggle({Name = "FOV Outline", Value = false, Flag = "fov_outline", Callback = function(bool)
			fov_outline = bool
		end})
		effsec:Slider({Name = "FOV Sides", Min = 3, Max = 100, Float = 1, Value = 67, Flag = "fov_sides", Suffix = "%s", Callback = function(int)
			fov_sides = int
		end})

		do
			local inventory_holder = Instance.new("Frame")
			inventory_holder.Parent = game:GetService("CoreGui").RobloxGui
			inventory_holder.BackgroundTransparency = 1
			inventory_holder.BorderSizePixel = 0
			inventory_holder.Position = UDim2.new(0, -GuiInset.X, 0, -GuiInset.Y)
			inventory_holder.ZIndex = 2

			local default_font = Fonts.Get("SmallestPixel7")

			local inventory_text = Instance.new("TextLabel")
			inventory_text.Parent = inventory_holder
			inventory_text.AnchorPoint = Vector2.new(0, 0)
			inventory_text.BackgroundTransparency = 1
			inventory_text.BorderSizePixel = 0
			inventory_text.Position = UDim2.new(0, 2, 0, 0)
			inventory_text.FontFace = default_font
			inventory_text.Text = ""--"xXx_sw1mdr0id_xXx's Inventory\n[Hotbar]\n\tMP5SD\n\tAKMN\n\tAKMN\n"
			inventory_text.TextColor3 = Color3.new(1, 1, 1)
			inventory_text.TextSize = 9
			inventory_text.TextStrokeTransparency = 0
			inventory_text.TextXAlignment = Enum.TextXAlignment.Left
			inventory_text.TextYAlignment = Enum.TextYAlignment.Top


			effsec:Toggle({Name = "Inventory viewer", Value = false, Flag = "inventory_viewer", Callback = function(bool)
				inventory_holder.Visible = bool
			end}):Colorpicker({Name = "Viewer Color", Value = Color3.new(1, 1, 1), Usealpha = true, Flag = "inventory_viewer_color", Callback = function(color)
				inventory_text.TextColor3 = color.c
				inventory_text.TextTransparency = color.a
			end})
			effsec:Colorpicker({Name = "Background", Value = Color3.new(), Alpha = 0.7, Usealpha = true, Flag = "inventory_viewer_background", Callback = function(color)
				inventory_holder.BackgroundColor3 = color.c
				inventory_holder.BackgroundTransparency = color.a
			end})
			effsec:Dropdown({Name = "Viewer font", Values = {
				"Tahoma",
				"TahomaXP",
				"Comfortaa",
				"Verdana",
				"SmallestPixel7",
				"Proggy",
			}, Value = {"SmallestPixel7"}, Flag = "inventory_viewer_font", Multi = false, Callback = function(str)
					inventory_text.FontFace = Fonts.Get(str or "SmallestPixel7") or default_font
				end})
			effsec:Slider({Name = "Viewer size", Min = 1, Max = 30, Float = 1, Value = 9, Flag = "inventory_viewer_size", Suffix = "%spx", Callback = function(int)
				inventory_text.TextSize = int
			end})
			effsec:Slider({Name = "Viewer X", Min = 0, Max = 100, Float = 1, Value = 5, Flag = "inventory_viewer_x", Suffix = "%s%%", Callback = function(int)
				inventory_holder.Position = UDim2.new(int / 100, -GuiInset.X, inventory_holder.Position.Y.Scale, -GuiInset.Y)
			end})
			effsec:Slider({Name = "Viewer Y", Min = 0, Max = 100, Float = 1, Value = 5, Flag = "inventory_viewer_y", Suffix = "%s%%", Callback = function(int)
				inventory_holder.Position = UDim2.new(inventory_holder.Position.X.Scale, -GuiInset.X, int / 100, -GuiInset.Y)
				--print(inventory_holder.Position)
			end})

			local player_list = cheat.player_list

			local weapon_slots = {
				ItemBack1 = 1,
				ItemBack2 = 2,
				ItemHip1 = 3,
				Melee = 4
			}

			local armor_slots = {
				ClothingHeadware = 1,
				ClothingChestRig = 2,
				ClothingMask = 3,
				ClothingLegArmor = 4
			}

			local get_weapon_loadedammo = LPH_NO_VIRTUALIZE(function(weapon)
				local weapon_loadedammo = weapon:GetAttribute("LoadedAmmo")
				if weapon_loadedammo then
					return weapon_loadedammo
				end

				local attachments = _FindFirstChild(weapon, "Attachments")
				if not attachments then
					return 0
				end

				for _, attachment in attachments:GetChildren() do
					local loadedammo = attachment:GetAttribute("LoadedAmmo")
					if loadedammo then
						return loadedammo
					end
				end

				return 0
			end)

			local get_player_inventory = LPH_NO_VIRTUALIZE(function(player)
				local player_object = player_list[player]
				local game_data = player_object and player_object.game_data
				if not game_data then
					return ""
				end

				local inventory = _FindFirstChild(game_data, "Inventory")
				if not (inventory) then
					return ""
				end

				--[[
					weapon = { -- weapons
						[1] = {"akmn", loadedammo (num), durability (num%)}
						[2] = {"akmn", loadedammo (num), durability (num%)}
						[3] = {"tfz0", loadedammo (num), durability (num%)}
						[4] = {"dv2"}
					}
					armor = {
						[1] = "atlyn"
						[2] = "6b43"
						[3] = "balaclava"
						[4] = "kneepads"
					}
					inventoried = { -- inventoried things
						{"attak5", {
							["9x18AP"] = amount (num)
							["7.62x39AP"] = amount (num)
						}}
					}
					last = { -- uncategorized items
						{"map"}
					}
				]]

				--local indexed_inventories = {}
				local weapon, armor, inventoried, last = {}, {}, {}, {}
				for _, item in inventory:GetChildren() do
					local item_name = item.Name
					local slot = item:GetAttribute("Slot")
					if not slot then
						last[#last + 1] = {item_name}
						continue
					end

					local found_slot = weapon_slots[slot]
					if found_slot then
						local durability = item:GetAttribute("Durability") or 1
						local max_durability = item:GetAttribute("MaxDurability") or 1
						weapon[found_slot] = {item_name, get_weapon_loadedammo(item), mathfloor(durability / max_durability * 100)}
						continue
					end

					found_slot = armor_slots[slot]
					if found_slot then
						armor[found_slot] = {item_name}
					end

					local inventory = _FindFirstChild(item, "Inventory")
					if not inventory then
						if not found_slot then
							last[#last + 1] = {item_name}
						end
						continue
					end

					local current_inventory = {}
					inventoried[#inventoried + 1] = {item_name, current_inventory}

					for _, subitem in inventory:GetChildren() do
						local subitem_name = subitem.Name
						local amount = subitem:GetAttribute("Amount") or 1
						if current_inventory[subitem_name] then
							current_inventory[subitem_name] += amount
						else
							current_inventory[subitem_name] = amount
						end
					end
				end

				table.sort(inventoried, function(a, b)
					return a[1] < b[1]
				end)
				table.sort(last, function(a, b)
					return a[1] < b[1]
				end)

				local text_buffer = ("%*'s Inventory\n"):format(player.Name)

				text_buffer ..= "[Hotbar]\n"
				for _, item in weapon do
					text_buffer ..= ("\t%* - %* (%*%%)\n"):format(item[1], item[2], item[3])
				end

				text_buffer ..= "[Armor]\n"
				for _, item in armor do
					text_buffer ..= ("\t%*\n"):format(item[1])
				end

				text_buffer ..= "[Inventory]\n"
				for _, item in inventoried do
					text_buffer ..= ("\t%* =>\n"):format(item[1])
					for subitem_name, subitem_amount in item[2] do
						text_buffer ..= ("\t\t%* => %*x\n"):format(subitem_name, subitem_amount)
					end
				end

				text_buffer ..= "[Other]\n"
				for _, item in last do
					text_buffer ..= ("\t%*\n"):format(item[1])
				end

				--[[local text_buffer = ("%*'s Inventory\n"):format(player.Name)

				for _, item in inventory:GetChildren() do
					text_buffer ..= ("\t%*\n"):format(item.Name)
					local item_inventory = _FindFirstChild(item, "Inventory")
					local item_children = item_inventory and item_inventory:GetChildren()
					if not (item_inventory and #item_children > 0) then continue end

					for _, subitem in item_children do
						local amount = subitem:GetAttribute("Amount")

						if amount then
							text_buffer ..= ("\t\t%* => %*x\n"):format(subitem.Name, amount)
						else
							text_buffer ..= ("\t\t%*\n"):format(subitem.Name)
						end
					end
				end]]

				return text_buffer:gsub("[\r\n]$", "")
			end)
			cheat.utility.new_heartbeat(LPH_JIT(function()
				local inventory = target_player and get_player_inventory(target_player) or ""
				inventory_text.Text = inventory
				inventory_holder.Size = inventory ~= "" and UDim2.new(0, inventory_text.TextBounds.X + 4, 0, inventory_text.TextBounds.Y + 2) or UDim2.new(0, 0, 0, 0)
			end))
		end

		effsec:Toggle({Name = "Bullet tracers", Value = false, Flag = "bullet_tracers", Callback = function(bool)
			bullet_tracers = bool
		end}):Colorpicker({Name = "FOV Color", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "bullet_tracers_color", Callback = function(color)
			bullet_tracers_color = color.c
		end})

		effsec:Toggle({Name = "Hit sound", Value = false, Flag = "hit_sound", Callback = function(bool)
			hit_sound = bool
		end})

		effsec:Slider({Name = "Hit sound volume", Min = 0.1, Max = 10, Float = 0.1, Value = 1, Flag = "hit_sound_volume", Suffix = "%s", Callback = function(int)
			hit_sound_volume = int
		end})
		effsec:Slider({Name = "Hit sound speed", Min = 0.1, Max = 3, Float = 0.1, Value = 1, Flag = "hit_sound_speed", Suffix = "%s", Callback = function(int)
			hit_sound_speed = int
		end})
		
		effsec:Dropdown({Name = "Hit sound selection", Values = (function()
			local hitsounds = {}
			for name, _ in cheat.hitsounds do
				table.insert(hitsounds, name)
			end
			return hitsounds
		end)(), Value = "Bameware", Flag = "hit_sound_id", Multi = false, Callback = function(str)
			hit_sound_instance = cheat.hitsounds[str]
		end})
		
		effsec:Toggle({Name = "Hit logs", Value = false, Flag = "hit_logs", Callback = function(bool)
			hit_logs = bool
		end})
		effsec:Slider({Name = "Log duration", Min = 0, Max = 10, Float = 0.1, Value = 5, Flag = "hit_logs_duration", Suffix = "%ss", Callback = function(int)
			hit_logs_duration = int
		end})

		do
			local picture_on_kill, picture_on_kill_no_background, picture_duration, fade_duration = false, false, 0.05, 0.5

			effsec:Toggle({Name = "Picture on kill", Value = false, Flag = "picture_on_kill", Callback = function(bool)
				picture_on_kill = bool
			end})
			effsec:Toggle({Name = "No picture background", Value = false, Flag = "picture_on_kill_no_background", Callback = function(bool)
				picture_on_kill_no_background = bool
			end})
			effsec:Slider({Name = "Picture duration", Min = 0, Max = 10, Float = 0.1, Value = 0.05, Flag = "picture_on_kill_duration", Suffix = "%ss", Callback = function(int)
				picture_duration = int
			end})
			effsec:Slider({Name = "Picture fade duration", Min = 0, Max = 10, Float = 0.1, Value = 5, Flag = "picture_on_kill_fade_duration", Suffix = "%ss", Callback = function(int)
				fade_duration = int
			end})
			effsec:Button({Name = "Reload pictures", Confirm = false, Callback = function()
				PicturesOnKill.Reload()
			end})
			effsec:Button({Name = "Download furries", Confirm = false, Callback = function()
				Library.Notification("no", 2.5)
			end})
			if firesignal then
				effsec:Button({Name = "Test picture on kill", Confirm = false, Callback = function()
					local success = pcall(firesignal, game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("NotificationMessage").OnClientEvent, "Killed", 1, 5)
					if not success then
						Library.Notification("Failed to test. (firesignal errored)", 2.5)
					end
				end})
			end

			local TweenService = game:GetService("TweenService")

			local PictureHolder = Instance.new("ScreenGui", game:GetService("CoreGui"))
			PictureHolder.ResetOnSpawn = false
			PictureHolder.IgnoreGuiInset = true

			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("NotificationMessage").OnClientEvent:Connect(function(text, duration, color)
				if picture_on_kill and (text:find("Killed") or text:find("Incapacitated")) then
					task.spawn(function()
						local imagelabel = Instance.new("ImageLabel")
						imagelabel.Image = PicturesOnKill.GetNextPicture()
						imagelabel.Size = UDim2.new(1, 0, 1, 0)
						imagelabel.Position = UDim2.new(0, 0, 0, 0)
						imagelabel.BackgroundTransparency = picture_on_kill_no_background and 1 or 0
						imagelabel.ImageTransparency = 0
						imagelabel.Parent = PictureHolder

						task.wait(picture_duration)
					
						local connection; connection = RunService.RenderStepped:Connect(function(d)
							if imagelabel.BackgroundTransparency < 1 then
								imagelabel.BackgroundTransparency += d * (1/fade_duration)
							end
							if imagelabel.ImageTransparency < 1 then
								imagelabel.ImageTransparency += d * (1/fade_duration)
							else
								connection:Disconnect()
								imagelabel:Destroy()
							end
						end)
					end)
				end
			end)
		end

		local make_beam = cheat.make_beam
		local bullet_module = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").FPS.Bullet)
		local old_createbullet = bullet_module.CreateBullet

		local fake_part = Instance.new("Part")
		fake_part.Anchored = true
		fake_part.Parent = game:GetService("ReplicatedStorage")

		bullet_module.CreateBullet = LPH_NO_VIRTUALIZE(function(...)
			local args = {...}
			fake_part.CFrame = args[5].CFrame
			args[5] = fake_part
			
			local origin = project_delta.get_estimated_origin(LocalPlayer)

			if aimbot_mode == "Silent" and target_part then
				fake_part.CFrame = CFrame.lookAt(origin, target_part.Position)
			end
			if bullet_tracers then
				make_beam(origin, origin + fake_part.CFrame.LookVector * 3300, bullet_tracers_color)
			end
			return old_createbullet(unpack(args))
		end)
	end
	do
		local force_auto, rapid_fire, rapid_fire_speed, loadbyhand_delay, loadbyhand_async = false, false, 1/60, 0.15, false

		local spring_disablers = {
			["sprintCycle"] = false,
			["leanAlpha"] = false,
			["strafeTilt"] = false,
			["walkCycle"] = false,
			["jumpCameraTilt"] = false,
			["recoilRot"] = false,
			["gunSway"] = false,
			["jumpTilt"] = false,
			["cameraRecoil"] = false,
			["recoilPos"] = false,
			["wallTouchTilt"] = false,
			["sway"] = false
		}
		local aliases = {
			["Recoil"] = {"recoilPos", "recoilRot", "cameraRecoil"},
			["Bobbing"] = {"sprintCycle", "walkCycle", "jumpTilt"},
			["Sway"] = {"gunSway", "sway", "strafeTilt"},
			["Jump shake"] = {"jumpCameraTilt"},
			["Wall touch"] = {"wallTouchTilt"}
		}
		gunsec:Dropdown({Name = "Removals", Values = (function()
			local new = {}
			for i, v in aliases do
				new[#new + 1] = i
			end
			return new
		end)(), Value = {}, Flag = "gunmods_removals", Multi = true, Callback = function(tbl)
			no_recoil = false
			for spring_name, value in spring_disablers do
				spring_disablers[spring_name] = false
			end
			for _, alias in tbl do
				if alias == "Recoil" then
					no_recoil = true
				end
				for _, spring_name in aliases[alias] do
					spring_disablers[spring_name] = true
				end
			end
		end})
		gunsec:Toggle({Name = "Instant reload", Value = false, Flag = "gunmods_instant_reload", Callback = function(bool)
			instant_reload = bool
		end})
		gunsec:Toggle({Name = "LBH async delay", Value = false, Flag = "gunmods_loadbyhand_async", Callback = function(bool)
			loadbyhand_async = bool
		end})
		gunsec:Slider({Name = "LBH delay", Min = 0, Max = 0.5, Float = 0.01, Value = 0.15, Flag = "gunmods_loadbyhand_delay", Suffix = "%ss", Callback = function(int)
			loadbyhand_delay = int
		end})
		gunsec:Toggle({Name = "Instant equip", Value = false, Flag = "gunmods_instant_equip", Callback = function(bool)
			instant_equip = bool
		end})
		gunsec:Toggle({Name = "Instant aim", Value = false, Flag = "gunmods_instant_aim", Callback = function(bool)
			instant_aim = bool
		end})

		gunsec:Toggle({Name = "Force auto", Value = false, Flag = "gunmods_force_auto", Callback = function(bool)
			force_auto = bool
		end})
		gunsec:Toggle({Name = "Rapid fire", Value = false, Flag = "gunmods_rapid_fire", Callback = function(bool)
			rapid_fire = bool
		end})
		gunsec:Slider({Name = "Rounds per second", Min = 10, Max = 100, Float = 1, Value = 60, Flag = "gunmods_rapid_fire_speed", Suffix = "1s/%s", Callback = function(int)
			rapid_fire_speed = 1/int
		end})

		do
			local auto_reload, auto_refill = false

			local newlclosure = newlclosure or LPH_NO_VIRTUALIZE(function(f)
				return function(...)
					return f(...)
				end
			end)

			local success, old_remove
			success, old_remove = pcall(hookfunction, project_delta.remove_bullet, newlclosure(function(fps_object, ...)
				local hmm = {old_remove(fps_object, ...)}

				if not auto_reload then
					return unpack(hmm)
				end
				if fps_object.Bullets > 0 then
					return unpack(hmm)
				end

				task.spawn(fps_object.reload, fps_object)

				return unpack(hmm)
			end))

			if not success then
				print("failed to hook remove_bullet", old_remove, getgenv().newlclosure)
			else
				
				gunsec:Toggle({Name = "Auto reload", Value = false, Flag = "gunmods_auto_reload", Callback = function(bool)
					auto_reload = bool
				end})
				--[[gunsec:Toggle({Name = "Auto refill magazines", Value = false, Flag = "gunmods_auto_refill", Callback = function(bool)
					auto_refill = bool
				end})]]
			end
		end

		local old_reload_magazine, old_reload_loadbyhand = project_delta.fps_reloadtypes.magazine, project_delta.fps_reloadtypes.loadByHand
		local get_compatible_mag, get_compatible_ammo = project_delta.get_compatible_mag, project_delta.get_compatible_ammo
		local update_fps = project_delta.update_fps

		local reload_remote, inventorymove_remote, equip_remote = project_delta.reload_remote, project_delta.inventorymove_remote, project_delta.equip_remote

		local local_gameplayvars, lpo = project_delta.local_game_data.Status.GameplayVariables, cheat.player_list[LocalPlayer]

		project_delta.fps_reloadtypes.magazine = LPH_JIT(function(fps_object, arg_mag)
			if not instant_reload then
				return old_reload_magazine(fps_object, arg_mag)
			end

			local mag = arg_mag or get_compatible_mag(fps_object)
			if not mag then
				return
			end

			local equipped_item = lpo.current_weapon
			local equip_id = local_gameplayvars:GetAttribute("EquipId")
			if not (equipped_item and equip_id) then
				return
			end


			
			equip_remote:FireServer()
			task.defer(function()
				local s = 0
				local oldparent = mag.Parent
				repeat
					s += task.wait()
				until s > 1 or (mag and oldparent and mag.Parent and mag.Parent ~= oldparent)
				if s > 1 then
					return print('reload timeout, terminating...')
				end
				update_fps(project_delta.fps_object)
			end)
			inventorymove_remote:FireServer(
				mag:GetAttribute("Slot") or mag:GetAttribute("SlotType"),
				"Magazine",
				mag.Parent,
				equipped_item.Attachments,
				nil
			)
			equip_remote:FireServer(equipped_item, equip_id)
		end)

		project_delta.fps_reloadtypes.loadByHand = LPH_JIT(function(fps_object, arg_ammo)
			if not instant_reload then
				return old_reload_loadbyhand(fps_object, arg_ammo)
			end

			local ammo, ammo_amount = get_compatible_ammo(fps_object, arg_ammo)
			--print(ammo, ammo_amount, arg_ammo, arg_ammo and arg_ammo:GetAttribute("Amount"))
			if not ammo then
				return
			end
			for i = 0, ammo_amount - 1 do
				if loadbyhand_async then
					reload_remote:InvokeServer(nil, 1, ammo)
					update_fps(fps_object)
				else
					task.delay(i * loadbyhand_delay, function()
						reload_remote:InvokeServer(nil, 1, ammo)
						update_fps(fps_object)
					end)
				end
			end
		end)

		project_delta.add_fps_hook(function()
			local fps_object = project_delta.fps_object
			for name, spring in fps_object.springs do
				local old_shove, old_update = spring.shove, spring.update
				spring.shove = LPH_NO_VIRTUALIZE(function(...)
					if spring_disablers[name] then return end
					return old_shove(...)
				end)
				spring.update = LPH_NO_VIRTUALIZE(function(...)
					if spring_disablers[name] then return Vector3.zero end
					return old_update(...)
				end)
			end
		end)

		local old_updateclient
		local new_update = LPH_NO_VIRTUALIZE(function(fps_object, delta)
			if instant_aim then
				fps_object.AimInSpeed = 0
				fps_object.AimOutSpeed = 0
			end
			if force_auto or rapid_fire then
				if rapid_fire then fps_object.FireRate = rapid_fire_speed end
				local firemodes = fps_object.FireModes or {"Auto"}
				for i = 1, #firemodes do
					firemodes[i] = "Auto"
				end
				fps_object.FireModes = firemodes
			end
			return old_updateclient(fps_object, delta)
		end)

		project_delta.add_fps_hook(function()
			local fps_object = project_delta.fps_object
			old_updateclient = fps_object.updateClient
			fps_object.updateClient = new_update
		end)
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

	local ammo_types = {}
	for i, v in game:GetService("ReplicatedStorage").AmmoTypes:GetChildren() do
		ammo_types[v.Name] = v
	end

	local fps_usetypes, get_estimated_origin = project_delta.fps_usetypes, project_delta.get_estimated_origin
	local is_visible, valid_hitboxes = cheat.is_visible, project_delta.hitboxes
	local target_wall_penetration = project_delta.target_wall_penetration
	task.spawn(LPH_NO_VIRTUALIZE(function()
		while task.wait() do
			local indtxt = ""

			target_part, target_player, target_character = nil, nil, nil

			if not aimbot_enabled then
				indicator.text = indtxt
				continue
			end

			local viewport_size, field_of_view = Camera.ViewportSize, Camera.FieldOfView
			local new_fov_size = (viewport_size.X * (fov_size / field_of_view)) / 2

			local maximum_distance = math.huge
			local target_list = get_targets_in_fov(new_fov_size, aimbot_part, aimbot_team_check, aimbot_dead_check, aimbot_dist_check, aimbot_max_distance, aimbot_npc_check, aimbot_screen_check)
			if #target_list > 0 then
				target_part, target_player, target_character = unpack(target_list[1])
			end

			if aimbot_mode ~= "Silent" then continue end

			if not (autoshoot and autoshoot_key and target_part) then continue end

			local character = LocalPlayer.Character
			local hrp = character and _FindFirstChild(character, "HumanoidRootPart")
			local hmm_origin = hrp and get_estimated_origin(LocalPlayer)

			if not hmm_origin then continue end
			
			local picked_target = false

			local fps_object = project_delta.fps_object
			local bullet_type, penetration_power
			if autowall then
				local bullets_list = fps_object.BulletsList
				if fps_object.Bullets > 0 then
					local last = #bullets_list
					if bullets_list[last].Amount > 0 then
						bullet_type = bullets_list[last].AmmoType
					else
						bullet_type = bullets_list[last - 1].AmmoType
					end
				end
				if bullet_type then
					bullet_stats = ammo_types[bullet_type]
				end
			end

			for _, target in target_list do
				local aimpart, player, character, distance = unpack(target)

				for _, hitbox in hitscan_hitboxes do
					local hitscan_part = _FindFirstChild(character, hitbox)
					if not hitscan_part then continue end
					
					if autowall and bullet_stats then
						if not target_wall_penetration(hmm_origin, character, hitscan_part, hitscan_part.Position, bullet_stats) then continue end
						
						target_part, target_player, target_character = hitscan_part, player, character
						picked_target = true

						break
					end
					local vis, res = is_visible(hmm_origin, character, hitscan_part)
					if not (vis and valid_hitboxes[res.Instance.Name]) then continue end
					
					target_part, target_player, target_character = hitscan_part, player, character
					picked_target = true

					break
				end

				if picked_target then
					break
				end
			end
			
			if not picked_target then
				continue
			end
			
			local fps_object = project_delta.fps_object
			local use_module_name = fps_object and fps_object.useModuleName
			local use_func = use_module_name and fps_usetypes[use_module_name]
			if type(fps_object) == "table" and use_module_name == "RangedWeaponDefault" then
				pcall(use_func, fps_object)
			end
		end
	end))
	cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function()
		local mpos = UserInputService:GetMouseLocation()
		if fov_show then
			local viewportsize = Camera.ViewportSize
			local new_fov_size = (viewportsize.X * (fov_size / Camera.FieldOfView)) / 2

			CircleInline.Position = mpos
			CircleInline.Radius = new_fov_size
			CircleInline.Color = fov_color
			CircleInline.Visible = true
			CircleInline.NumSides = fov_sides

			CircleOutline.Position = mpos
			CircleOutline.Radius = new_fov_size
			CircleOutline.Visible = fov_outline
			CircleOutline.NumSides = fov_sides
		else
			CircleInline.Visible = false
			CircleOutline.Visible = false
		end
		if aimbot_enabled and aimbot_enabled_key and target_part and target_character then
			local new_pos = target_part.Position
			if aimbot_mode == "Mouse" then
				local pos = _WorldToViewportPoint(Camera, new_pos)
				local mpos = UserInputService:GetMouseLocation()
				mousemoverel(math.ceil((pos.X - mpos.X) * aimbot_smoothness), math.ceil((pos.Y - mpos.Y) * aimbot_smoothness))
			end
			if aimbot_mode == "Camera" then
				Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, new_pos), aimbot_smoothness)
			end
		end
	end))
end

local fov_changer, fov_changer_size = false, 100
local zoom, zoom_key, zoom_size = false, false, 10
local aspect_ratio, aspect_ratio_x, aspect_ratio_y = false, 1, 1
local thirdperson, thirdperson_key, thirdperson_distance = false, false, 10
do
	-- TODO: add fucking misc esp...
	local espsec = ui.sections.player_esp
	local setsec = ui.sections.esp_settings
	local itmsec = ui.sections.item_esp
	local othsec = ui.sections.other_esp
	local mscsec = ui.sections.visuals_misc
	local lclsec = ui.sections.visuals_local

	local enemy_sets = cheat.EspLibrary.settings.enemy
	local enemy_main_sets = cheat.EspLibrary.settings.enemy.main_settings

	local item_sets = cheat.EspLibrary.settings.item
	local item_main_sets = cheat.EspLibrary.settings.item.main_settings

	local corpse_sets = cheat.EspLibrary.settings.corpse
	local corpse_main_sets = cheat.EspLibrary.settings.corpse.main_settings


	do -- espsec
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
			local outline_toggle = espsec:Toggle({Name = "Box outline", Value = false, Flag = "esp_box_outline", Callback = function(bool)
				enemy_sets.box_outline = bool
				cheat.EspLibrary.icaca()
			end})
			outline_toggle:Colorpicker({Name = "Box outline color left", Value = Color3.new(), Usealpha = true, Flag = "esp_box_outline_color_left", Callback = function(color)
				enemy_sets.box_outline_color[1] = color.c
				enemy_sets.box_outline_color[2] = color.a
				cheat.EspLibrary.icaca()
			end})
			outline_toggle:Colorpicker({Name = "Box outline color right", Value = Color3.new(), Usealpha = true, Flag = "esp_box_outline_color_right", Callback = function(color)
				enemy_sets.box_outline_color[3] = color.c
				enemy_sets.box_outline_color[4] = color.a
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
	do -- set sec (flags)
		local player_list = cheat.player_list
		local report_list = cheat.report_list
		local flag_settings = {
			["Target"] = false,
			["Team"] = false,
			["Friend"] = false,
			["Visor"] = false,
			["Desynced"] = false,
			["Visible"] = false,
			["NPC"] = false,
			["KD"] = false,
			["Suspiciousness"] = false
		}
		setsec:Dropdown({Name = "Flags", Values = {"Target", "Team", "Friend", "Visor", "Desynced", "Visible", "NPC", "KD", "Suspiciousness"}, Value = {}, Flag = "esp_selected_flags", Multi = true, Callback = function(tbl)
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
			local tp = player_list[player]
			return flag_settings["Friend"] and tp and tp.friend
		end))
		cheat.EspLibrary.register_flag("VISOR", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			local tp = player_list[player]
			return flag_settings["Visor"] and tp and tp.visor
		end))
		cheat.EspLibrary.register_flag("DSYNC", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			local tp = player_list[player]
			local server_position = tp and tp.server_position
			local hrp = _FindFirstChild(character, "HumanoidRootPart")
			return flag_settings["Desynced"] and server_position and hrp and (server_position - hrp.CFrame.Position).Magnitude > 3
		end))
		cheat.EspLibrary.register_flag("VIS", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			local tp = player_list[player]	
			return flag_settings["Visible"] and tp and tp.visible
		end))
		cheat.EspLibrary.register_flag("NPC", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			return flag_settings["NPC"] and player == character
		end))
		cheat.EspLibrary.register_flag("... KD", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			local tp = player_list[player]
			if not (flag_settings["KD"] and tp) then
				return false
			end
			local status = _FindFirstChild(tp.game_data, "Status")
			local journey = status and _FindFirstChild(status, "Journey")
			local stats = journey and _FindFirstChild(journey, "Statistics")
			if not stats then
				return true, ("??? KD (%* %* %* %*)"):format(tp.game_data, status, journey, stats)
			end
			local kills = stats:GetAttribute("Kills")
			local deaths = stats:GetAttribute("Deaths")
			if not (kills and deaths) then
				return true, ("? KD (%* %*)"):format(kills, deaths)
			end

			deaths = deaths and (deaths == 0 and 1 or deaths) or 1
			return true, ("%.1f KD"):format(kills/deaths)
		end))
		
		cheat.EspLibrary.register_flag("SUSSY", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			if not flag_settings["Suspiciousness"] then
				return false
			end


			local player_object = player_list[player]
			if not player_object then
				return false
			end

			local report_object = report_list[player.Name]

			local text = ""

			if report_object then
				if report_object.mw > 0 then
					text ..= "!! CHEATER !!"
				end
				if report_object.rr > 0 then
					text ..= ("%*RR: %*"):format(text ~= "" and " " or "", report_object.rr)
				end
			end

			if player_object.reports then
				local reports = player_object.reports
				text ..= ("%*%*"):format(text ~= "" and " " or "", `:: {reports}`)
			end

			return true, text
		end))
	end
	do -- set sec (settings)
		setsec:Dropdown({Name = "Checks", Values = {"Team check", "Dead check", "Distance check", "NPC check"}, Value = {}, Flag = "esp_checks", Multi = true, Callback = function(tbl)
			local funny = {
				["Team check"] = "team_check",
				["Dead check"] = "dead_check",
				["Distance check"] = "dist_check",
				["NPC check"] = "npc_check"
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
		setsec:Slider({Name = "Max distance", Min = 0, Max = 2000, Float = 10, Value = 200, Flag = "esp_max_distance", Callback = function(int)
			enemy_main_sets.max_distance = int * 3
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
	do -- itm sec
		itmsec:Toggle({Name = "Item ESP", Value = false, Flag = "esp_item", Callback = function(bool)
			item_sets.enabled = bool
			cheat.EspLibrary.icaca()
		end}):Colorpicker({Name = "Item Color", Value = Color3.new(1, 1, 1), Usealpha = true, Flag = "esp_item_color", Callback = function(color)
			item_sets.text_color = {color.c, color.a}
			cheat.EspLibrary.icaca()
		end})
		itmsec:Toggle({Name = "Show distance", Value = false, Flag = "esp_item_distance", Callback = function(bool)
			item_sets.distance = bool
			cheat.EspLibrary.icaca()
		end})
		itmsec:Toggle({Name = "Show amount", Value = false, Flag = "esp_item_amount", Callback = function(bool)
			item_sets.amount = bool
			cheat.EspLibrary.icaca()
		end})
		itmsec:Toggle({Name = "Show durability", Value = false, Flag = "esp_item_durability", Callback = function(bool)
			item_sets.durability = bool
			cheat.EspLibrary.icaca()
		end})
		itmsec:Toggle({Name = "Show durability bar", Value = false, Flag = "esp_item_durability_bar", Callback = function(bool)
			item_sets.durability_bar = bool
			cheat.EspLibrary.icaca()
		end})
		itmsec:Slider({Name = "Max distance (0 = inf)", Min = 0, Max = 200, Float = 1, Value = 10, Flag = "esp_item_max_distance", Callback = function(int)
			item_main_sets.dist_check = int > 0
			item_main_sets.max_distance = int * 3
			cheat.EspLibrary.icaca()
		end})
	end
	do -- oth sec
		othsec:Toggle({Name = "Corpse ESP", Value = false, Flag = "esp_corpse", Callback = function(bool)
			corpse_sets.enabled = bool
			cheat.EspLibrary.icaca()
		end}):Colorpicker({Name = "Corpse Color", Value = Color3.new(1, 1, 1), Usealpha = true, Flag = "esp_corpse_color", Callback = function(color)
			corpse_sets.text_color = {color.c, color.a}
			cheat.EspLibrary.icaca()
		end})
		othsec:Toggle({Name = "Show distance", Value = false, Flag = "esp_corpse_distance", Callback = function(bool)
			corpse_sets.distance = bool
			cheat.EspLibrary.icaca()
		end})
		othsec:Slider({Name = "Max distance (0 = inf)", Min = 0, Max = 1000, Float = 10, Value = 100, Flag = "esp_corpse_max_distance", Callback = function(int)
			corpse_main_sets.dist_check = int > 0
			corpse_main_sets.max_distance = int * 3
			cheat.EspLibrary.icaca()
		end})
	end

	local no_screen_effects, viewmodel_changer, gun_changer, arm_changer = false, false, false, false
	local gun_color, gun_material, arm_color, arm_material = Color3.new(1, 1, 1), Enum.Material.ForceField, Color3.new(1, 1, 1), Enum.Material.ForceField
	local viewmodel_x, viewmodel_y, viewmodel_z = 0, 0, 0
	local leftarm_old, rightarm_old, itemroot_old, motor6d_old

	local function vmpos(vm)
		if not viewmodel_changer then return end
		local hrp = _FindFirstChild(vm, "HumanoidRootPart")
		local vec = _Vector3new(viewmodel_x, thirdperson_key and -100 or viewmodel_y, thirdperson_key and 100 or viewmodel_z)
		local leftarm_weld = hrp and _FindFirstChild(hrp, "LeftUpperArm")
		local rightarm_weld = hrp and _FindFirstChild(hrp, "RightUpperArm")
		local itemroot_weld = hrp and _FindFirstChild(hrp, "ItemRoot")
		local motor6d_weld = hrp and _FindFirstChild(hrp, "Motor6D")
		if leftarm_weld then
			if not leftarm_old then leftarm_old = leftarm_weld.C0 end
			leftarm_weld.C0 = leftarm_old + vec
		end
		if rightarm_weld then
			if not rightarm_old then rightarm_old = rightarm_weld.C0 end
			rightarm_weld.C0 = rightarm_old + vec
		end
		if itemroot_weld then
			if not itemroot_old then itemroot_old = itemroot_weld.C0 end
			itemroot_weld.C0 = itemroot_old + vec
		end
		if motor6d_weld then
			if not motor6d_old then motor6d_old = motor6d_weld.C0 end
			motor6d_weld.C0 = motor6d_old + vec
		end
	end
	local function vmunpos()
		if not viewmodel_changer then return end
		leftarm_old, rightarm_old, motor6d_old = nil, nil, nil
	end
	local vmchams = LPH_NO_VIRTUALIZE(function()
		local vm = _FindFirstChildOfClass(Camera, "Model")
		if not vm then return end
		local viewmodel_item = _FindFirstChild(vm, "Item")
		if gun_changer and viewmodel_item then -- gun
			for _, v in viewmodel_item:GetDescendants() do
				local surfaceappearance = _FindFirstChildOfClass(v, "SurfaceAppearance")
				if _IsA(v, "BasePart") then
					v.Material = gun_material
					v.Color = gun_color
				end
				if surfaceappearance then
					surfaceappearance:Destroy()
				end
			end
		end
		if arm_changer then
			for _, vm_item in vm:GetChildren() do
				if _IsA(vm_item, "BasePart") then
					if vm_item.Name:find("Hand") or vm_item.Name:find("Arm") then
						vm_item.Material = arm_material
						vm_item.Color = arm_color
					end
				end
				if vm_item.ClassName == "Model" and (_FindFirstChild(vm_item, "LL") or _FindFirstChild(vm_item, "LH")) then
					for _, shirt_item in (vm_item:GetChildren()) do
						local surfaceappearance = _FindFirstChildOfClass(shirt_item, "SurfaceAppearance")
						shirt_item.Material = arm_material
						shirt_item.Color = arm_color
						if surfaceappearance then
							surfaceappearance:Destroy()
						end
					end
				end
			end
		end
	end)

	do -- msc sec
		local old_fov = Camera.FieldOfView
		mscsec:Toggle({Name = "FOV Changer", Value = false, Flag = "view_fov_changer", Callback = function(bool)
			fov_changer = bool
			Camera.FieldOfView = (zoom and zoom_key and zoom_size) or (fov_changer and fov_changer_size) or old_fov
		end})
		mscsec:Slider({Name = "Desired FOV", Min = 50, Max = 120, Float = 1, Value = 100, Flag = "view_fov_changer_size", Callback = function(int)
			fov_changer_size = int
			Camera.FieldOfView = (zoom and zoom_key and zoom_size) or (fov_changer and fov_changer_size) or old_fov
		end})
		local zoom_keybind; zoom_keybind = mscsec:Toggle({Name = "Zoom", Value = false, Flag = "view_zoom", Callback = function(bool)
			zoom = bool
			Camera.FieldOfView = (zoom and zoom_key and zoom_size) or (fov_changer and fov_changer_size) or old_fov
		end}):Keybind({Name = "Zoom", Mode = "Toggle", Key = Enum.KeyCode.Z, Value = false, Flag = "view_zoom_keybind", Callback = function(bool)
			zoom_key = zoom and bool
			zoom_keybind.Set(zoom_key, true)
			Camera.FieldOfView = (zoom and zoom_key and zoom_size) or (fov_changer and fov_changer_size) or old_fov
		end})
		mscsec:Slider({Name = "Desired zoom", Min = 1, Max = 50, Float = 1, Value = 20, Flag = "view_zoom_size", Callback = function(int)
			zoom_size = int
			Camera.FieldOfView = (zoom and zoom_key and zoom_size) or (fov_changer and fov_changer_size) or old_fov
		end})
		
		do
			local freecam, freecam_key, freecam_speed = false, false, 750
			local fc_keybind; fc_keybind = mscsec:Toggle({Name = "Freecam", Value = false, Flag = "view_freecam", Callback = function(bool)
				freecam = bool
			end}):Keybind({Name = "Freecam", Mode = "Toggle", Key = Enum.KeyCode.L, Value = false, Flag = "view_freecam_keybind", Callback = function(bool)
				freecam_key = freecam and bool
				fc_keybind.Set(freecam_key, true)
			end})
			mscsec:Slider({Name = "Freecam speed", Min = 100, Max = 1000, Float = 10, Value = 750, Flag = "view_freecam_speed", Callback = function(int)
				freecam_speed = int
			end})

			local new_camera_pos

			task.spawn(function()
				while task.wait(1/5) do
					local closest, distance = nil, math.huge
					if (freecam and freecam_key and new_camera_pos) then
						LPH_NO_VIRTUALIZE(function()
							for i, model in workspace:GetDescendants() do
								if not _IsA(model, "Model") then return end
								local primarypart = model.PrimaryPart
								if not primarypart then continue end
								local pos = primarypart.Position
								local ts_dist = (new_camera_pos - pos).Magnitude
								if ts_dist < distance then
									closest, distance = primarypart, ts_dist
								end
							end
						end)()
					end
					LocalPlayer.ReplicationFocus = closest
				end
			end)

			game:GetService("RunService").PreRender:Connect(LPH_NO_VIRTUALIZE(function(delta)
				local character = LocalPlayer.Character
				local hrp = character and _FindFirstChild(character, "HumanoidRootPart")

				if not (freecam and freecam_key) then
					new_camera_pos = nil
					if hrp then
						hrp.Anchored = false
					end
					return
				end
				if not new_camera_pos then
					new_camera_pos = Camera.CFrame.Position
				end

				local cameralook = Camera.CFrame.LookVector
				local direction = _Vector3new(0, 0, 0)
				direction = _IsKeyDown(UserInputService, Enum.KeyCode.W)         and direction + cameralook or direction;
				direction = _IsKeyDown(UserInputService, Enum.KeyCode.S)         and direction - cameralook or direction;
				direction = _IsKeyDown(UserInputService, Enum.KeyCode.D)         and direction + _Vector3new(-cameralook.Z, 0, cameralook.X) or direction;
				direction = _IsKeyDown(UserInputService, Enum.KeyCode.A)         and direction + _Vector3new(cameralook.Z, 0, -cameralook.X) or direction;
				direction = _IsKeyDown(UserInputService, Enum.KeyCode.Space)     and direction + Vector3.yAxis or direction;
				direction = _IsKeyDown(UserInputService, Enum.KeyCode.LeftControl) and direction - Vector3.yAxis or direction;
				
				if direction.Magnitude > 0 then direction = direction.Unit end
				new_camera_pos += direction * delta * (_IsKeyDown(UserInputService, Enum.KeyCode.LeftShift) and freecam_speed / 10 or freecam_speed)
				Camera.CFrame = CFrame.new(new_camera_pos) * Camera.CFrame.Rotation
				if hrp then
					hrp.Anchored = true
				end
			end))
		end
		
		local tp_keybind; tp_keybind = mscsec:Toggle({Name = "Thirdperson", Value = false, Flag = "view_thirdperson", Callback = function(bool)
			thirdperson = bool
		end}):Keybind({Name = "Thirdperson", Mode = "Toggle", Key = Enum.KeyCode.N, Value = false, Flag = "view_thirdperson_keybind", Callback = function(bool)
			thirdperson_key = thirdperson and bool
			tp_keybind.Set(thirdperson_key, true)

			local viewmodel = _FindFirstChildOfClass(Camera, "Model")
			if viewmodel then
				vmpos(viewmodel)
			end
		end})
		mscsec:Slider({Name = "Thirdperson distance", Min = 0, Max = 15, Float = 0.1, Value = 5, Flag = "view_thirdperson_distance", Callback = function(int)
			thirdperson_distance = int
		end})
		
		mscsec:Toggle({Name = "Aspect ratio", Value = false, Flag = "view_aspect_ratio", Callback = function(bool)
			aspect_ratio = bool
		end})
		mscsec:Slider({Name = "Aspect X", Min = 0.5, Max = 1.1, Float = 0.01, Value = 1, Flag = "aspect_ratio_x", Callback = function(int)
			aspect_ratio_x = int
		end})
		mscsec:Slider({Name = "Aspect Y", Min = 0.5, Max = 1.1, Float = 0.01, Value = 1, Flag = "aspect_ratio_y", Callback = function(int)
			aspect_ratio_y = int
		end})
		--[[
		local avatar_changer_used = false

		local avatar_userid_textbox = mscsec:Textbox({
			Name = "Avatar UserId",
			Value = "80254",
			Flag = "view_avatar_userid"
		})

		mscsec:Button({Name = "Set avatar", Confirm = false, Callback = function()
			avatar_changer_used = true

			local user_id = Library.Flags["view_avatar_userid"]
			local success, result = pcall(tonumber, user_id)
			if not success then
				return Library.Notification("Invalid number inputted", 2.5)
			end

			local valid_parts = {
				["Head"] = true,
				["LeftFoot"] = true,
				["LeftHand"] = true,
				["LeftLowerArm"] = true,
				["LeftLowerLeg"] = true,
				["LeftUpperArm"] = true,
				["LeftUpperLeg"] = true,
				["RightFoot"] = true,
				["RightHand"] = true,
				["RightLowerArm"] = true,
				["RightLowerLeg"] = true,
				["RightUpperArm"] = true,
				["RightUpperLeg"] = true,
				["LowerTorso"] = true,
				["UpperTorso"] = true
			}

			local success, wanted_plr_model = pcall(Players.CreateHumanoidModelFromUserId, Players, user_id)
			if not success then
				return Library.Notification("Invalid UserId inputted or try again later.", 2.5)
			end

			local character = LocalPlayer.Character

			if not character then
				return
			end

			for _, child in character:GetChildren() do
				local class = child.ClassName
				
				if class == "Accessory" then
					child:Destroy()
				end

				if child:GetAttribute("ItemType") then
					child:Destroy()
				end
			end

			for _, child in wanted_plr_model:GetChildren() do
				local class = child.ClassName
				
				if class == "Shirt" or class == "Pants" then
					local stuff = character:FindFirstChildOfClass(class)
					if not stuff then continue end

					stuff[class.."Template"] = child[class.."Template"]
				end

				if class == "Accessory" then
					local handle = child:FindFirstChild("Handle")
					local weld = handle and handle:FindFirstChild("AccessoryWeld")
					if not weld then continue end
					
					local weld_part = character:FindFirstChild(weld.Part1.Name)
					if not weld_part then continue end

					weld.Part1 = weld_part
					child.Parent = character
				end

				if class == "MeshPart" and valid_parts[child.Name] then
					local grrr = character:FindFirstChild(child.Name)
					if not grrr then continue end
					
					grrr.Color = child.Color
				end
			end

			wanted_plr_model:Destroy()
		end})

		local character_childadded
		if LocalPlayer.Character then
			character_childadded = LocalPlayer.Character.ChildAdded:Connect(function(child)
				if avatar_changer_used and child:GetAttribute("ItemType") then child:Destroy() end
			end)
		end
		LocalPlayer.CharacterAdded:Connect(function(character)
			avatar_changer_used = false
			character_childadded = character.ChildAdded:Connect(function(child)
				if avatar_changer_used and child:GetAttribute("ItemType") then child:Destroy() end
			end)
		end)

		LocalPlayer.CharacterRemoving:Connect(function(character)
			if character_childadded then character_childadded:Disconnect() end
		end)]]

		local avatar_changer = false
		local avatar_changer_used = false

		local change_avatar = function()
			if not avatar_changer then return end

			avatar_changer_used = true

			local user_id = Library.Flags["view_avatar_userid"]
			local success, result = pcall(tonumber, user_id)
			if not success then
				return Library.Notification("Invalid number inputted", 2.5)
			end

			local valid_parts = {
				["Head"] = true,
				["LeftFoot"] = true,
				["LeftHand"] = true,
				["LeftLowerArm"] = true,
				["LeftLowerLeg"] = true,
				["LeftUpperArm"] = true,
				["LeftUpperLeg"] = true,
				["RightFoot"] = true,
				["RightHand"] = true,
				["RightLowerArm"] = true,
				["RightLowerLeg"] = true,
				["RightUpperArm"] = true,
				["RightUpperLeg"] = true,
				["LowerTorso"] = true,
				["UpperTorso"] = true
			}

			local success, wanted_plr_model = pcall(Players.CreateHumanoidModelFromUserId, Players, user_id)
			if not success then
				return Library.Notification("Invalid UserId inputted or try again later.", 2.5)
			end

			local character = LocalPlayer.Character

			if not character then
				return
			end

			for _, child in character:GetChildren() do
				local class = child.ClassName
				
				if class == "Accessory" then
					child:Destroy()
				end

				if child:GetAttribute("ItemType") then
					child:Destroy()
				end
			end

			for _, child in wanted_plr_model:GetChildren() do
				local class = child.ClassName
				
				if class == "Shirt" or class == "Pants" then
					local stuff = character:FindFirstChildOfClass(class)
					if not stuff then continue end

					stuff[class.."Template"] = child[class.."Template"]
				end

				if class == "Accessory" then
					local handle = child:FindFirstChild("Handle")
					local weld = handle and handle:FindFirstChild("AccessoryWeld")
					if not weld then continue end
					
					local weld_part = character:FindFirstChild(weld.Part1.Name)
					if not weld_part then continue end

					weld.Part1 = weld_part
					child.Parent = character
				end

				if class == "MeshPart" and valid_parts[child.Name] then
					local grrr = character:FindFirstChild(child.Name)
					if not grrr then continue end
					
					grrr.Color = child.Color
				end
			end

			wanted_plr_model:Destroy()
		end

		mscsec:Toggle({Name = "Avatar changer", Value = false, Flag = "view_avatar_changer", Callback = function(bool)
			avatar_changer = bool
			task.spawn(change_avatar)
		end})
		
		mscsec:Textbox({
			Name = "Avatar UserId",
			Value = "80254",
			Flag = "view_avatar_userid",
			Callback = function()
				task.spawn(change_avatar)
			end
		})

		local character_childadded
		if LocalPlayer.Character then
			task.spawn(change_avatar)
			character_childadded = LocalPlayer.Character.ChildAdded:Connect(function(child)
				if avatar_changer_used and child:GetAttribute("ItemType") then child:Destroy() end
			end)
		end
		LocalPlayer.CharacterAdded:Connect(function(character)
			avatar_changer_used = false
			task.spawn(change_avatar)
			character_childadded = character.ChildAdded:Connect(function(child)
				if avatar_changer_used and child:GetAttribute("ItemType") then child:Destroy() end
			end)
		end)

		LocalPlayer.CharacterRemoving:Connect(function(character)
			if character_childadded then character_childadded:Disconnect() end
		end)

		Camera.DescendantAdded:Connect(function()
			if not avatar_changer_used then return end
			local vm = _FindFirstChildOfClass(Camera, "Model")
			if not vm then return end
			for _, vm_item in vm:GetChildren() do
				if vm_item.ClassName == "Model" and (_FindFirstChild(vm_item, "LL") or _FindFirstChild(vm_item, "LH")) then
					vm_item:Destroy()
				end
			end
		end)

		Camera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
			if Camera.FieldOfView ~= zoom_size and Camera.FieldOfView ~= fov_changer_size then
				old_fov = Camera.FieldOfView
			end
			if not (zoom and zoom_key or fov_changer) then return end 
			Camera.FieldOfView = (zoom and zoom_key and zoom_size) or (fov_changer and fov_changer_size)
		end)

		local NeckDefaultC0 = CFrame.new(0, 0.8, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		local WaistDefaultC0 = CFrame.new(0, 0.2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		local RightShoulderDefaultC0 = CFrame.new(1, 0.5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		local LeftShoulderDefaultC0 = CFrame.new(-1, 0.5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)

		local update_neck_loop = function(Character)
			while Character and LocalPlayer.Character == Character do
				local Delta, Head
				repeat
					Delta = task.wait(1/60) / 0.2
					Head = _FindFirstChild(Character, "Head")
				until Head
				local Humanoid = _FindFirstChild(Character, "Humanoid")
				if not (Humanoid and Humanoid.Health ~= 0) then
					continue
				end
				local UpperTorso	= _FindFirstChild(Character, "UpperTorso")
				local RightUpperArm = _FindFirstChild(Character, "RightUpperArm")
				local LeftUpperArm  = _FindFirstChild(Character, "LeftUpperArm")
				if not (UpperTorso and RightUpperArm and LeftUpperArm) then continue end
				local Waist		 = _FindFirstChild(UpperTorso, "Waist")
				local Neck		  = _FindFirstChild(Head, "Neck")
				local RightShoulder = _FindFirstChild(RightUpperArm, "RightShoulder")
				local LeftShoulder  = _FindFirstChild(LeftUpperArm, "LeftShoulder")
				if not (Waist and Neck and RightShoulder and LeftShoulder) then continue end

				local LookAt = _FindFirstChild(Character, "LookAt")
				if LookAt then
					local NewUpAngle
					if LookAt.Value then
						local FunnyMath = _CFramenew(Character:GetPivot().Position, LookAt.Value:GetPivot().Position).lookVector.Y * 0.55
						NewUpAngle = math.asin(FunnyMath) or 0
					else
						NewUpAngle = 0
					end
					Character:SetAttribute("UpAngle", NewUpAngle)
				end
				local UpAngle	   = (thirdperson and thirdperson_key) and Character:GetAttribute("UpAngle") or 0
				local SideAngle	 = (thirdperson and thirdperson_key) and Character:GetAttribute("SideAngle") or 0
				local HeadUpAngle   = (thirdperson and thirdperson_key) and Character:GetAttribute("HeadUpAngle") or 0
				local HeadSideAngle = (thirdperson and thirdperson_key) and Character:GetAttribute("HeadSideAngle") or 0
				local CalculatedCFrame = nil
				if Humanoid.SeatPart then
					if Humanoid.SeatPart.ClassName == "VehicleSeat" then
						CalculatedCFrame = CFrame.Angles(UpAngle, SideAngle / 3, 0)
						Neck.C0 = Neck.C0:lerp(NeckDefaultC0 * CalculatedCFrame, Delta)
					else
						CalculatedCFrame = CFrame.Angles(UpAngle, SideAngle / 4, 0)
						Waist.C0 = Waist.C0:lerp(WaistDefaultC0 * CFrame.Angles(UpAngle / 4, SideAngle / 3, 0), Delta)
						Neck.C0 = Neck.C0:lerp(NeckDefaultC0 * CalculatedCFrame, Delta)
						RightShoulder.C0 = RightShoulder.C0:lerp(RightShoulderDefaultC0 * CalculatedCFrame, Delta)
						LeftShoulder.C0 = LeftShoulder.C0:lerp(LeftShoulderDefaultC0 * CalculatedCFrame, Delta)
					end
				elseif HeadSideAngle == 0 then
					CalculatedCFrame = CFrame.Angles(UpAngle, 0, 0)
					Waist.C0 = Waist.C0:lerp(WaistDefaultC0 * CalculatedCFrame, Delta)
					Neck.C0 = Neck.C0:lerp(NeckDefaultC0 * CalculatedCFrame, Delta)
					RightShoulder.C0 = RightShoulder.C0:lerp(RightShoulderDefaultC0 * CalculatedCFrame, Delta)
					LeftShoulder.C0 = LeftShoulder.C0:lerp(LeftShoulderDefaultC0 * CalculatedCFrame, Delta)
				else
					Neck.C0 = Neck.C0:lerp(NeckDefaultC0 * CFrame.Angles(HeadUpAngle, HeadSideAngle, 0), Delta)
				end
				if CalculatedCFrame then
					for _, part in Character:GetChildren() do
						if part.ClassName == "Model" and part:FindFirstChild("ItemRoot") then
							local Motor6D = part.ItemRoot:FindFirstChild("Motor6D")
							if Motor6D then
								Motor6D.C0 = Motor6D.C0:lerp(CFrame.new(0, 0, -UpAngle * 0.5) * CalculatedCFrame, Delta)
							end
						end
					end
				end
			end
		end

		if LocalPlayer.Character then task.spawn(update_neck_loop, LocalPlayer.Character) end
		LocalPlayer.CharacterAdded:Connect(update_neck_loop)
	end
	do -- lcl sec
		do
			local indicator_holder = Instance.new("Frame")
			indicator_holder.Parent = game:GetService("CoreGui").RobloxGui
			indicator_holder.BackgroundTransparency = 1
			indicator_holder.BorderSizePixel = 0
			indicator_holder.Position = UDim2.new(0, -GuiInset.X, 0, -GuiInset.Y)
			indicator_holder.ZIndex = 2

			local default_font = Fonts.Get("SmallestPixel7")

			local indicator_text = Instance.new("TextLabel")
			indicator_text.Parent = indicator_holder
			indicator_text.AnchorPoint = Vector2.new(0, 0)
			indicator_text.BackgroundTransparency = 1
			indicator_text.BorderSizePixel = 0
			indicator_text.Position = UDim2.new(0, 2, 0, 0)
			indicator_text.FontFace = default_font
			indicator_text.Text = ""--"xXx_sw1mdr0id_xXx's Inventory\n[Hotbar]\n\tMP5SD\n\tAKMN\n\tAKMN\n"
			indicator_text.TextColor3 = Color3.new(1, 1, 1)
			indicator_text.TextSize = 9
			indicator_text.TextStrokeTransparency = 0
			indicator_text.TextXAlignment = Enum.TextXAlignment.Left
			indicator_text.TextYAlignment = Enum.TextYAlignment.Top

			local off_color, on_color = Color3.new(1, 0.1, 0.1), Color3.new(0.1, 1, 0.1)
			local off_transparency, on_transparency = 0, 0

			do
				local toggle = lclsec:Toggle({Name = "Visor indicator", Value = false, Flag = "visor_indicator", Callback = function(bool)
					indicator_holder.Visible = bool
				end})
				toggle:Colorpicker({Name = "Indicator Off Color", Value = Color3.new(1, 0.3, 0.3), Usealpha = true, Flag = "visor_indicator_off_color", Callback = function(color)
					off_color = color.c
					off_transparency = color.a
				end})
				toggle:Colorpicker({Name = "Indicator On Color", Value = Color3.new(0.3, 1, 0.3), Usealpha = true, Flag = "visor_indicator_on_color", Callback = function(color)
					on_color = color.c
					on_transparency = color.a
				end})
			end
			lclsec:Dropdown({Name = "Indicator font", Values = {
				"Tahoma",
				"TahomaXP",
				"Comfortaa",
				"Verdana",
				"SmallestPixel7",
				"Proggy",
			}, Value = {"SmallestPixel7"}, Flag = "visor_indicator_font", Multi = false, Callback = function(str)
				indicator_text.FontFace = Fonts.Get(str or "SmallestPixel7") or default_font
			end})
			lclsec:Slider({Name = "Indicator size", Min = 1, Max = 30, Float = 1, Value = 9, Flag = "visor_indicator_size", Suffix = "%spx", Callback = function(int)
				indicator_text.TextSize = int
			end})
			lclsec:Slider({Name = "Indicator X", Min = 0, Max = 100, Float = 1, Value = 5, Flag = "visor_indicator_x", Suffix = "%s%%", Callback = function(int)
				indicator_holder.Position = UDim2.new(int / 100, -GuiInset.X, indicator_holder.Position.Y.Scale, -GuiInset.Y)
				indicator_text.TextXAlignment = int < 50 and Enum.TextXAlignment.Left or int > 50 and Enum.TextXAlignment.Right or Enum.TextXAlignment.Center
				indicator_text.Position = UDim2.new(int < 50 and 0 or int > 50 and 1 or 0.5, 0, 0, 0)
				indicator_text.AnchorPoint = Vector2.new(int < 50 and 0 or int > 50 and 1 or 0.5, 0)
			end})
			lclsec:Slider({Name = "Indicator Y", Min = 0, Max = 100, Float = 1, Value = 5, Flag = "visor_indicator_y", Suffix = "%s%%", Callback = function(int)
				indicator_holder.Position = UDim2.new(indicator_holder.Position.X.Scale, -GuiInset.X, int / 100, -GuiInset.Y)
				--print(indicator_holder.Position)
			end})

			local lpo = cheat.player_list[LocalPlayer]
			cheat.utility.new_heartbeat(LPH_JIT(function()		
				if lpo.visor then
					indicator_text.Text = "visor on"
					indicator_text.TextColor3 = on_color
					indicator_text.TextTransparency = on_transparency
				else
					indicator_text.Text = "visor off"
					indicator_text.TextColor3 = off_color
					indicator_text.TextTransparency = off_transparency
				end
			end))
		end
		lclsec:Toggle({Name = "Remove screen effects", Value = false, Flag = "no_screen_effects", Callback = function(bool)
			no_screen_effects = bool
		end})

		lclsec:Toggle({Name = "Gun changer", Value = false, Flag = "gun_changer", Callback = function(bool)
			gun_changer = bool
		end})
		lclsec:Colorpicker({Name = "Gun color", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "gun_color", Callback = function(color)
			gun_color = color.c
		end})
		lclsec:Dropdown({Name = "Gun material", Values = {"ForceField", "Neon", "SmoothPlastic", "Glass"}, Value = "ForceField", Flag = "gun_material", Multi = false, Callback = function(str)
			gun_material = str and Enum.Material[str] or Enum.Material.ForceField
		end})

		lclsec:Toggle({Name = "Arm changer", Value = false, Flag = "arm_changer", Callback = function(bool)
			arm_changer = bool
		end})
		lclsec:Colorpicker({Name = "Arm color", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "arm_color", Callback = function(color)
			arm_color = color.c
		end})
		lclsec:Dropdown({Name = "Arm material", Values = {"ForceField", "Neon", "SmoothPlastic", "Glass"}, Value = "ForceField", Flag = "arm_material", Multi = false, Callback = function(str)
			arm_material = str and Enum.Material[str] or Enum.Material.ForceField
		end})

		lclsec:Toggle({Name = "Viewmodel changer", Value = false, Flag = "viewmodel_changer", Callback = function(bool)
			viewmodel_changer = bool
		end})
		lclsec:Slider({Name = "X offset", Min = -5, Max = 5, Float = 0.1, Value = 0, Flag = "viewmodel_x", Callback = function(int)
			viewmodel_x = int
			if not viewmodel_changer then
				return
			end
			local viewmodel = _FindFirstChildOfClass(Camera, "Model")
			if viewmodel then
				vmpos(viewmodel)
			end
		end})
		lclsec:Slider({Name = "Y offset", Min = -5, Max = 5, Float = 0.1, Value = 0, Flag = "viewmodel_y", Callback = function(int)
			viewmodel_y = int
			if not viewmodel_changer then
				return
			end
			local viewmodel = _FindFirstChildOfClass(Camera, "Model")
			if viewmodel then
				vmpos(viewmodel)
			end
		end})
		lclsec:Slider({Name = "Z offset", Min = -5, Max = 5, Float = 0.1, Value = 0, Flag = "viewmodel_z", Callback = function(int)
			viewmodel_z = int
			if not viewmodel_changer then
				return
			end
			local viewmodel = _FindFirstChildOfClass(Camera, "Model")
			if viewmodel then
				vmpos(viewmodel)
			end
		end})

		Camera.ChildAdded:Connect(vmpos)
		Camera.DescendantAdded:Connect(vmchams)
		Camera.ChildRemoved:Connect(vmunpos)

		task.spawn(function()
			while task.wait(0.5) do
				local playergui = LocalPlayer.PlayerGui
				local noinsetgui = playergui and _FindFirstChild(playergui, "NoInsetGui")
				local mainframe = noinsetgui and _FindFirstChild(noinsetgui, "MainFrame")
				local screeneffects = mainframe and _FindFirstChild(mainframe, "ScreenEffects")
				if screeneffects then screeneffects.Visible = not no_screen_effects end
			end
		end)
	end
end

local antiaim, antiaim_pitch, antiaim_pitch_value = false, false, 0

do
	local movebox = ui.sections.movement
	local miscbox = ui.sections.misc
	local antibox = ui.sections.antiaim
	local animbox = ui.sections.antiaim_animations

	local speedhack, speedhack_speed = false, 18.2
	local speedhack_autospeed, speedhack_autospeed_offset = false, 3.5

	local jumphack, jumphack_height = false, 5

	local flyhack, flyhack_key, flyhack_speed, flyhack_speed_y = false, false, 100, 100

	local antiaim_yaw, antiaim_jitter, antiaim_spin = false, false, false
	local antiaim_yaw_value, antiaim_jitter_value, antiaim_spin_value = 180, 0, 0
	do
		miscbox:Button({Name = "Rejoin", Confirm = true, Callback = function()
			if #Players:GetPlayers() <= 1 then
				LocalPlayer:Kick("\nRejoining...")
				wait()
				game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
			else
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
			end
		end})

		miscbox:Toggle({Name = "Hide server info", Value = false, Flag = "hide_server_info", Callback = function(bool)
			local playergui = LocalPlayer.PlayerGui
			local serverinfo = _FindFirstChild(playergui, "ServerInfo")
			local frame = serverinfo and _FindFirstChild(serverinfo, "Frame")
			local textlabel = frame and _FindFirstChild(frame, "serverInfo")
			if textlabel then
				textlabel.Visible = not bool
			end
		end})

		local shitcode, shitcode_tick, shitcode_factor = false, tick(), (mathrandom() - 0.5) * 5
		miscbox:Toggle({Name = "Old swimhub mode", Flag = "old_swimhub_mode", Value = false, Callback = function(v)
			shitcode = v
			shitcode_tick = tick()
			task.spawn(function()
				while shitcode do
					if tick() - shitcode_tick > 1/(24 + shitcode_factor) then
						shitcode_tick = tick()
						shitcode_factor = (mathrandom() - 0.5) * 5
						RunService.RenderStepped:Wait()
					end
				end
			end)
		end})

		local cross_script_chat; cross_script_chat = miscbox:Toggle({Name = "Cross-script chat", Flag = "cross_script_chat", Value = false, Callback = function(v)
			if v and not cheat.CrossScriptChat then
				cross_script_chat.Set(false, true)
				return Library.Notification("Cross-script chat is loading at the moment. Please wait.", 2.5)
			end
			if cheat.CrossScriptChat then
				cheat.CrossScriptChat.SetSendingEnabled(v)
			end
		end})
	end
	do
		local nofall = false

		movebox:Toggle({Name = "No fall damage", Value = false, Flag = "no_fall_damage", Callback = function(bool)
			nofall = bool
		end})

		local falling_states = {
			Enum.HumanoidStateType.FallingDown,
			Enum.HumanoidStateType.Freefall,
			Enum.HumanoidStateType.PlatformStanding
		}

		local character = LocalPlayer.Character
		local hum = character and _FindFirstChildOfClass(character, "Humanoid")
		local old_nofall_pos, should_no_fall = nil, false

		--[[game:GetService("RunService").PreSimulation:Connect(LPH_NO_VIRTUALIZE(function()
			local character = LocalPlayer.Character
			if not character then
				return
			end

			local hrp = _FindFirstChild(character, "HumanoidRootPart")
			local hum = _FindFirstChildOfClass(character, "Humanoid")
			if not (hrp and hum) then
				return
			end

			local currpos = hrp.CFrame.Position

			if not nofall or not table.find(falling_states, hum:GetState()) then
				should_no_fall = false
				return
			end

			hum:ChangeState(Enum.HumanoidStateType.Running)
			should_no_fall = true
		end))]]

		task.spawn(function()
			while RunService.Heartbeat:Wait() do
				local character = LocalPlayer.Character
				if not character then
					continue
				end

				local hrp = _FindFirstChild(character, "HumanoidRootPart")
				local hum = _FindFirstChildOfClass(character, "Humanoid")
				if not (hrp and hum) then
					continue
				end

				local currpos = hrp.CFrame.Position

				if not nofall or not table.find(falling_states, hum:GetState()) then
					should_no_fall = false
					continue
				end

				hum:ChangeState(Enum.HumanoidStateType.Running)
				should_no_fall = true
			end
		end)

		local state_changed = LPH_NO_VIRTUALIZE(function(old, new)
			if should_no_fall and table.find(falling_states, new) then
				hum:ChangeState(Enum.HumanoidStateType.Running)
			end
		end)
		local state_connection
		if hum then
			state_connection = hum.StateChanged:Connect(state_changed)
		end
		LocalPlayer.CharacterAdded:Connect(function(character)
			local humanoid = character:WaitForChild("Humanoid")
			if state_connection then state_connection:Disconnect() end
			state_connection = humanoid.StateChanged:Connect(state_changed)
		end)
	end
	do
		antibox:Toggle({Name = "Enabled", Value = false, Flag = "antiaim_enabled", Callback = function(bool)
			antiaim = bool
		end})

		antibox:Toggle({Name = "Pitch modifier", Value = false, Flag = "antiaim_pitch", Callback = function(bool)
			antiaim_pitch = bool
		end})
		antibox:Slider({Name = "Pitch value", Min = -1, Max = 1, Float = 0.05, Value = 0, Flag = "antiaim_pitch_value", Callback = function(int)
			antiaim_pitch_value = int
		end})

		antibox:Toggle({Name = "Yaw modifier", Value = false, Flag = "antiaim_yaw", Callback = function(bool)
			antiaim_yaw = bool
		end})
		antibox:Slider({Name = "Yaw value", Min = -180, Max = 180, Float = 5, Value = 0, Flag = "antiaim_yaw_value", Callback = function(int)
			antiaim_yaw_value = math.rad(int)
		end})

		antibox:Toggle({Name = "Yaw jitter", Value = false, Flag = "antiaim_jitter", Callback = function(bool)
			antiaim_jitter = bool
		end})
		antibox:Slider({Name = "Jitter strength", Min = 0, Max = 90, Float = 1, Value = 45, Flag = "antiaim_jitter_value", Callback = function(int)
			antiaim_jitter_value = math.rad(int)
		end})

		antibox:Toggle({Name = "Yaw spin", Value = false, Flag = "antiaim_spin", Callback = function(bool)
			antiaim_spin = bool
		end})
		antibox:Slider({Name = "Spin speed", Min = -10, Max = 10, Float = 0.1, Value = 0, Flag = "antiaim_spin_value", Callback = function(int)
			antiaim_spin_value = math.rad(int * 36)
		end})
		local updatetilt_remote = project_delta.updatetilt_remote
		local jitter_side, jitter_timer, spin_timer = false, 0, 0
		cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function(delta)
			local char = LocalPlayer.Character
			local hrp = char and _FindFirstChild(char, "HumanoidRootPart")
			local hum = char and _FindFirstChildOfClass(char, "Humanoid")

			if not (hrp and hum) then return end

			hum.AutoRotate = not antiaim
			if antiaim then
				local _, calc_yaw, _ = Camera.CFrame:ToOrientation()

				if antiaim_pitch then
					updatetilt_remote:FireServer(antiaim_pitch_value, 0)
				end
				if antiaim_yaw then
					calc_yaw += antiaim_yaw_value
				end
				if antiaim_jitter then
					jitter_timer += delta
					if jitter_side then
						calc_yaw += antiaim_jitter_value
					else
						calc_yaw -= antiaim_jitter_value
					end
					if jitter_timer > 1/32 then
						jitter_side = not jitter_side
						jitter_timer = jitter_timer % (1/32)
					end
				end
				if antiaim_spin then
					calc_yaw += ((tick() * antiaim_spin_value) % 1) * (math.pi * 2)
				end

				local hrp_x, _, hrp_z = hrp.CFrame:ToOrientation()
				hrp.CFrame = _CFramenew(hrp.Position) * CFrame.Angles(hrp_x, calc_yaw, hrp_z)
			end
		end))
	end
	do
		movebox:Toggle({Name = "Speedhack", Value = false, Flag = "speedhack", Callback = function(bool)
			speedhack = bool
		end})
		movebox:Toggle({Name = "Speedhack auto speed", Value = false, Flag = "speedhack_autospeed", Callback = function(bool)
			speedhack_autospeed = bool
		end})
		movebox:Slider({Name = "Speedhack speed", Min = 1, Max = 24, Float = 0.1, Value = 18.2, Flag = "speedhack_speed", Callback = function(int)
			speedhack_speed = int
		end})
		movebox:Slider({Name = "Auto speed offset", Min = -5, Max = 5, Float = 0.1, Value = 3.5, Flag = "speedhack_autospeed_offset", Callback = function(int)
			speedhack_autospeed_offset = int
		end})

		movebox:Toggle({Name = "Jumphack", Value = false, Flag = "jumphack", Callback = function(bool)
			jumphack = bool
		end})
		movebox:Slider({Name = "Jumphack height", Min = 1, Max = 10, Float = 0.1, Value = 5, Flag = "jumphack_height", Callback = function(int)
			jumphack_height = int
		end})

		local fh_keybind; fh_keybind = movebox:Toggle({Name = "Flyhack", Value = false, Flag = "flyhack", Callback = function(bool)
			flyhack = bool
		end}):Keybind({Name = "Flyhack", Mode = "Toggle", Key = Enum.KeyCode.X, Value = false, Flag = "flyhack_key", Callback = function(bool)
			flyhack_key = flyhack and bool
			fh_keybind.Set(flyhack_key, true)
		end})
		movebox:Slider({Name = "Flyhack speed", Min = 0, Max = 50, Float = 1, Value = 25, Flag = "flyhack_speed", Callback = function(int)
			flyhack_speed = int
		end})
		movebox:Slider({Name = "Flyhack speed Y", Min = 0, Max = 50, Float = 1, Value = 25, Flag = "flyhack_speed_y", Callback = function(int)
			flyhack_speed_y = int
		end})
	end

	cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function(delta)
		local char = LocalPlayer.Character
		local hrp = char and _FindFirstChild(char, "HumanoidRootPart")
		local hum = char and _FindFirstChildOfClass(char, "Humanoid")

		if not (hrp and hum) then return end

		local calcspeed = speedhack_autospeed and project_delta.calculate_speed(hrp) + speedhack_autospeed_offset or speedhack_speed
		if speedhack then
			hum.WalkSpeed = calcspeed
		end
		if jumphack then
			hum.JumpHeight = jumphack_height
		end

		local cameralook = (_Vector3new(1, 0, 1) * Camera.CFrame.LookVector).Unit
		local direction = _Vector3new(0, 0, 0)
		direction = _IsKeyDown(UserInputService, Enum.KeyCode.W) and direction + cameralook or direction;
		direction = _IsKeyDown(UserInputService, Enum.KeyCode.S) and direction - cameralook or direction;
		direction = _IsKeyDown(UserInputService, Enum.KeyCode.D) and direction + _Vector3new(-cameralook.Z, 0, cameralook.X) or direction;
		direction = _IsKeyDown(UserInputService, Enum.KeyCode.A) and direction + _Vector3new(cameralook.Z, 0, -cameralook.X) or direction;
		if direction ~= Vector3.zero then
			direction = direction.Unit
		end
		if flyhack and flyhack_key then
			local ydir = Vector3.zero
			ydir = _IsKeyDown(UserInputService, Enum.KeyCode.Space)	      and ydir + Vector3.yAxis or ydir;
			ydir = _IsKeyDown(UserInputService, Enum.KeyCode.LeftControl) and ydir - Vector3.yAxis or ydir;
			hrp.AssemblyLinearVelocity = _Vector3new(0, 0, 0)
			hrp.CFrame = hrp.CFrame + (_Vector3new(1, 0, 1) * direction * flyhack_speed * delta + flyhack_speed_y * ydir * delta)
		elseif speedhack then
			local hmm = direction * calcspeed
			hrp.AssemblyLinearVelocity = _Vector3new(hmm.X, hrp.AssemblyLinearVelocity.Y, hmm.Z)
		end
	end))
end

local character, hrp, head

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

		local des_keybind; des_keybind = expsec:Toggle({Name = "Freeze desync", Value = false, Flag = "desync_freeze", Callback = function(bool)
			desync_freeze = bool
			if not desync_freeze then
				toggle_desync(false)
			end
		end}):Keybind({Name = "Freeze desync", Mode = "Toggle", Key = Enum.KeyCode.M, Value = false, Flag = "desync_freeze_key", Callback = function(bool)
			if not desync_ready then
				des_keybind.Set(false, true)
				return Library.Notification("Freeze is not ready yet!", 2.5)
			end

			desync_freeze_key = desync_freeze and bool
			des_keybind.Set(desync_freeze_key, true)
			if desync_freeze_key then
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

		local rak_keybind; rak_keybind = expsec:Toggle({Name = "Raksync", Value = false, Flag = "desync_raksync", Callback = function(bool)
			raksync = bool
		end}):Keybind({Name = "Raksync", Mode = "Toggle", Key = Enum.KeyCode.M, Value = false, Flag = "desync_raksync_key", Callback = function(bool)
			raksync_key = raksync and bool
			rak_keybind.Set(raksync_key, true)
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

		local old_packet_timer

		if ({identifyexecutor()})[1] == "Synapse Z" then

		else
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

					local axx = buffer.create(4)
					buffer.writeu32(axx, 0, packet_timer)
					local packet_timer_hex = disect(axx)
					for i = 0, 3 do
						local n = tonumber(packet_timer_hex[i],16)
						buffer.writeu8(packetData, 8 - i --[[i + 5]], n)
					end
					local hextable, hex = disect(packetData)
				end
				return true
			end)
		end
	end

	getgenv().animbreaker_x = 0
	getgenv().animbreaker_y = 0
	getgenv().animbreaker_z = 0

	expsec:Slider({Name = "X animbreaker", Min = -10, Max = 10, Float = 0.1, Value = 0, Flag = "animbreaker_x_offset", Callback = function(int)
		getgenv().animbreaker_x = int
	end})
	expsec:Slider({Name = "Y animbreaker", Min = -1.4, Max = 1.4, Float = 0.1, Value = 0, Flag = "animbreaker_y_offset", Callback = function(int)
		getgenv().animbreaker_y = int
	end})
	expsec:Slider({Name = "Z animbreaker", Min = -10, Max = 10, Float = 0.1, Value = 0, Flag = "animbreaker_z_offset", Callback = function(int)
		getgenv().animbreaker_z = int * 100000
	end})
	
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
	

	local ds_keybind; ds_keybind = dscsec:Toggle({Name = "Enabled", Value = false, Flag = "desync_enabled", Callback = function(bool)
		desync_enabled = bool
	end}):Keybind({Name = "Desync", Mode = "Toggle", Key = Enum.KeyCode.B, Value = false, Flag = "desync_enabled_key", Callback = function(bool)
		desync_enabled_key = desync_enabled and bool
		ds_keybind.Set(desync_enabled_key, true)
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
		replicated_hrp_cframe = nil

		character = LocalPlayer.Character
		if not character then return end
		humanoid = _FindFirstChildOfClass(character, "Humanoid")
		hrp = _FindFirstChild(character, "HumanoidRootPart")
		head = _FindFirstChild(character, "Head")

		if not (humanoid and hrp) then return end
		if not (desync_enabled and desync_enabled_key) then return end

		old_cframe = hrp.CFrame
		old_velocity = hrp.AssemblyLinearVelocity

		local hrp_offset = _CFramenew()

		if not (forced_cframe) then
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
		end

		replicated_hrp_cframe = forced_cframe or old_cframe * hrp_offset

		hrp.CFrame = replicated_hrp_cframe
		
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

	local skeleton_order = {
		["LeftFoot"] = true,
		["LeftLowerLeg"] = true,
		["LeftUpperLeg"] = true,
		["RightFoot"] = true,
		["RightLowerLeg"] = true,
		["RightUpperLeg"] = true,
		["LeftHand"] = true,
		["LeftLowerArm"] = true,
		["LeftUpperArm"] = true,
		["RightHand"] = true,
		["RightLowerArm"] = true,
		["RightUpperArm"] = true,
		["LowerTorso"] = true,
		["UpperTorso"] = true
	}

	local valid_parts = {
		["LeftFoot"] = true,
		["LeftLowerLeg"] = true,
		["LeftUpperLeg"] = true,
		["RightFoot"] = true,
		["RightLowerLeg"] = true,
		["RightUpperLeg"] = true,
		["LeftHand"] = true,
		["LeftLowerArm"] = true,
		["LeftUpperArm"] = true,
		["RightHand"] = true,
		["RightLowerArm"] = true,
		["RightUpperArm"] = true,
		["LowerTorso"] = true,
		["UpperTorso"] = true,
		["Head"] = true
	}

	local function isBodyPart(name)
		return valid_parts[name]
	end

	cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function(delta)
		main_wireframe:Clear()

		if not (desync_visualize) then return end
		if not (desync_enabled and desync_enabled_key) then return end
		if not (replicated_hrp_cframe) then return end

		local character = LocalPlayer.Character
		if not (character) then return end

		local parts = table.create(15)
		local c = 0
		for _, v in character:GetChildren() do
			if _IsA(v, "BasePart") and isBodyPart(v.Name) then
				c += 1
				parts[c] = {v.CFrame, v.Size}
			end
		end
		if c == 0 then return end

		local points = table.create(24 * c)
		c = 0
		for _, part in parts do
			for _, vertex in VERTICES do
				c += 1
				points[c] = (replicated_hrp_cframe):PointToWorldSpace(
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
		miscbox:Toggle({Name = 'No grass', Flag = 'no_grass', Value = false, Callback = function(first)
			sethiddenproperty(workspace.Terrain, "Decoration", not first)
		end})
		do
			local atmosphere = _FindFirstChildOfClass(Lighting, "Atmosphere")
			if not atmosphere then
				atmosphere = Instance.new("Atmosphere")
				atmosphere.Parent = Lighting
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
				for theme, color in (Library.Theme) do
					ThemeColorpickers[theme] = Colors:Colorpicker({Name = Utility.ToTitleCase(theme), Flag = "settings_" .. theme, Usealpha = true, Ignore = true, Value = color, Callback = function(v)
						Library.UpdateTheme(theme, v.c)
					end})
				end
			end
		end
	end
end
do
	local TweenService = game:GetService("TweenService")
	local GuiService = game:GetService("GuiService")

	local bullet_infos = cheat.bullet_infos -- {}
		--[[
			table.create(4) -> {
				[1] = bulletid
				[2] = tick
				[3] = lv
				[4] = held?
			}
		]]

	local get_estimated_origin = project_delta.get_estimated_origin

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
			end
		end
		return __newindex(self, idx, val)
	end)))

	local __index; __index = hookmetamethod(game, '__index', newcclosure(LPH_NO_VIRTUALIZE(function(self, key)
		if checkcaller() then return __index(self, key) end
		if key == 'CFrame' and (self == hrp or self == head) and desync_enabled and desync_enabled_key and old_cframe then
			if self == hrp then
				return old_cframe
			end
			if self == head then
				return old_cframe * _CFramenew(
					0,
					hrp.Size.Y / 2 + head.Size.Y / 2,
					0
				) or _CFramenew()
			end
		end
		if key == "ReducedMotionEnabled" and no_recoil and self == GuiService then
			return true
		end
		return __index(self, key)
	end)))

	local __namecall; __namecall = hookmetamethod(game, "__namecall", newcclosure(LPH_NO_VIRTUALIZE(function(self, ...)
		local args = {...}
		local method = getnamecallmethod()
		
		if method == "Raycast" and aimbot_mode == "Silent" then
			local hitpart = target_part
			if not (hitpart and debugtraceback():find("Bullet")) then
				return __namecall(self, ...)
			end

			--print(":3", debugtraceback())

			local hitpos = hitpart.Position

			if silent_forcehit then
				return {
					Instance = hitpart,
					Position = hitpos,
					Distance = (hitpos - args[1]).Magnitude,
					Normal = _Vector3new(1, 0, 0),
					Material = hitpart.Material
				}
			end

			local origin = args[1]
			local direction = args[2]

			args[2] = (hitpos - origin)

			return __namecall(self, unpack(args))
		end
		if self == TweenService and method == "Create" and args[1] == Camera and (zoom and zoom_key or fov_changer) then
			args[3]["FieldOfView"] = nil
			return __namecall(self, unpack(args))
		end
		if method == "Play" and self.ClassName == "AnimationTrack" then
			local name = self.Name
			if name == "Equip" and instant_equip then
				__namecall(self, ...)
				self.TimePosition = self.Length
				return
			end
		end
		if method == "GetAttribute" then
			local attribute = args[1]
			if attribute == "AccuracyDeviation" then
				return 0
			end
		end
		if method == "InvokeServer" then
			local remote_name = self.Name
			if remote_name == "FireProjectile" and aimbot_mode == "Silent" then
				--args[3] = 0/0
				local r = table.create(3)
				r[1] = args[2]
				r[2] = args[3]
				r[3] = args[1]
				bullet_infos[args[2]] = r
				return __namecall(self, unpack(args))
			end
		end
		if method == "FireServer" then
			local remote_name = self.Name
			if remote_name == "ProjectileInflict" then
				if debugtraceback():find("CharacterController") then
					return coroutine.yield()
				end
				if aimbot_mode == "Silent" then
					args[4] = bullet_infos[args[3]][2] + 5
				end
				if hit_sound then
					task.defer(function()
						local sound = hit_sound_instance:Clone()
						sound.Volume = hit_sound_volume
						sound.PlaybackSpeed = hit_sound_speed
						sound.Parent = SoundService
						sound.PlayOnRemove = true
						sound:Destroy()
					end)
                end
				if hit_logs then
					local parent_model = args[1]
					repeat parent_model = parent_model.Parent until parent_model == nil or parent_model.ClassName == "Model"
					if parent_model then
						notification_queue[#notification_queue + 1] = {
							text = `Hit {Utility.RichText(parent_model.Name, Library.Theme.accent)} in the {Utility.RichText(args[1].Name, Library.Theme.accent)}`,
							duration = hit_logs_duration
						}
					end
				end
				
				return __namecall(self, unpack(args))
			end
			if remote_name == "UpdateTilt" and antiaim and antiaim_pitch then
				args[1] = antiaim_pitch_value
				args[2] = 0
				args[3] = nil
				args[4] = nil
				return __namecall(self, unpack(args))
			end
		end

		return __namecall(self, ...)
	end)))
end

cheat.EspLibrary.load()

if project_delta.fps_object then
	project_delta.fps_bindable:Fire()
end

task.spawn(function()
	--[[

		# Cross-Script Communication made for Project Delta by liam
		# This allows for script users to communicate with eachother despite the new roblox chat age verification restrictions, and without a chat filter.
		# This will be offered and given to every major script provider.
		# You are expected to keep the lua file and your api key private, your api key will be removed if it gets exposed.

		# To get started, replace "API_KEY" with your given api key. If you are obfuscating with luraph, make sure to keep the LPH_ENCSTR for the key to be encrypted during obfuscation.
		# If it successfully loaded, the loadstring with return a table with the function 'SetSendingEnabled'.
		# 'SetSendingEnabled' requires a boolean, this function is used to toggle whether the users messages get sent in the custom chat or not (if you want to put this on a toggle for example).
		# The chatbox input box will be automatically enabled if SendingEnabled is set to true.
		# Currently if SendingEnabled is true, messages wont be sent to normal players that have their chat verified, i will fix this in the future once i get accounts to test on.

		###### DISCLAIMER ######
		There is a *VERY* small possibility this could become detected in the future if solter somehow catches on and sees how this works. (same goes for any feature)
		Although that is extremely unlikely to happen, its recommended to warn users that this feature could possibly be risky (with a tooltip or something similar)
		Detection is not possible period if a user never sends a message with SendingEnabled set to true

	--]]

	cheat.CrossScriptChat = {SetSendingEnabled=function(...)end}
end)
