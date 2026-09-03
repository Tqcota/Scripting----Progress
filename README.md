# Scripting Progress

Some of the systems I've made while working with Luau in Roblox Studio.

---

## 🍳 Cooking System

A cooking minigame I made for one of my Roblox projects.

The player first collects the required ingredients, then starts the cooking minigame. During cooking, the player has to keep the moving bar inside the target area until the progress bar fills.

### Demo

[Watch the cooking system](cooking-system-demo.mp4)

### How it works

Holding **Space** moves the indicator in one direction and releasing it moves it back. Staying inside the target zone increases the cooking progress, while leaving it causes the progress to slowly decrease.

Once the bar reaches 100%, the client tells the server that cooking has finished. The server checks for the required ingredients, removes them, and gives the player the finished burger.

### Code

The system is split between multiple scripts. I've included two of the main scripts here to show how the minigame and server-side ingredient handling work.

- [CookingClient.lua](CookingClient.lua) — handles the minigame, input, UI and progress.
- [CookingServer.lua](CookingServer.lua) — handles ingredients and gives the finished item.

**Note:** There are additional scripts used by the full cooking system that aren't included in this repository.

### Some things used

`RemoteEvents` · `UserInputService` · `RunService` · `ServerStorage`

---

More scripting projects will be added as I make them.
