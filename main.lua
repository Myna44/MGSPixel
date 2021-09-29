if pcall(require, "lldebugger") then require("lldebugger").start() end
if pcall(require, "mobdebug") then require("mobdebug").start() end

-- Taille Ecran
love.window.setMode(1440, 900)

-- Ecran
ScreenWidth = love.graphics.getWidth()
ScreenHeight = love.graphics.getHeight()

-- Images armes
imageSocom = love.graphics.newImage("ressources/images/armes/socom.png")
imageFamas = love.graphics.newImage("ressources/images/armes/famas.png")
imagePSG1 = love.graphics.newImage("ressources/images/armes/ps1.png")
imageNikita = love.graphics.newImage("ressources/images/armes/nikita.png")
imageStinger = love.graphics.newImage("ressources/images/armes/stinger.png")
imageChaff = love.graphics.newImage("ressources/images/armes/chaff.png")
imageStun = love.graphics.newImage("ressources/images/armes/stun.png")
imageFrag = love.graphics.newImage("ressources/images/armes/frag.png")
imageC4 = love.graphics.newImage("ressources/images/armes/c4.png")
imageClaymore = love.graphics.newImage("ressources/images/armes/claymore.png")

-- Images objets
imageRation = love.graphics.newImage("ressources/images/objets/ration.png")
imageJumelles = love.graphics.newImage("ressources/images/objets/jumelles.png")
imageCigarettes = love.graphics.newImage("ressources/images/objets/cigarettes.png")
imagePalKey = love.graphics.newImage("ressources/images/objets/key.png")
imageCard = love.graphics.newImage("ressources/images/objets/card.png")
imageBox1 = love.graphics.newImage("ressources/images/objets/box1.png")
imageBox2 = love.graphics.newImage("ressources/images/objets/box2.png")
imageBox3 = love.graphics.newImage("ressources/images/objets/box3.png")
imageFoulard = love.graphics.newImage("ressources/images/objets/foulard.png")
imageCorde = love.graphics.newImage("ressources/images/objets/corde.png")
imageKetchup = love.graphics.newImage("ressources/images/objets/ketchup.png")
imageMedic = love.graphics.newImage("ressources/images/objets/medic.png")
imageDiapzem = love.graphics.newImage("ressources/images/objets/diapzem.png")
imageCamera = love.graphics.newImage("ressources/images/objets/camera.png")
imageDisk = love.graphics.newImage("ressources/images/objets/disk.png")
imageMine = love.graphics.newImage("ressources/images/objets/mines.png")
imageNight = love.graphics.newImage("ressources/images/objets/night.png")
imageThermal = love.graphics.newImage("ressources/images/objets/thermal.png")
imageGaz = love.graphics.newImage("ressources/images/objets/gaz.png")
imageArmor = love.graphics.newImage("ressources/images/objets/armor.png")
imageStealth = love.graphics.newImage("ressources/images/objets/stealth.png")
imageBandana = love.graphics.newImage("ressources/images/objets/bandana.png")

-- Snake Up
imgSnakeUpFix = love.graphics.newImage("ressources/images/snake/snakeup.png")
imgSnakeUpA1 = love.graphics.newImage("ressources/images/snake/snakeupanim1.png")
imgSnakeUpA2 = love.graphics.newImage("ressources/images/snake/snakeupanim2.png")
imgSnakeUpA3 = love.graphics.newImage("ressources/images/snake/snakeupanim3.png")
imgSnakeUpA4 = love.graphics.newImage("ressources/images/snake/snakeupanim4.png")
imgSnakeUpA5 = love.graphics.newImage("ressources/images/snake/snakeupanim5.png")
imgSnakeUpA6 = love.graphics.newImage("ressources/images/snake/snakeupanim6.png")
imgSnakeUpA7 = love.graphics.newImage("ressources/images/snake/snakeupanim7.png")
imgSnakeUpA8 = love.graphics.newImage("ressources/images/snake/snakeupanim8.png")

-- Snake Down


-- Sound

-- SFX

-- Player --
Player = {}
Player.Vie = 0
Player.Image = imgSnakeUpFix;
Player.X = 0
Player.Y = 0
Player.Speed = 3
Player.Scale = 2.5
Player.TrigInventaire = nil

