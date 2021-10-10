local function log(str)
	if VERBOSE then Package.Log("GameManager: " .. str) end
end

GameManager = {}

local State = {
	Waiting = 0,
	Pregame = 1,
	Playing = 2,
	Postgame = 3
}
GameManager.State = State

local state = State.Waiting
local timeoutHandle
local playerCount = 0

function GameManager.HandleJoin(player)
	playerCount = playerCount + 1
	if playerCount == 1 and state == State.Waiting then -- Begin starting the game when at least 2 people are joined
		GameManager.Prestart()
	end
end
function GameManager.HandleLeave(player)
	playerCount = playerCount - 1
end

function GameManager.Prestart()
	if state ~= State.Waiting then error("Tried to initiate prestart from the incorrect state") end
	log("Initialising game...")
	state = State.Pregame

	-- Assign players to teams based on hunter percent
	log("Assigning teams..")
	local numHuntersRequired = math.ceil(HUNTER_PERCENT * playerCount)
	local playersLeft = playerCount

	for _, player in pairs(Player.GetPairs()) do
		log("Assigning team to " .. tostring(player))
		if math.random() < numHuntersRequired / playersLeft then
			InitialiseHunter(player, Vector(), Rotator())
			numHuntersRequired = numHuntersRequired - 1

			log("Set " .. tostring(player) .. " to Hunter")
		else
			InitialiseProp(player, Vector(), Rotator())

			log("Set " .. tostring(player) .. " to Prop")
		end
		playersLeft = playersLeft - 1
	end

	Events.Call("GamePrestart")
	Events.BroadcastRemote("GamePrestart")

	timeoutHandle = Timer.SetTimeout(function()
		GameManager.Start()
	end, ROUND_WAIT_TIME * 1000)
end

function GameManager.Start()
	if state ~= State.Pregame then error("Tried to initiate playing from the incorrect state") end
	log("Starting game...")
	state = State.Playing

	Events.Call("GameStart")
	Events.BroadcastRemote("GameStart")

	timeoutHandle = Timer.SetTimeout(function()
		GameManager.End()
	end, ROUND_TIME * 60 * 1000)
end

function GameManager.End()
	if state ~= State.Playing then error("Tried to initiate postgame from the incorrect state") end
	log("Ending game...")

	Events.Call("GameEnd")
	Events.BroadcastRemote("GameEnd")

	timeoutHandle = nil
	state = State.Postgame
end
