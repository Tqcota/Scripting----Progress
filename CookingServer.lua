local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TakeIngredient = ReplicatedStorage:WaitForChild("TakeIngredient")
local Storage = game:GetService("ServerStorage")
local Food = Storage:WaitForChild("Food")
local RawBurger = Food:WaitForChild("RawBurger")
local Salad = Food:WaitForChild("Salad")
local Burger = Food:WaitForChild("Burger")
local IngredientGiver = ReplicatedStorage:WaitForChild("IngredientGiver")

local function FindItem(player, itemName)
	local Backpack = player.Backpack
	local Character = player.Character
	return Backpack:FindFirstChild(itemName) or Character:FindFirstChild(itemName)
end

TakeIngredient.OnServerEvent:Connect(function(player, ingredientName)
	print(player.Name, ingredientName)

	local Backpack = player.Backpack

	if ingredientName == "RawBurger" then
		print("Rawburger...")

		if not FindItem(player, "RawBurger") then
			RawBurger:Clone().Parent = Backpack
		end

	elseif ingredientName == "Salad" then
		print("Salad...")

		if not FindItem(player, "Salad") then
			Salad:Clone().Parent = Backpack
		end
	end
end)

IngredientGiver.OnServerEvent:Connect(function(player)
	local Backpack = player.Backpack

	local RawBurger = FindItem(player, "RawBurger")
	local Salad = FindItem(player, "Salad")

	if RawBurger and Salad then
		RawBurger:Destroy()
		Salad:Destroy()

		Burger:Clone().Parent = Backpack
		player:SetAttribute("HandsWashed", false)
	end
end)