-- Animations
AnimUp = {imgSnakeUpA1, imgSnakeUpA2, imgSnakeUpA3,imgSnakeUpA4, imgSnakeUpA5, imgSnakeUpA6, imgSnakeUpA7, imgSnakeUpA8}

-- Tir --
Tirs = {}
n = 0

-- Objets --
ObjectInv = {}
ObjectInv.Id = 0
ObjectInv.Nom = ""
ObjectInv.Image = nil
ObjectInv.X = 0
ObjectInv.Y = 0
ObjectInv.Quantite = 0
LstObjects = {}
InvObjects = {}

-- Armes --
Armes = {}
Armes.Id = ""
Armes.Nom = ""
Armes.Image = nil
Armes.X = 0
Armes.Y = 0
Armes.Munition = 0
Armes.MaxMun = 21
InventaireArmes = {}

-- Variables d'état
BoolInvArmes = false
BoolInvObjects = false
CptArmes = 0
BoolEquipArme = false
BoolEquipObject = false
CptObjects = 0
ObjEquipe = ""
frame = 0
touche = ""
Codec = false
Screen = ""
cptAnim = 0

function CreateArmes(pID, pNom, pImage, pMunition, pMaxMun)

	local arme = {}
	arme.Id = pID
	arme.Nom = pNom
	arme.Image = pImage
	arme.Munition = pMunition
	arme.MaxMun = pMaxMun
	table.insert(InventaireArmes, arme)

end

function CreateObjects(pID, pNom, pImage, pX, pY, pQuantite)

	objet = {}
	objet.Id = pID
	objet.Nom = pNom
	objet.Image = pImage
	objet.X = pX
	objet.Y = pY
	objet.Quantite = pQuantite
	table.insert(LstObjects, objet)

end

function CreateTirs(pNomImage, pX, pY, pVitesseX, pVitesseY)

	local tir = {}
	tir.Image = pNomImage
	tir.X = pX
	tir.Y = pY
	tir.vx = pVitesseX
	tir.vy = pVitesseY
	table.insert(Tirs, tir)

end

function Collide(a1, a2)

	if (a1==a2) then return false end
 	local dx = a1.X - a2.X
 	local dy = a1.Y - a2.Y
 	if (math.abs(dx) < (50+30)/2) then
  		if (math.abs(dy) < (50+30)/2) then
   			return true
  		end
 	end
 	return false

end

function love.load()

	Player.Vie = 100
	Player.X = 50
	Player.Y = 600
	Player.TrigInventaire = false

	TailleInventaire = 9

	CptArmes = 1
	CptObjects = 1

	CreateObjects("MUNITION", "Munition", imageRation, 400, 320, 8)

	CreateArmes("SOCOM", "Socom", imageSocom, 21, 21)

end

function DecremantLife()

	frame = (frame + 1)
	if (frame % 100 == 0) then
		Player.Vie = Player.Vie - 1
	end

end

function MovePlayer()
	print(cptAnim)
	if love.keyboard.isDown('z') then
		Player.Y = Player.Y - Player.Speed
		for i=1, #AnimUp do
			cptAnim = cptAnim + 1
			Player.Image = AnimUp[cptAnim]
			if cptAnim > #AnimUp then
				cptAnim = 1
			end
		end
	else
		Player.Image = imgSnakeUpFix
	end

	if love.keyboard.isDown('s') then
		Player.Y = Player.Y + Player.Speed
	end

	if love.keyboard.isDown('q') then
		Player.X = Player.X - Player.Speed
	end

	if love.keyboard.isDown('d') then
		Player.X = Player.X + Player.Speed
	end
end

function Tir()

	CreateTirs("", Player.X, Player.Y - 50, 10, -10)

end

