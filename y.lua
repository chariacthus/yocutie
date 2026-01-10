--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to yocutie.com   (Alpha 0.10.9) ~  Much Love, yocutie

]]--

local Games = {{Name="idk",Description="idk script description.",Script="print('Executing idk...')"},{Name="im gay",Description="im gay script description.",Script="print('Executing im gay...')"},{Name="turkish gunig",Description="turkish gunig script description.",Script="print('Executing turkish gunig...')"}};
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local CoreGui = game:GetService("CoreGui");
local gui = Instance.new("ScreenGui");
if (syn and syn.protect_gui) then
	local FlatIdent_2584C = 0;
	while true do
		if (FlatIdent_2584C == 0) then
			syn.protect_gui(gui);
			gui.Parent = CoreGui;
			break;
		end
	end
elseif gethui then
	gui.Parent = gethui();
else
	gui.Parent = CoreGui;
end
gui.Name = tostring(math.random(1, 100000));
gui.IgnoreGuiInset = true;
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
local function MakeDraggable(frame)
	local FlatIdent_378D0 = 0;
	local dragging;
	local dragInput;
	local dragStart;
	local startPos;
	local update;
	while true do
		if (FlatIdent_378D0 == 1) then
			function update(input)
				local FlatIdent_12703 = 0;
				local delta;
				while true do
					if (FlatIdent_12703 == 0) then
						delta = input.Position - dragStart;
						game:GetService("TweenService"):Create(frame, TweenInfo.new(0.1), {Position=UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play();
						break;
					end
				end
			end
			frame.InputBegan:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseButton1) then
					local FlatIdent_2BD95 = 0;
					while true do
						if (FlatIdent_2BD95 == 1) then
							startPos = frame.Position;
							input.Changed:Connect(function()
								if (input.UserInputState == Enum.UserInputState.End) then
									dragging = false;
								end
							end);
							break;
						end
						if (FlatIdent_2BD95 == 0) then
							dragging = true;
							dragStart = input.Position;
							FlatIdent_2BD95 = 1;
						end
					end
				end
			end);
			FlatIdent_378D0 = 2;
		end
		if (FlatIdent_378D0 == 2) then
			frame.InputChanged:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseMovement) then
					dragInput = input;
				end
			end);
			UserInputService.InputChanged:Connect(function(input)
				if ((input == dragInput) and dragging) then
					update(input);
				end
			end);
			break;
		end
		if (FlatIdent_378D0 == 0) then
			dragging, dragInput, dragStart, startPos = nil;
			update = nil;
			FlatIdent_378D0 = 1;
		end
	end
end
local function t(o, i, g)
	local FlatIdent_60EA1 = 0;
	local x;
	while true do
		if (FlatIdent_60EA1 == 1) then
			return x;
		end
		if (FlatIdent_60EA1 == 0) then
			x = TweenService:Create(o, i, g);
			x:Play();
			FlatIdent_60EA1 = 1;
		end
	end
end
local main = Instance.new("Frame");
main.Size = UDim2.new(0, 0, 0, 0);
main.Position = UDim2.new(0.5, 0, 0.5, 0);
main.AnchorPoint = Vector2.new(0.5, 0.5);
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
main.BorderSizePixel = 0;
main.ClipsDescendants = true;
main.Parent = gui;
local uicorner = Instance.new("UICorner");
uicorner.CornerRadius = UDim.new(0, 6);
uicorner.Parent = main;
local uistroke = Instance.new("UIStroke");
uistroke.Color = Color3.fromRGB(35, 35, 35);
uistroke.Thickness = 1;
uistroke.Transparency = 1;
uistroke.Parent = main;
local title = Instance.new("TextLabel");
title.Size = UDim2.new(1, 0, 0, 30);
title.Position = UDim2.new(0, 0, 0.15, 0);
title.BackgroundTransparency = 1;
title.Text = "sync";
title.TextColor3 = Color3.fromRGB(255, 255, 255);
title.TextSize = 26;
title.Font = Enum.Font.GothamBold;
title.TextTransparency = 1;
title.Parent = main;
local sub = Instance.new("TextLabel");
sub.Size = UDim2.new(1, 0, 0, 20);
sub.Position = UDim2.new(0, 0, 0.35, 0);
sub.BackgroundTransparency = 1;
sub.Text = "initializing...";
sub.TextColor3 = Color3.fromRGB(100, 100, 100);
sub.TextSize = 13;
sub.Font = Enum.Font.Gotham;
sub.TextTransparency = 1;
sub.Parent = main;
local bar_bg = Instance.new("Frame");
bar_bg.Size = UDim2.new(0.7, 0, 0, 4);
bar_bg.Position = UDim2.new(0.15, 0, 0.7, 0);
bar_bg.BackgroundColor3 = Color3.fromRGB(25, 25, 25);
bar_bg.BorderSizePixel = 0;
bar_bg.BackgroundTransparency = 1;
bar_bg.Parent = main;
local bar_bg_c = Instance.new("UICorner");
bar_bg_c.CornerRadius = UDim.new(1, 0);
bar_bg_c.Parent = bar_bg;
local bar_fill = Instance.new("Frame");
bar_fill.Size = UDim2.new(0, 0, 1, 0);
bar_fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
bar_fill.BorderSizePixel = 0;
bar_fill.Parent = bar_bg;
local bar_fill_c = Instance.new("UICorner");
bar_fill_c.CornerRadius = UDim.new(1, 0);
bar_fill_c.Parent = bar_fill;
local key_box = Instance.new("TextBox");
key_box.Size = UDim2.new(0.8, 0, 0, 35);
key_box.Position = UDim2.new(0.1, 0, 0.35, 0);
key_box.BackgroundColor3 = Color3.fromRGB(18, 18, 18);
key_box.TextColor3 = Color3.fromRGB(255, 255, 255);
key_box.PlaceholderText = "Enter Key";
key_box.PlaceholderColor3 = Color3.fromRGB(60, 60, 60);
key_box.Font = Enum.Font.GothamMedium;
key_box.TextSize = 14;
key_box.Text = "";
key_box.BackgroundTransparency = 1;
key_box.TextTransparency = 1;
key_box.Parent = main;
local key_box_c = Instance.new("UICorner");
key_box_c.CornerRadius = UDim.new(0, 4);
key_box_c.Parent = key_box;
local key_box_s = Instance.new("UIStroke");
key_box_s.Color = Color3.fromRGB(40, 40, 40);
key_box_s.Thickness = 1;
key_box_s.Transparency = 1;
key_box_s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
key_box_s.Parent = key_box;
local btn = Instance.new("TextButton");
btn.Size = UDim2.new(0.8, 0, 0, 30);
btn.Position = UDim2.new(0.1, 0, 0.6, 0);
btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
btn.TextColor3 = Color3.fromRGB(0, 0, 0);
btn.Text = "Login";
btn.Font = Enum.Font.GothamBold;
btn.TextSize = 13;
btn.BackgroundTransparency = 1;
btn.TextTransparency = 1;
btn.AutoButtonColor = false;
btn.Parent = main;
local btn_c = Instance.new("UICorner");
btn_c.CornerRadius = UDim.new(0, 4);
btn_c.Parent = btn;
local discord_txt = Instance.new("TextLabel");
discord_txt.Size = UDim2.new(1, 0, 0, 20);
discord_txt.Position = UDim2.new(0, 0, 0.85, 0);
discord_txt.BackgroundTransparency = 1;
discord_txt.Text = "Get key in our discord server";
discord_txt.TextColor3 = Color3.fromRGB(100, 100, 100);
discord_txt.TextSize = 11;
discord_txt.Font = Enum.Font.Gotham;
discord_txt.TextTransparency = 1;
discord_txt.Parent = main;
local function LoadGameHub()
	local HubFrame = Instance.new("Frame");
	HubFrame.Name = "HubFrame";
	HubFrame.Size = UDim2.new(0, 600, 0, 350);
	HubFrame.Position = UDim2.new(0.5, 0, 0.5, 0);
	HubFrame.AnchorPoint = Vector2.new(0.5, 0.5);
	HubFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12);
	HubFrame.BorderSizePixel = 0;
	HubFrame.BackgroundTransparency = 1;
	HubFrame.Parent = gui;
	local HubCorner = Instance.new("UICorner");
	HubCorner.CornerRadius = UDim.new(0, 8);
	HubCorner.Parent = HubFrame;
	local HubStroke = Instance.new("UIStroke");
	HubStroke.Color = Color3.fromRGB(40, 40, 40);
	HubStroke.Thickness = 1;
	HubStroke.Parent = HubFrame;
	MakeDraggable(HubFrame);
	local Sidebar = Instance.new("Frame");
	Sidebar.Size = UDim2.new(0, 180, 1, 0);
	Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
	Sidebar.BorderSizePixel = 0;
	Sidebar.Parent = HubFrame;
	local SidebarCorner = Instance.new("UICorner");
	SidebarCorner.CornerRadius = UDim.new(0, 8);
	SidebarCorner.Parent = Sidebar;
	local SidebarHideCorner = Instance.new("Frame");
	SidebarHideCorner.Size = UDim2.new(0, 10, 1, 0);
	SidebarHideCorner.Position = UDim2.new(1, -10, 0, 0);
	SidebarHideCorner.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
	SidebarHideCorner.BorderSizePixel = 0;
	SidebarHideCorner.Parent = Sidebar;
	local HubTitle = Instance.new("TextLabel");
	HubTitle.Size = UDim2.new(1, -20, 0, 50);
	HubTitle.Position = UDim2.new(0, 20, 0, 2);
	HubTitle.BackgroundTransparency = 1;
	HubTitle.Text = "sync";
	HubTitle.TextColor3 = Color3.fromRGB(255, 255, 255);
	HubTitle.TextXAlignment = Enum.TextXAlignment.Left;
	HubTitle.Font = Enum.Font.GothamBold;
	HubTitle.TextSize = 24;
	HubTitle.Parent = Sidebar;
	local ScrollContainer = Instance.new("ScrollingFrame");
	ScrollContainer.Size = UDim2.new(1, 0, 1, -70);
	ScrollContainer.Position = UDim2.new(0, 0, 0, 60);
	ScrollContainer.BackgroundTransparency = 1;
	ScrollContainer.BorderSizePixel = 0;
	ScrollContainer.ScrollBarThickness = 2;
	ScrollContainer.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40);
	ScrollContainer.Parent = Sidebar;
	local ScrollLayout = Instance.new("UIListLayout");
	ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder;
	ScrollLayout.Padding = UDim.new(0, 4);
	ScrollLayout.Parent = ScrollContainer;
	local ScrollPadding = Instance.new("UIPadding");
	ScrollPadding.PaddingTop = UDim.new(0, 0);
	ScrollPadding.PaddingLeft = UDim.new(0, 10);
	ScrollPadding.PaddingRight = UDim.new(0, 10);
	ScrollPadding.Parent = ScrollContainer;
	local ContentArea = Instance.new("Frame");
	ContentArea.Size = UDim2.new(1, -180, 1, 0);
	ContentArea.Position = UDim2.new(0, 180, 0, 0);
	ContentArea.BackgroundTransparency = 1;
	ContentArea.Parent = HubFrame;
	local WelcomeText = Instance.new("TextLabel");
	WelcomeText.Size = UDim2.new(1, 0, 1, 0);
	WelcomeText.BackgroundTransparency = 1;
	WelcomeText.Text = "Select a module to inject.";
	WelcomeText.TextColor3 = Color3.fromRGB(60, 60, 60);
	WelcomeText.Font = Enum.Font.GothamBold;
	WelcomeText.TextSize = 16;
	WelcomeText.Parent = ContentArea;
	local GameTitle = Instance.new("TextLabel");
	GameTitle.Size = UDim2.new(1, -40, 0, 40);
	GameTitle.Position = UDim2.new(0, 20, 0, 20);
	GameTitle.BackgroundTransparency = 1;
	GameTitle.Text = "";
	GameTitle.TextColor3 = Color3.fromRGB(255, 255, 255);
	GameTitle.TextXAlignment = Enum.TextXAlignment.Left;
	GameTitle.Font = Enum.Font.GothamBlack;
	GameTitle.TextSize = 28;
	GameTitle.Visible = false;
	GameTitle.Parent = ContentArea;
	local GameDesc = Instance.new("TextLabel");
	GameDesc.Size = UDim2.new(1, -40, 0.6, 0);
	GameDesc.Position = UDim2.new(0, 20, 0, 65);
	GameDesc.BackgroundTransparency = 1;
	GameDesc.Text = "";
	GameDesc.TextColor3 = Color3.fromRGB(180, 180, 180);
	GameDesc.TextXAlignment = Enum.TextXAlignment.Left;
	GameDesc.TextYAlignment = Enum.TextYAlignment.Top;
	GameDesc.Font = Enum.Font.Gotham;
	GameDesc.TextSize = 14;
	GameDesc.TextWrapped = true;
	GameDesc.Visible = false;
	GameDesc.Parent = ContentArea;
	local LaunchBtn = Instance.new("TextButton");
	LaunchBtn.Size = UDim2.new(0, 140, 0, 40);
	LaunchBtn.Position = UDim2.new(1, -160, 1, -60);
	LaunchBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	LaunchBtn.Text = "LAUNCH";
	LaunchBtn.TextColor3 = Color3.fromRGB(0, 0, 0);
	LaunchBtn.Font = Enum.Font.GothamBold;
	LaunchBtn.TextSize = 14;
	LaunchBtn.AutoButtonColor = false;
	LaunchBtn.Visible = false;
	LaunchBtn.Parent = ContentArea;
	local LaunchCorner = Instance.new("UICorner");
	LaunchCorner.CornerRadius = UDim.new(0, 4);
	LaunchCorner.Parent = LaunchBtn;
	t(HubFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency=0});
	local SelectedScript = "";
	LaunchBtn.MouseButton1Click:Connect(function()
		if (SelectedScript ~= "") then
			local FlatIdent_703C8 = 0;
			while true do
				if (FlatIdent_703C8 == 3) then
					t(HubFrame, TweenInfo.new(0.3), {Size=UDim2.new(0, 0, 0, 0),BackgroundTransparency=1});
					wait(0.3);
					FlatIdent_703C8 = 4;
				end
				if (FlatIdent_703C8 == 2) then
					loadstring(SelectedScript)();
					wait(0.5);
					FlatIdent_703C8 = 3;
				end
				if (FlatIdent_703C8 == 4) then
					gui:Destroy();
					break;
				end
				if (FlatIdent_703C8 == 1) then
					LaunchBtn.Text = "LAUNCHING";
					t(LaunchBtn, TweenInfo.new(0.2), {BackgroundColor3=Color3.fromRGB(50, 255, 100)});
					FlatIdent_703C8 = 2;
				end
				if (FlatIdent_703C8 == 0) then
					t(LaunchBtn, TweenInfo.new(0.1), {BackgroundColor3=Color3.fromRGB(200, 200, 200)});
					wait(0.1);
					FlatIdent_703C8 = 1;
				end
			end
		end
	end);
	for _, gameData in pairs(Games) do
		local GameBtn = Instance.new("TextButton");
		GameBtn.Size = UDim2.new(1, 0, 0, 40);
		GameBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
		GameBtn.Text = "   " .. gameData.Name;
		GameBtn.TextColor3 = Color3.fromRGB(120, 120, 120);
		GameBtn.Font = Enum.Font.GothamMedium;
		GameBtn.TextSize = 13;
		GameBtn.TextXAlignment = Enum.TextXAlignment.Left;
		GameBtn.AutoButtonColor = false;
		GameBtn.Parent = ScrollContainer;
		local BtnCorner = Instance.new("UICorner");
		BtnCorner.CornerRadius = UDim.new(0, 6);
		BtnCorner.Parent = GameBtn;
		GameBtn.MouseEnter:Connect(function()
			if (GameBtn.BackgroundColor3 ~= Color3.fromRGB(25, 25, 25)) then
				t(GameBtn, TweenInfo.new(0.2), {BackgroundColor3=Color3.fromRGB(18, 18, 18),TextColor3=Color3.fromRGB(200, 200, 200)});
			end
		end);
		GameBtn.MouseLeave:Connect(function()
			if (GameBtn.BackgroundColor3 ~= Color3.fromRGB(25, 25, 25)) then
				t(GameBtn, TweenInfo.new(0.2), {BackgroundColor3=Color3.fromRGB(10, 10, 10),TextColor3=Color3.fromRGB(120, 120, 120)});
			end
		end);
		GameBtn.MouseButton1Click:Connect(function()
			local FlatIdent_E0D0 = 0;
			while true do
				if (FlatIdent_E0D0 == 5) then
					t(LaunchBtn, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency=0,TextTransparency=0});
					break;
				end
				if (FlatIdent_E0D0 == 0) then
					for _, c in pairs(ScrollContainer:GetChildren()) do
						if c:IsA("TextButton") then
							t(c, TweenInfo.new(0.2), {BackgroundColor3=Color3.fromRGB(10, 10, 10),TextColor3=Color3.fromRGB(120, 120, 120)});
						end
					end
					t(GameBtn, TweenInfo.new(0.2), {BackgroundColor3=Color3.fromRGB(25, 25, 25),TextColor3=Color3.fromRGB(255, 255, 255)});
					WelcomeText.Visible = false;
					FlatIdent_E0D0 = 1;
				end
				if (FlatIdent_E0D0 == 4) then
					LaunchBtn.TextTransparency = 1;
					t(GameTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency=0});
					t(GameDesc, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency=0});
					FlatIdent_E0D0 = 5;
				end
				if (FlatIdent_E0D0 == 3) then
					GameTitle.TextTransparency = 1;
					GameDesc.TextTransparency = 1;
					LaunchBtn.BackgroundTransparency = 1;
					FlatIdent_E0D0 = 4;
				end
				if (FlatIdent_E0D0 == 2) then
					GameTitle.Text = gameData.Name;
					GameDesc.Text = gameData.Description;
					SelectedScript = gameData.Script;
					FlatIdent_E0D0 = 3;
				end
				if (FlatIdent_E0D0 == 1) then
					GameTitle.Visible = true;
					GameDesc.Visible = true;
					LaunchBtn.Visible = true;
					FlatIdent_E0D0 = 2;
				end
			end
		end);
	end
