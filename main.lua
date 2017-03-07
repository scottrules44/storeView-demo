-- Abstract: StoreView plugin
-- Version: 1.0
-- Sample code is MIT licensed; see https://www.coronalabs.com/links/code/license
---------------------------------------------------------------------------------------

-- Require the Widget library ( We use this for example buttons )
local widget = require("widget")
-- Require the Json library
local json = require("json")
-- Require the storeView Plugin
local storeView = require("plugin.storeView")
-- Require the info library
local info = require("info")

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Change apps every time
local changeApps = true

-- Create the info popup
local infoPopup = info:new()

-- Create the background
local background = display.newImageRect("bk.jpg", display.actualContentWidth, display.actualContentHeight)
background.x = display.contentCenterX
background.y = display.contentCenterY
background:addEventListener("touch", function() native.setKeyboardFocus(nil) end)

-- Create a background to go behind the event box
local background = display.newRoundedRect(0, 0, display.actualContentWidth - 40, 140, 4)
background.alpha = 0.8
background.x = display.contentCenterX
background.y = background.height

-- Create a native textbox to display events on screen
local eventBox = native.newTextBox(0, 0, background.contentWidth, background.contentHeight)
eventBox.x = display.contentCenterX
eventBox.y = eventBox.height
eventBox.isEditable = true
eventBox.hasBackground = false

-- StoreView listener
local function storeViewListener(event)
	-- Update the eventbox text
	eventBox.text = json.prettify(event)
	-- Print the event to the console
	print(json.prettify(event))
end

-- Init the storeView plugin
storeView.init(storeViewListener)

-- Create an info button
local infoButton = widget.newButton(
{
	id = "infoButton",
	defaultFile = "info.png",
	overFile = "infoOver.png",
	width = 50,
	height = 50,
	onRelease = function()
		if not infoPopup.isTransitioning then
			if not infoPopup.isActive then
				infoPopup:show()
			else
				infoPopup:hide()
			end
		end
	end,
})
infoButton.anchorX = 0
infoButton.anchorY = 1
infoButton.x = display.screenOriginX - 4
infoButton.y = display.screenOriginY + display.actualContentHeight + 6

-- Create the Infuse Dreams button
local infuseDreamsButton = display.newImageRect("IDLogo.png", 25, 35)
infuseDreamsButton.anchorX = 1
infuseDreamsButton.anchorY = 1
infuseDreamsButton.x = display.actualContentWidth - 6 - display.screenOriginX
infuseDreamsButton.y = display.screenOriginY + display.actualContentHeight - 4

-- Create a button
local button1 = widget.newButton(
{
	id = "button1",
	label = "Load Store Popup",
	shape = "roundedRect",
	emboss = false,
	width = 200,
	height = 40,
	cornerRadius = 2,
	labelColor =
	{
		default = {1, 1, 1, 1},
		over = {1, 1, 1, 0.6}
	},
	fillColor =
	{
		default = {0, 0.26, 1, 1},
		over = {0, 0.26, 1, 0.6}
	},
	onRelease = function(event)
		local grislyManor = "384282298"
		local angryBirds = "343200656"
		local appId = (changeApps and grislyManor) or angryBirds

		-- Toggle which app to display
		changeApps = not changeApps

		-- Load the storeView for the app
		storeView.load(appId)
	end,
	}
)
button1.x = display.contentCenterX
button1.y = eventBox.y + (eventBox.height) + 10

-- Create a button
local button2 = widget.newButton(
{
	id = "button2",
	label = "Show Store Popup",
	shape = "roundedRect",
	emboss = false,
	width = 200,
	height = 40,
	cornerRadius = 2,
	labelColor =
	{
		default = {1, 1, 1, 1},
		over = {1, 1, 1, 0.6}
	},
	fillColor =
	{
		default = {0, 0.26, 1, 1},
		over = {0, 0.26, 1, 0.6}
	},
	onRelease = function(event)
		if storeView.isLoaded() then
			-- Show the storeView for the loaded app
			storeView.show()
		else
			print("The storeView hasn't completed loading yet");
		end
	end,
})
button2.x = display.contentCenterX
button2.y = button1.y + button1.height + button2.height * .15
