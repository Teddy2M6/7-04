-----------------------------------------------------------------------------------------
--
-- Created by: Aden Rao
-- Created on: April 16, 2019
--
-- This program lets you click a d-pad either right, left, up or down and lets you move the character and the game has physics involved so there is some gravity and it makes the characters movements more natural.
--
-----------------------------------------------------------------------------------------

-- Garvity for the program (physics)
local physics = require( "physics" )

physics.start()
physics.setGravity( 0, 25 )
-- physics.setDrawMode( "hybrid" ) 

-- Left wall
local leftWall = display.newRect( -40, display.contentHeight / 2, 1, display.contentHeight )
leftWall.alpha = 0.0
physics.addBody( leftWall, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )

-- local rightWall = display.newRect( 522, display.contentHeight, 1, display.contentHeight + 500)
-- rightWall.alpha = 0.0
-- physics.addBody( rightWall, "static", { 
--     friction = 0.5, 
--     bounce = 0.3 
--     } )


-- Hides status bar and ground image
--------------------------
display.setStatusBar(display.HiddenStatusBar)

local cloud = display.newImageRect( "assets/clouds.jpg", 750, 500 )
cloud.x = display.contentCenterX
cloud.y = display.contentCenterY
cloud.id = "cloud"

local theGround = display.newImageRect( "assets/land.png", 569, 100)
theGround.x = display.contentCenterX
theGround.y = display.contentHeight
theGround.id = "the ground"
physics.addBody( theGround, "static", { 
    friction = 0.5, 
    bounce = 0.7 
    } )
--------------------------

-- Dpad picture
local dPad = display.newImageRect( "./assets/d-pad.png", 100, 100 )
dPad.x = 50
dPad.y = display.contentHeight - 80
dPad.id = "d-pad"

-- Arrows
----------------------
local upArrow = display.newImageRect( "./assets/upArrow.png", 25, 15 )
upArrow.x = 50
upArrow.y = display.contentHeight - 116
upArrow.id = "up arrow"

local downArrow = display.newImageRect( "./assets/downArrow.png", 25, 15 )
downArrow.x = 50
downArrow.y = display.contentHeight - 44
downArrow.id = "down arrow"

local leftArrow = display.newImageRect( "./assets/leftArrow.png", 15, 25 )
leftArrow.x = 14
leftArrow.y = display.contentHeight - 80
leftArrow.id = "left arrow"

local rightArrow = display.newImageRect( "./assets/rightArrow.png", 15, 25 )
rightArrow.x = 86
rightArrow.y = display.contentHeight - 80
rightArrow.id = "right arrow"
-------------------------------

-- Jump button
local jumpButton = display.newImage( "assets/jumpButton.png" )
jumpButton.x = display.contentWidth - 80
jumpButton.y = display.contentHeight - 80
jumpButton.id = "jump button"
jumpButton.alpha = 0.5

-- Character sprite and physics for the character
local theCharacter = display.newImageRect( "./assets/enemy.png", 200, 200 )
theCharacter.x = display.contentCenterX
theCharacter.y = display.contentCenterY
theCharacter.id = "the character"
physics.addBody( theCharacter, "dynamic", { 
    density = 1.0, 
    friction = 0.5, 
    bounce = 0.3 
    } )
 
-- The functions for the making the arrows control the character and the jump button and for reseting the characters postition
----------------------------------
function upArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
        	x = 0, -- move 0 in the x direction 
        	y = -50, -- move up 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function downArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character down
        transition.moveBy( theCharacter, { 
        	x = 0, -- move 0 in the x direction 
        	y = 50, -- move down 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function leftArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character left
        transition.moveBy( theCharacter, { 
        	x = -50, -- move -50 in the x direction 
        	y = 0, 
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function rightArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character right
        transition.moveBy( theCharacter, { 
        	x = 50, -- move 50 in the x direction 
        	y = 0, 
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function jumpButton:touch( event )
    if ( event.phase == "ended" ) then
        -- make the character jump
        theCharacter:setLinearVelocity( -100, 0 )
    end

    return true
end

function checkCharacterPosition( event )
    -- check every frame to see if character has fallen of the land
    if theCharacter.y > display.contentHeight  then
        theCharacter.x = display.contentCenterX 
        theCharacter.y = display.contentCenterY + 50
    end
end
-----------------------------------------

-- Event listeners
upArrow:addEventListener( "touch", upArrow )
downArrow:addEventListener( "touch", downArrow )
leftArrow:addEventListener( "touch", leftArrow )
rightArrow:addEventListener( "touch", rightArrow )
jumpButton:addEventListener( "touch", jumpButton )
Runtime:addEventListener( "enterFrame", checkCharacterPosition )