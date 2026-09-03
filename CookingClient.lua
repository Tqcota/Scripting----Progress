local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local OpenCooking = ReplicatedStorage:WaitForChild("OpenCooking")
local IngredientGiver = ReplicatedStorage:WaitForChild("IngredientGiver")

local CookingUI = script.Parent
local CookingFrame = CookingUI:WaitForChild("CookingFrame")
local Frame2 = CookingFrame:WaitForChild("Frame2")

local OffZone1 = Frame2:WaitForChild("LEFT")
local OffZone2 = Frame2:WaitForChild("RIGHT")
local Zone = Frame2:WaitForChild("ZONE")
local PointBar = Frame2:WaitForChild("PointBar")
local PointSpeed = 0.6
local PointBarLoc = PointBar.Position.X.Scale
local PointBarStartLoc = PointBar.Position.X.Scale
local ZoneStart = Zone.Position.X.Scale
local ZoneEnd = Zone.Position.X.Scale + Zone.Size.X.Scale

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local ProgressBar = Frame2:WaitForChild("Progress Bar")
local BarFill = ProgressBar:WaitForChild("Fill")
local CookingProgress = 0
local ProgressSpeed = 0.2
local ProgressDecaySpeed = 0.05

OpenCooking.OnClientEvent:Connect(function()
    CookingUI.Enabled = true
    CookingProgress = 0
    BarFill.Size = UDim2.new(
        CookingProgress,
        BarFill.Size.X.Offset,
        BarFill.Size.Y.Scale,
        BarFill.Size.Y.Offset
    )

    PointBarLoc = PointBarStartLoc

    PointBar.Position = UDim2.new(
        PointBarStartLoc,
        PointBar.Position.X.Offset,
        PointBar.Position.Y.Scale,
        PointBar.Position.Y.Offset
    )
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
end)

local HoldingSpace = false

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        HoldingSpace = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        HoldingSpace = false

        if not CookingUI.Enabled then
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        end
    end
end)

RunService.RenderStepped:Connect(function(dt)
    if HoldingSpace and CookingUI.Enabled then
        PointBarLoc = PointBarLoc + 0.6 * dt
    elseif CookingUI.Enabled then
        PointBarLoc = PointBarLoc - 0.6 * dt
    end
    PointBarLoc = math.clamp(PointBarLoc, 0.036, 0.948)

    PointBar.Position = UDim2.new(
        PointBarLoc,
        PointBar.Position.X.Offset,
        PointBar.Position.Y.Scale,
        PointBar.Position.Y.Offset
    )

    if PointBarLoc >= ZoneStart and PointBarLoc <= ZoneEnd then
        CookingProgress = CookingProgress + ProgressSpeed * dt
    elseif CookingUI.Enabled then
        CookingProgress = CookingProgress - ProgressDecaySpeed * dt
    end
    CookingProgress = math.clamp(CookingProgress, 0.000, 1)

    BarFill.Size = UDim2.new(
        CookingProgress,
        BarFill.Size.X.Offset,
        BarFill.Size.Y.Scale,
        BarFill.Size.Y.Offset
    )

    if CookingProgress >= 1 and CookingUI.Enabled then
        CookingUI.Enabled = false
        IngredientGiver:FireServer()

        if not HoldingSpace then
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        end
    end
end)
