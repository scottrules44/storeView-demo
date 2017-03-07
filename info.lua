local M = {}

function M:new()
	local group = display.newGroup()

	-- Create the background box
	local background = display.newRoundedRect(0, 0, display.actualContentWidth * 0.85, display.actualContentHeight * 0.65, 4)
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	background:setFillColor(0.76, 0.76, 0.76)
	group:insert(background)

	-- Create the info text
	local infoText = display.newText(
	{
		text = "",
		align = "center",
		fontSize = 12,
		width = background.contentWidth - 10,
	})
	infoText.anchorX = 0.5
	infoText.anchorY = 0
	infoText:setFillColor(1, 1, 1)
	group:insert(infoText)

	-- Populate the text from the readme file
	for line in io.lines(system.pathForFile("readme.txt")) do
		infoText.text = (infoText.text == "" and line) or infoText.text .. "\n" .. line
	end

	-- Position the text
	infoText.x = display.contentCenterX
	infoText.y = ((background.y) - (background.height * 0.5)) + 10

	-- Set the group properties
	group.xScale = 0.5
	group.yScale = 0.5
	group.alpha = 0
	group.isActive = false
	group.isTransitioning = false

	-- Show the popup
	function group:show()
		local function onShown()
			self.isActive = true
			self.isTransitioning = false
		end

		self.isTransitioning = true
		self:toFront()
		transition.to(self, {time = 800, xScale = 1, yScale = 1, alpha = 1, transition = easing.inOutElastic, onComplete = onShown})
	end

	-- Hide the popup
	function group:hide()
		local function onHidden()
			self.xScale = 0.5
			self.yScale = 0.5
			self.isActive = false
			self.isTransitioning = false
		end

		self.isTransitioning = true
		transition.to(self, {time = 1000, alpha = 0, transition = easing.inOutQuad, onComplete = onHidden})
	end

	return group
end

return M
