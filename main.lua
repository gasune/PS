--: Remove Fog
local fog
local function noFog()
    game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128);
    game:GetService("Lighting").FogEnd = 100000;
    for _, v in next, game:GetService("Lighting"):GetDescendants() do
        if (v:IsA("Atmosphere")) then
            v:Destroy();
        end
    end
end

--: In-game Clock
local Time;
local function getTime()
    local totalMinutes = game:GetService("Lighting"):GetMinutesAfterMidnight();
    local Hours = math.floor(totalMinutes / 60);
    local Minutes = math.floor(totalMinutes % 60);
    local Period;

    if (Hours < 12) then
        Period = "AM";
    else
        Period = "PM";
        Hours -= 12;
    end

    if (Hours == 0) then
        Hours = 12;
    end

    return string.format("%02d:%02d %s", Hours, Minutes, Period);
end

local sGUI = Instance.new("ScreenGui");
sGUI.ResetOnSpawn = false;

pcall(function()
    if (gethui) then sGUI.Parent = gethui(); else sGUI.Parent = game:GetService("CoreGui"); end
end)

local timeLabel = Instance.new("TextLabel", sGUI);
timeLabel.AnchorPoint = Vector2.new(0.5, 0.5);
timeLabel.BackgroundTransparency = 1;
timeLabel.Position = UDim2.new(0.8, 0, 0.98, 0);
timeLabel.Size = UDim2.new(0,1, 0, 0.05, 0);
timeLabel.Font = Enum.Font.Nunito;
timeLabel.TextColor3 = Color3.fromRGB(250, 250, 250);

local function updateTime()
    task.spawn(function()
        timeLabel.Text = getTime();
    end)
end

Time = game:GetService("RunService").RenderStepped:Connect(updateTime);
fog = game:GetService("RunService").RenderStepped:Connect(noFog);
