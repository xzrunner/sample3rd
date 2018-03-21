-- Death screen is a singleton
deathScreen = {}

function deathScreen.init()
	deathScreen.done = false

	-- Load image
	deathScreen.image = moon.scene_graph.new_scene_node("assets/DeathScreen.png")
	-- deathScreen.image:setFilter("nearest","nearest")

	-- Play music and loop it.
	-- print("death music")
	-- music = moon.audio.newSource( "assets/Death.ogg" , "stream" )
	-- music:setLooping(true)
	-- moon.audio.play(music)
end

--
function deathScreen.update(dt)
	-- nothing to do
end

--
function deathScreen.draw()
	moon.graphics.draw(deathScreen.image, 0, 0, 0, 2, 2, 0, 0, 0, 0)
end

--
function deathScreen.keypressed(key)
	-- Done
	deathScreen.done = true
	-- moon.audio.stop()
end
