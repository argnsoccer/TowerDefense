local physics = require "physics"
physics.start()
local ui = require("ui")
local toRemove = {}
local rightBound = 410
local leftBound = display.contentWidth/6

--physics.setDrawMode("hybrid")


local bkg = display.newImage("grass.jpg", 0,0)

local path1 = display.newRect(display.contentWidth/2 - 30, 0, 60, 200)
path1:setFillColor(120,42,42)

local path2 = display.newRect(display.contentWidth/2 - 30, path1.contentHeight, 200, 60)
path2:setFillColor(120,42,42)

local path3 = display.newRect(path2.x + 40, path1.contentHeight + path2.contentHeight, 60, 125)
path3:setFillColor(120,42,42)

local path4 = display.newRect(display.contentWidth/6, 325, 270, 60)
path4:setFillColor(120,42,42)

local path5 = display.newRect(display.contentWidth/6, 325 + path4.contentHeight, 60, 125)
path5:setFillColor(120,42,42)

local path6 = display.newRect(path5.x + path5.width/2, path5.y + 2, 210 + path3.width, 60)
path6:setFillColor(120,42,42)

local path7 = display.newRect(path2.x + 40, display.contentCenterY + path6.height, 60, 125)
path7:setFillColor(120, 42, 42)

local path8 = display.newRect(display.contentWidth/6, 612, 270 + path7.width, 60)
path8:setFillColor(120, 42, 42)

local path9 = display.newRect(leftBound, path8.y + 30, 60, 70)
path9:setFillColor(120, 42, 42)

local path10 = display.newRect(leftBound, path9.y + 35, 191, 60)
path10:setFillColor(120, 42, 42)

local path11 = display.newRect(display.contentWidth/2 - 30, display.contentHeight - 52, 60, 52)
path11:setFillColor(120, 42, 42)

local RADIUS = 25
creep = display.newCircle(display.contentWidth/2, RADIUS, RADIUS)
creep:setFillColor(0, 0, 0, 0)
physics.addBody(creep, "kinematic", {radius = 25})

local money = 13500
local creeps = {}


