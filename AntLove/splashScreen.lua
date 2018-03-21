splashScreen = {}

--
function splashScreen.init()
	splashScreen.done = false

	-- Load image
	splashScreen.image = moon.scene_graph.new_scene_node("assets/SplashScreen.png")
	-- splashScreen.image:setFilter("nearest","nearest")

	-- Play music and loop it.
	-- music = moon.audio.newSource( "assets/Splash.ogg" , "stream" )
	-- music:setLooping(true)
	-- moon.audio.play(music)
end

--
function splashScreen.update(dt)
	-- nothing to do
end

--
function splashScreen.draw()
	moon.graphics.draw(splashScreen.image, 0, 0, 0, 2, 2, 0, 0, 0, 0)
end

--
function splashScreen.keypressed(key)
	-- Done
	splashScreen.done = true
	-- moon.audio.stop()
end
