local composer = require("composer")

local scene = composer.newScene()

local physics = require( "physics" )
physics.start()

display.setStatusBar(display.HiddenStatusBar)
local estadodejogo = 0
local player
local obj1
local obj2
-- Scene event functions
-- -----------------------------------------------------------------------------------
function gotoMenu()
	composer.gotoScene("menu")
	end 

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    math.randomseed( os.time() )

-- backgrund
local posicaoFundoY = 500
local background = display.newImageRect( "background.png", 800,3500 )
background.x = display.contentCenterX
background.y = posicaoFundoY


-- declarando p player
player = display.newImageRect("carro1.png", 170,230)
player.x = display.contentCenterX
player.y = display.contentHeight-100
physics.addBody(player, "dynamic", {bounce=0})
player.gravityScale = 0
player.myName = "player"



local  function posicaoHorizontalPedra()

	local x = math.random(1,3)

	if x == 1 then
		return 384
	end

	if x == 2 then
	 	return 192
	end

	if x == 3 then
		return 576
	end

	end

--physics.setDrawMode("hybrid")

local function posicaoVerticalPedra()

	return  math.random(-2000,-10)


end

local pedra={}

 pedra[1]= display.newImageRect("pedra.png", 150,200)
 pedra[1].x = posicaoHorizontalPedra
 pedra[1].y = posicaoVerticalPedra
 pedra[1].myName = "pedra"
 physics.addBody(pedra[1], "static", {bounce=0,radius = 68})
        
 pedra[2]= display.newImageRect("pedra.png", 150,200)
 pedra[2].x = posicaoHorizontalPedra
 pedra[2].y = posicaoVerticalPedra
 pedra[2].myName = "pedra"      
 physics.addBody(pedra[2], "static", {bounce=0,radius = 68})  

 pedra[3]= display.newImageRect("pedra.png", 150,200)
 pedra[3].x = posicaoHorizontalPedra
 pedra[3].y = posicaoVerticalPedra
 pedra[3].myName = "pedra"
 physics.addBody(pedra[3], "static", {bounce=0,radius = 68})



local function analisandoVertical( y )
	-- body
	-- analisando se alguma pedra saiu da tela
	local j = 1
	for j=1, #pedra do 

		if y > pedra[j].y - 700 or y < pedra[j].y + 700  then
			return y + posicaoVerticalPedra()
		else
			return Y  
		end

	end
end 


 -- Botoes
local buttons = {}

buttons[1] = display.newImage("buttom.png")
buttons[1].x = 650
buttons[1].y = 1100
buttons[1].rotation = 360
buttons[1].myName = "left"

buttons[2] = display.newImage("buttom.png")
buttons[2].x = 130
buttons[2].y = 1100
buttons[2].rotation = 180
buttons[1].myName = "right"

        
-- Pedra random
 function replicacao(i)

	-- body
	pedra[i].x = posicaoHorizontalPedra()

	pedra[i].y = analisandoVertical(posicaoVerticalPedra())



end


local moveLeft = 0
local moveRight = 0

local touchFunction = function(e)
    
    if e.target.myName == "right" then     
        moveRight = 10
         player.x = player.x + moveRight
    else
        moveLeft = -10
        player.x = player.x + moveLeft
    end

    if e.phase == "began"  then
        if e.target.myName == "right" then
            moveRight = 10
             player.x = player.x + moveRight
        else
            moveLeft = -10
            player.x = player.x + moveLeft
        end
    elseif e.phase == "moved"  then
        if e.target.myName == "right" then     
            moveRight = 10
             player.x = player.x + moveRight
        else
            moveLeft = -10
            player.x = player.x + moveLeft
        end
    end
end

local gamerover = display.newImage("gamerover.png")
gamerover.alpha = 0


local ajuda = 0
local velo = 4 
local contador = 0

local score = display.newText(contador, 380, -80,native.font,100)



function reiniciar( ... )
    
    estadodejogo = 1

    player.x = display.contentCenterX
    player.y = display.contentHeight-100
    player.rotation = 0 


    pedra[1].x = posicaoHorizontalPedra
    pedra[1].y = posicaoVerticalPedra
            
    
    pedra[2].x = posicaoHorizontalPedra
    pedra[2].y = posicaoVerticalPedra
    
    pedra[3].x = posicaoHorizontalPedra
    pedra[3].y = posicaoVerticalPedra

    buttons[1].x = 650
    buttons[1].y = 1100
    buttons[1].rotation = 360

    buttons[2].x = 130
    buttons[2].y = 1100
    buttons[2].rotation = 180
    
    moveLeft = 0
    moveRight = 0

    
    ajuda = 0
    velo = 4 
    contador = 0

    score.text = "0"
    score.y = -18

    gamerover.alpha = 0

    



end


local j=1
for j=1, #buttons do
    buttons[j]:addEventListener("touch", touchFunction)
end


gamerover:addEventListener("tap", reiniciar)



function movimento()
    if estadodejogo == 1 then
        estadodejogo = 0
    end

    if estadodejogo == 0 then 
        ajuda = ajuda + velo
            
        if ajuda > 190 then
            contador = contador + 1
            velo = velo + 0.1
            score.text = contador
            ajuda = 0 
            if velo >= 35 then
            	velo = 35
            end
        end
        
        posicaoFundoY = posicaoFundoY + velo
        background.y = posicaoFundoY
        

        --movimentaçaodas pedras 
     
        pedra[1].y = pedra[1].y + velo 
        pedra[2].y = pedra[2].y + velo 
        pedra[3].y = pedra[3].y + velo 


        -- analisando se alguma pedra saiu da tela
        local j = 1
        for j=1, #pedra do 

        	if pedra[j].y > display.contentHeight + 300 then
        		replicacao(j)
        	end

        end

            if background.y > 1500 then
                posicaoFundoY = 500
            end
    end

    if estadodejogo == 66 then
        gamerover.alpha = 1
        gamerover.x = display.contentCenterX
        gamerover.y = display.contentCenterY

        score.y = display.contentCenterY + 130
    end 
end


--funcao
function onCollision( event)
    if estadodejogo == 0 then
        print("algo")
        estadodejogo = 66
    end 
 end
--



end
 

 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) and estadodejogo == 0 then

        -- Code here runs when the scene is entirely on screen
        timer.performWithDelay(1000, pedraRandom, -1)
        Runtime:addEventListener("enterFrame", movimento)

        Runtime:addEventListener( "collision", onCollision )
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
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