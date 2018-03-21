function moon.load()
	
	tween = require("libraries.third-party.tween")
	require("libraries.loveframes")
	require("libraries.demo")
	
	bgimage = moon.scene_graph.new_scene_node("resources/images/bg.png")
   
end

function moon.update(dt)

	loveframes.update(dt)
	tween.update(dt)
	
end

function moon.draw()
	
	local width = moon.graphics.get_width()
	local height = moon.graphics.get_height()
	local scalex = width/bgimage:get_width()
	local scaley = height/bgimage:get_height()
	
	moon.graphics.set_color(255, 255, 255, 255)
	moon.graphics.draw(bgimage, 0, 0, 0, scalex, scaley)
	loveframes.draw()
	
end

function moon.mousepressed(x, y, button)
	
	loveframes.mousepressed(x, y, button)
	
	local hoverobject = loveframes.hoverobject
	if hoverobject and hoverobject.menu_example and button == "r" then
		if hoverobject.menu then
			hoverobject.menu:Remove()
			hoverobject.menu = nil
		end
		createMenus(x, y)
	end
	
end

function moon.mousereleased(x, y, button)

	loveframes.mousereleased(x, y, button)

end

function moon.keypressed(key, unicode)
	
	loveframes.keypressed(key, unicode)
	
	if key == "f1" then
		local debug = loveframes.config["DEBUG"]
		loveframes.config["DEBUG"] = not debug
	elseif key == "f2" then
		loveframes.util.RemoveAll()
		demo.CreateToolbar()
		demo.CreateExamplesList()
	end
	
end

function moon.keyreleased(key)

	loveframes.keyreleased(key)
	
end

if moon._version == "0.9.0" then
	function moon.textinput(text)
		loveframes.textinput(text)
	end
end