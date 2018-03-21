--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

-- debug library
loveframes.debug = {}

--[[---------------------------------------------------------
	- func: draw()
	- desc: draws debug information
--]]---------------------------------------------------------
function loveframes.debug.draw()
	
	-- do not draw anthing if debug is off
	local debug = loveframes.config["DEBUG"]
	if not debug then
		return
	end
	
	local infox = 5
	local infoy = 40
	local topcol = {type = "None", children = {}, x = 0, y = 0, width = 0, height = 0}
	local hoverobject = loveframes.hoverobject
	--local objects = loveframes.util.GetAllObjects()
	local version = loveframes.version
	local stage = loveframes.stage
	local basedir = loveframes.config["DIRECTORY"]
	local loveversion = moon._version
	local fps = moon.timer.getFPS()
	local deltatime = moon.timer.getDelta()
	local font = loveframes.basicfontsmall
	
	if hoverobject then
		topcol = hoverobject
	end
	
	-- show frame docking zones
	if topcol.type == "frame" then
		for k, v in pairs(topcol.dockzones) do
			moon.graphics.setLineWidth(1)
			moon.graphics.set_color(255, 0, 0, 100)
			moon.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
			moon.graphics.set_color(255, 0, 0, 255)
			moon.graphics.rectangle("line", v.x, v.y, v.width, v.height)
		end
	end
	
	-- outline the object that the mouse is hovering over
	moon.graphics.set_color(255, 204, 51, 255)
	moon.graphics.setLineWidth(2)
	moon.graphics.rectangle("line", topcol.x - 1, topcol.y - 1, topcol.width + 2, topcol.height + 2)
	
	-- draw main debug box
	moon.graphics.set_font(font)
	moon.graphics.set_color(0, 0, 0, 200)
	moon.graphics.rectangle("fill", infox, infoy, 200, 70)
	moon.graphics.set_color(255, 0, 0, 255)
	moon.graphics.print("Love Frames - Debug (" ..version.. " - " ..stage.. ")", infox + 5, infoy + 5)
	moon.graphics.set_color(255, 255, 255, 255)
	moon.graphics.print("LOVE Version: " ..loveversion, infox + 10, infoy + 20)
	moon.graphics.print("FPS: " ..fps, infox + 10, infoy + 30)
	moon.graphics.print("Delta Time: " ..deltatime, infox + 10, infoy + 40)
	moon.graphics.print("Total Objects: " ..loveframes.objectcount, infox + 10, infoy + 50)
	
	-- draw object information if needed
	if topcol.type ~= "base" then
		moon.graphics.set_color(0, 0, 0, 200)
		moon.graphics.rectangle("fill", infox, infoy + 75, 200, 100)
		moon.graphics.set_color(255, 0, 0, 255)
		moon.graphics.print("Object Information", infox + 5, infoy + 80)
		moon.graphics.set_color(255, 255, 255, 255)
		moon.graphics.print("Type: " ..topcol.type, infox + 10, infoy + 95)
		if topcol.children then
			moon.graphics.print("# of children: " .. #topcol.children, infox + 10, infoy + 105)
		else
			moon.graphics.print("# of children: 0", infox + 10, infoy + 105)
		end
		if topcol.internals then
			moon.graphics.print("# of internals: " .. #topcol.internals, infox + 10, infoy + 115)
		else
			moon.graphics.print("# of internals: 0", infox + 10, infoy + 115)
		end
		moon.graphics.print("X: " ..topcol.x, infox + 10, infoy + 125)
		moon.graphics.print("Y: " ..topcol.y, infox + 10, infoy + 135)
		moon.graphics.print("Width: " ..topcol.width, infox + 10, infoy + 145)
		moon.graphics.print("Height: " ..topcol.height, infox + 10, infoy + 155)
	end
	
end
