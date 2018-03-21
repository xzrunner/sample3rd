require "splashScreen"
require "optionScreen"
require "game"
require "deathScreen"
require "utilities"
require "winScreen"

-- global image table
globalImages = {}

--
function moon.load()
	 
	-- Load images (global assets)
	img_fn =
	{
		"ant1","ant2","ant3","ant4","sod1","sod2","sod3","sod4","arrow","pit",
		"raid","spray","manRight1","manRight2","manLeft1","manLeft2",
		"man1","man2","man3","man4","man5","man6","man7","man8",
		"rock1","rock2","rock3","rock4","shoe",
    	"face1", "face2", "face3", "face4", "face5", "face6", "face7", "face8"
	}

	for _,v in ipairs(img_fn) do
		globalImages[v] = moon.scene_graph.new_scene_node("assets/"..v..".png")
		-- globalImages[v]:setFilter("nearest","nearest")
	end

	-- Initialize font, and set it.
	-- font = moon.graphics.newFont("assets/font.ttf", 8*scale)
	-- moon.graphics.setFont(font)

	-- define colors (global assets)
	bgcolor = {r=150,g=150,b=150}
	fontcolor = {r=46,g=115,b=46}

	-- initial state
	state = "splash"  

	splashScreen.init()
	-- winScreen.init()
end

--
function moon.draw()
	-- Set color
	moon.graphics.set_color(bgcolor.r,bgcolor.g,bgcolor.b)

	-- Draw rectangle for background
	local width = moon.graphics.get_width()
	local height = moon.graphics.get_height()
	moon.graphics.rectangle("fill", 0, 0, width, height)

	-- Return the color back to normal.
	moon.graphics.set_color(255,255,255)

	-- Call the state's draw function
	if state == "splash" then
		splashScreen.draw()
	elseif state == "option" then
		optionScreen.draw()
	elseif state == "game" then
		game.draw()
	elseif state == "dead" then
		deathScreen.draw()
	elseif state == "win" then
		winScreen.draw()
	end
end

--
function moon.update(dt)
	-- Call the state's update function
	if state == "splash" then
		splashScreen.update(dt)
	elseif state == "option" then
		optionScreen.update(dt)
	elseif state == "game" then
		game.update(dt)
	elseif state == "dead" then
		deathScreen.update(dt)
	elseif state == "win" then
		winScreen.update(dt)
	end

	if state == "splash" and splashScreen.done == true then
		optionScreen.init()
		state = "option"
	elseif state == "option" and optionScreen.done == true then
		game.init(optionScreen.difficulty)
		state = "game"
	elseif state == "game" then
		if game.mode == "dead" then
			deathScreen.init()
			state = "dead"
		elseif game.mode == "win" then
			winScreen.init()
			state = "win"
		end
	elseif state == "dead" and deathScreen.done == true then
		game.init()
		state = "game"
	end
end

--
function moon.keypressed(key)

	if key == "escape" then
		moon.event.quit()
	end

	-- Call the state's keypressed function
	if state == "splash" then
		splashScreen.keypressed(key)
	elseif state == "option" then
		optionScreen.keypressed(key)
	elseif state == "game" then
		game.keypressed(key)
	elseif state == "dead" then
		deathScreen.keypressed(key)
	end
end