function love.update()

	if ObjEquipe == "CIGARETTE" then
		DecremantLife()
	end

	MovePlayer()

	if love.keyboard.isDown("rctrl") then
		if BoolEquipArme == false then
			BoolEquipArme = true
		end
		BoolInvArmes = true
	else
		BoolInvArmes = false
	end

	if love.keyboard.isDown("lctrl") then
		if BoolEquipObject == false then
			BoolEquipObject = true
		end
		BoolInvObjects = true
	else
		BoolInvObjects = false
	end

	for i=#LstObjects, 1, -1 do

		if (Collide(Player, LstObjects[i])) then
			if (LstObjects[i].Id == "MUNITION") then
				if LstObjects[i].Quantite > InventaireArmes[CptArmes].MaxMun - InventaireArmes[CptArmes].Munition then
					InventaireArmes[CptArmes].Munition = InventaireArmes[CptArmes].MaxMun
				else
					InventaireArmes[CptArmes].Munition = InventaireArmes[CptArmes].Munition + LstObjects[i].Quantite
				end
				table.remove(LstObjects, i)
			else
				table.insert(InvObjects, LstObjects[i])
				table.remove(LstObjects, i)
			end
		end

	end

	for j=1, #Tirs do

		Tirs[j].X = Tirs[j].X + Tirs[j].vx

	end

	for y=#Tirs, 1, -1 do
		if Tirs[y].X > ScreenWidth or Tirs[y].X < 0 or Tirs[y].Y > ScreenHeight or Tirs[y].Y < 0 then
			table.remove(Tirs, y)
		end
	end

end

function love.draw()

	-- Map

	-- Affichage stat Player
	love.graphics.print("Life "..Player.Vie, 125, 10)

	-- Objets de la zone
	for i=1, #LstObjects do
		if LstObjects[i].Nom == "Pomme" then
			love.graphics.setColor(0,1,0)
		elseif LstObjects[i].Nom == "Cerise" then
			love.graphics.setColor(1,0,0)
		elseif LstObjects[i].Nom == "MUNITION" then
			love.graphics.setColor(1,1,0)
		end

		love.graphics.rectangle("fill", LstObjects[i].X, LstObjects[i].Y, 30, 30)
		love.graphics.setColor(1,1,1)
	end

		-- Affichage Player
	love.graphics.draw(Player.Image, Player.X, Player.Y, 0, Player.Scale, Player.Scale)

	-- Tirs
	for j=1, #Tirs do
		love.graphics.circle("fill", Tirs[j].X, Tirs[j].Y, 10 ,10)
	end

	if BoolEquipObject then
		love.graphics.draw(InvObjects[CptObjects].Image, 0+80, ScreenHeight-90, 0, 3, 3)
		love.graphics.print(InvObjects[CptObjects].Quantite, 0+130, ScreenHeight-60)
		love.graphics.print(InvObjects[CptObjects].Nom, 0+80, ScreenHeight-60)
	end

	if BoolEquipArme then
		if InventaireArmes[CptArmes].Munition > 0 then
			love.graphics.draw(InventaireArmes[CptArmes].Image, ScreenWidth-130, ScreenHeight-90, 0, 3, 3)
			love.graphics.print(InventaireArmes[CptArmes].Munition.."/"..InventaireArmes[CptArmes].MaxMun, ScreenWidth-80, ScreenHeight-60)
			love.graphics.print(InventaireArmes[CptArmes].Nom, ScreenWidth-130, ScreenHeight-60)
		else
			love.graphics.print(InventaireArmes[CptArmes].Nom.. "  EMPTY", ScreenWidth-80, ScreenHeight-60)
		end
	end

end

function love.keypressed(key)

	if key == "space" then
		if InventaireArmes[CptArmes].Munition > 0 and BoolEquipArme then
			Tir()
			InventaireArmes[CptArmes].Munition = InventaireArmes[CptArmes].Munition - 1
		end

	end

	if BoolInvArmes then
		if key == "up" then
			if CptArmes > 1 then
				CptArmes = CptArmes - 1
			else
				CptArmes = #InventaireArmes
			end
		end
		if key == "down" then
			if CptArmes < #InventaireArmes then
				CptArmes = CptArmes + 1
			else
				CptArmes = 1
			end
		end
	end

	if BoolInvObjects then
		if key == "up" then
			if CptObjects > 1 then
				CptObjects = CptObjects - 1
			else
				CptObjects = #InvObjects
			end
		end
		if key == "down" then
			if CptObjects < #InvObjects then
				CptObjects = CptObjects + 1
			else
				CptObjects = 1
			end
		end
	end

	if key == "rshift" then
		if BoolEquipArme then
			BoolEquipArme = false
		else
			BoolEquipArme = true
		end
	end

	if key == "lshift" then
		if BoolEquipObject then
			BoolEquipObject = false
		else
			BoolEquipObject = true
		end
	end

	if key == "tab" then
		if Codec then
			Codec = false
			Screen = ""
		else
			Codec = true
			Screen = "CODEC"
		end
	end

end