end
task.spawn(function()
	wait(0.5);
	t(main, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size=UDim2.new(0, 320, 0, 160)});
	t(uistroke, TweenInfo.new(0.6), {Transparency=0.8});
	wait(0.3);
	t(title, TweenInfo.new(0.4), {TextTransparency=0});
	t(sub, TweenInfo.new(0.4), {TextTransparency=0});
	t(bar_bg, TweenInfo.new(0.4), {BackgroundTransparency=0});
	wait(0.1);
	t(bar_fill, TweenInfo.new(1.5, Enum.EasingStyle.Quint), {Size=UDim2.new(1, 0, 1, 0)});
	wait(1.6);
	t(sub, TweenInfo.new(0.3), {TextTransparency=1});
	t(bar_bg, TweenInfo.new(0.3), {BackgroundTransparency=1});
	t(bar_fill, TweenInfo.new(0.3), {BackgroundTransparency=1});
	wait(0.3);
	bar_bg.Visible = false;
	sub.Visible = false;
	t(key_box, TweenInfo.new(0.5), {BackgroundTransparency=0,TextTransparency=0});
	t(key_box_s, TweenInfo.new(0.5), {Transparency=0});
	t(btn, TweenInfo.new(0.5), {BackgroundTransparency=0,TextTransparency=0});
	t(discord_txt, TweenInfo.new(0.5), {TextTransparency=0});
	MakeDraggable(main);
	btn.MouseButton1Click:Connect(function()
		if (key_box.Text == "sync_user") then
			local FlatIdent_52551 = 0;
			local fadeInfo;
			while true do
				if (FlatIdent_52551 == 1) then
					t(main, fadeInfo, {BackgroundTransparency=1});
					t(uistroke, fadeInfo, {Transparency=1});
					t(title, fadeInfo, {TextTransparency=1});
					t(key_box, fadeInfo, {TextTransparency=1,BackgroundTransparency=1});
					FlatIdent_52551 = 2;
				end
				if (FlatIdent_52551 == 2) then
					t(key_box_s, fadeInfo, {Transparency=1});
					t(btn, fadeInfo, {TextTransparency=1,BackgroundTransparency=1});
					t(discord_txt, fadeInfo, {TextTransparency=1});
					wait(1);
					FlatIdent_52551 = 3;
				end
				if (FlatIdent_52551 == 0) then
					t(btn, TweenInfo.new(0.2), {BackgroundColor3=Color3.fromRGB(100, 255, 100)});
					btn.Text = "Success";
					wait(0.5);
					fadeInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
					FlatIdent_52551 = 1;
				end
				if (FlatIdent_52551 == 3) then
					main.Visible = false;
					LoadGameHub();
					break;
				end
			end
		else
			local FlatIdent_5346B = 0;
			local old;
			while true do
				if (FlatIdent_5346B == 0) then
					old = btn.BackgroundColor3;
					t(btn, TweenInfo.new(0.1), {BackgroundColor3=Color3.fromRGB(255, 50, 50)});
					FlatIdent_5346B = 1;
				end
				if (2 == FlatIdent_5346B) then
					t(btn, TweenInfo.new(0.3), {BackgroundColor3=old});
					btn.Text = "Login";
					break;
				end
				if (1 == FlatIdent_5346B) then
					btn.Text = "Invalid";
					wait(0.5);
					FlatIdent_5346B = 2;
				end
			end
		end
	end);
end);