local function randomCreep()
	
	creep = display.newCircle(display.contentWidth/2, RADIUS, RADIUS)
	creep:setFillColor(0,0,0)
	creep.xdir = 0
	creep.ydir = 1
	creep.xspeed = 5
	creep.yspeed = 5
	creep.xpos = creep.x
	creep.ypos = creep.y
	creep.name = "creep"
	physics.addBody(creep, "kinematic", {radius = 25} )
	creeps[#creeps + 1] = creep

end

timer.performWithDelay(3000, randomCreep, 20)
local bullets = {}
local n = 0



creep.xdir = 0
	creep.ydir = 1
	creep.xspeed = 5
	creep.yspeed = 5
	creep.xpos = creep.x
	creep.ypos = creep.y

local MoneyDisplay = ui.newLabel
{
	bounds = {display.contentWidth/8+38, display.screenOriginY + 10, 100, 24},
	text = "0",
	textColor = {255,225,102,255},
	size = 24,
	align = "left"
}

local moneytext = display.newText("money: ",display.contentWidth/8-50, display.screenOriginY + 10, native.systemFont, 24)
moneytext:setTextColor(255,225,102,255)



MoneyDisplay:setText(money)

local livesDisplay = ui.newLabel
{
	bounds = {display.contentWidth-120, display.screenOriginY + 10, 100, 24},
	text = "0",
	textColor = {255,225,102,255},
	size = 24,
	align = "right"
}

local livestext = display.newText("lives: ",display.contentWidth-160, display.screenOriginY + 10,native.systemFont, 24)
livestext:setTextColor(255,225,102,255)


local lives = 1000

livesDisplay:setText (lives)


local function animate(event)

	for i = 1, #creeps do
	if(creeps[i].y + RADIUS + 5 > path1.height + path2.height and creeps[i].y < path1.height + path2.height + 50) then
	creeps[i].xdir = 1
	creeps[i].ydir = 0
	end
	if(creeps[i].x + RADIUS + 7 > rightBound) then
	creeps[i].xdir = 0
	creeps[i].ydir = 1
	end
	if(creeps[i].y + RADIUS > display.contentCenterY -50) then
	creeps[i].xdir = -1
	creeps[i].ydir = 0
	end
	if(creeps[i].x - RADIUS < leftBound + 8) then
	creeps[i].xdir = 0
	creeps[i].ydir = 1
	end
	if(creeps[i].y + RADIUS > display.contentCenterY + 75 and creeps[i].y < path8.y) then
	creeps[i].xdir = 1
	creeps[i].ydir = 0
	end
	if(creeps[i].x + RADIUS + 7 > rightBound and creeps[i].y > display.contentCenterY) then
	creeps[i].xdir = 0
	creeps[i].ydir = 1
	end
	if(creeps[i].y + 8 > path9.y - 55) then
	creeps[i].xdir = -1
	creeps[i].ydir = 0
	end
	if(creeps[i].x < leftBound + 30)then
	creeps[i].xdir = 0
	creeps[i].ydir = 1
	end
	if(creeps[i].y + RADIUS > path11.y - 28) then
	creeps[i].xdir = 1
	creeps[i].ydir = 0
	end
	if(creeps[i].x > path11.x - 3 and creeps[i].y > 700) then
	creeps[i].xdir = 0
	creeps[i].ydir = 1
	end

        creeps[i].xpos = creeps[i].xpos + ( creeps[i].xspeed * creeps[i].xdir );
        creeps[i].ypos = creeps[i].ypos + ( creeps[i].yspeed * creeps[i].ydir);
        creeps[i]:translate( creeps[i].xpos - creeps[i].x, creeps[i].ypos - creeps[i].y)
	end
	
	local done = false
	if(done == false and creep.alpha == 0)then
	money = money + 1000
	MoneyDisplay:setText(money)
	done = true
	end
	
end


local function LivesCount(event)
	for i = 1, #creeps do
        	if(creeps[i].y - RADIUS > display.contentHeight and creeps[i].alpha > 0.011764705882353) then
			lives = lives - 1
			if(lives > 0)then
				livesDisplay:setText( lives)
			else
				livesDisplay:setText(0)
			end
		end
	end
end

--local function upgradeTower (event)
--	local t = event.target
--	local phase = event.phase
--	if "began" == phase then
--		tower = display.newImage("upgrade square.JPG", event.x - 70, event.y - 70)
--		tower:scale(0.37,0.37)
--		local fireRate = fireRate * 2
--	end
--
--	return true
--end



local towers = {}

local function addTower (event)
	if(money < 13500) then
		local nomoney = display.newText("NOT ENOUGH MONEY", 10, display.contentHeight/2, native.systemFont, 40)
		transition.to( nomoney, { alpha=0, time=500 } )
		return
	end
	if(event.phase == "began") then
		local inRange = false
		range = display.newCircle(event.x + 10, event.y+5, 100)
		range.alpha = .5
		range:setFillColor(255,0,0)
		--physics.addBody(range,"kinematic",{bounce=0})
	end
	if(event.phase == "ended" and money > 0) then
		tower = display.newImage("square.JPG", event.x - 70, event.y - 70)
		tower:scale(0.37,0.37)
		money = money - 13500
		MoneyDisplay:setText(money)
	end	

	towers[#towers + 1] = tower

	local function generateBullet()
		n = n + 1
		bullets[n] = display.newImage("fireball-fire-planet-mars21 copy.JPG", tower.x-120, tower.y-120)
		bullets[n]:scale(0.15,0.15)
	end
	local inRange = false
	
	--local function onCollision(event)
	--	if(event.phase == "began")then
	--		print("COLLISIOOOOOON")
	--		inRange = true
	--	elseif(event.phase == "ended")then
	--		inRange = false
	--		print("COLLISON ENDED")
	--	end		
	--end			

	local function shoot()
		timer.performWithDelay(100,generateBullet, 1)
		if(creep.x + (RADIUS*2) >= range.x or creep.x + (RADIUS*2) <= range.x) then
			if(creep.x <= range.x + (100*2) or creep.x >= range.x + (100*2)) then
				if(creep.y + (4*RADIUS) >= range.y) then
					if(creep.y <= range.y + (100)) then
						--if(inRange == true) then
							print("Sensing creep")
							transition.to(bullets[n], { x = creep.x, y = creep.y + RADIUS, onComplete = function(self) self:removeSelf(); if(creep.alpha > .24 ) then creep.alpha = creep.alpha - 0.25;self = nil;end; end})
						--end
					end
				end
			end
		end
	end
	timer.performWithDelay(550, shoot, 1000)

	--upgradeTower(event)
	--Runtime:addEventListener("touch", upgradeTower)
end

--Runtime:addEventListener("collision", onCollison);
Runtime:addEventListener("touch", addTower);
Runtime:addEventListener("enterFrame", animate);
Runtime:addEventListener("enterFrame", LivesCount);