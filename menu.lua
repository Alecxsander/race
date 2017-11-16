


local composer = require("composer")

local scene = composer.newScene()

local function gotoGame()
	composer.gotoScene("game")
    audio.pause( backgroundMusicChannel )
	end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 


-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local background = display.newImageRect( sceneGroup, "backgroundmenu.jpg", 1000, 1400 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local title = display.newImageRect( sceneGroup, "logo.png", 800, 400 )
    title.x = display.contentCenterX
    title.y = display.contentHeight -900
    
    local carroMenu = display.newImageRect( sceneGroup, "carroMenu.jpg", 700, 300 )
    carroMenu.x = display.contentCenterX
    carroMenu.y = display.contentHeight -450
    
    local backgroundMusic = audio.loadStream( "somFundo.mp3" )
    audio.play( backgroundMusic )
    audio.rewind( backgroundMusic )

    local playButton =  display.newImageRect( sceneGroup, "PLAY.png", 600, 200 )
    playButton.x = display.contentCenterX
    playButton.y = display.contentHeight -150
    
 
    playButton:addEventListener("tap", gotoGame)

 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        display.remove(sceneGroup)
        
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene
