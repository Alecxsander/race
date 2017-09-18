-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local physics = require( "physics" )
physics.start()

--physics.addBody( player, "dynamic", { radius=5, bounce=0 })

math.randomseed( os.time() )

-- backgrund
local posicaoFundoY = 500
local background = display.newImageRect( "background.png", 800,3500 )
background.x = display.contentCenterX
background.y = posicaoFundoY


-- declarando p player
local player = display.newImageRect("carro1.png", 170,230)
player.x = display.contentCenterX
player.y = display.contentHeight-100

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

local moveLeft = 0
local moveRight = 0

local touchFunction = function(e)
    print("entrou")
    
    if e.phase == "began"  then
        if e.target.myName == "right" then
            moveRight = 10
             player.x = player.x + moveRight
        else
            moveLeft = -10
            player.x = player.x + moveLeft
        end
    elseif e.phase == "moved"  then
        print("entrou mov")
        if e.target.myName == "right" then     
            moveRight = 10
             player.x = player.x + moveRight
        else
            moveLeft = -10
            player.x = player.x + moveLeft
        end
    end
end

local j=1
for j=1, #buttons do
    buttons[j]:addEventListener("touch", touchFunction)
end

local ajuda = 0
local velo = 3 
local contador = 0

local score = display.newText(contador, 380, -80,native.font,100)

local movimento = function()
    ajuda = ajuda + velo
    
    
    if ajuda > 190 then
        contador = contador + 1
        velo = velo + 0.1
        score.text = contador
        print(contador)
        ajuda = 0 
    end
    
    posicaoFundoY = posicaoFundoY + velo
    background.y = posicaoFundoY
    
    if background.y > 1500 then
        posicaoFundoY = 500
    end

    
    --player.x = player.x + moveLeft
    --player.y = player.y + moveRight
end



Runtime:addEventListener("enterFrame", movimento)

-- Pedra random

local function pedraRandom()

  local random = math.random(5)
    
    if(random == 1) then
        local pedra1 = display.newImageRect("pedra.png", 150,200)
        pedra1.x = display.contentCenterX
        pedra1.y = display.contentHeihgt0
        print("pedra1")
        
    elseif (random == 2) then
        local pedra2 = display.newImageRect("pedra.png", 150,200)
        pedra2.x = display.contentWidth100
        pedra2.y = display.contentHeihgt100
        print("pedra2")
    
    elseif(random == 3) then
        local pedra3 = display.newImageRect("pedra.png", 150,200)
        pedra3.x = display.contentWidth150
        pedra3.y = display.contentHeihgt100
        print("pedra3")
    
    elseif (random == 4) then
        local pedra4 = display.newImageRect("pedra.png", 150,200)
        pedra4.x = display.contentWidth200
        pedra4.y = display.contentHeihgt100
        print("pedra4")
    
    elseif (random == 5) then
        local pedra5 = display.newImageRect("pedra.png", 150,200)
        pedra5.x = display.contentWidth250
        pedra5.y = display.contentHeihgt100
        print("pedra5")
        
    end
end    

timer.performWithDelay(1000, pedraRandom, -1)