Config = {}

Config.Categories = {
    {name = "SUV", vehicles = {
        {name = "Baller", brand = "Gallivanter", price = 240000, hp = 350, turbo = 300, traktion = 500, handling = 900, mods = {1, 2, 3, 4}},
        {name = "BJXL", brand = "Karin", price = 200000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = {1, 2, 3, 4}},
        {name = "VWtoua19cf", displayName = "Touareg 2019 R-Line", brand = "VW", price = 54000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = all},
        {name = "Cavalcade", brand = "Albany", price = 200000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = {1, 2, 3, 4}},
        {name = "Contender", brand = "Vapid", price = 200000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = {1, 2, 3, 4}},
        {name = "Dubsta", brand = "Benefactor", price = 200000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = {1, 2, 3, 4}},
        {name = "FQ2", brand = "Fathom", price = 200000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = {1, 2, 3, 4}},
        {name = "Granger", brand = "Declasse", price = 200000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = {1, 2, 3, 4}},
        {name = "Gresley", brand = "Bravado", price = 200000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = {1, 2, 3, 4}},
        {name = "Habanero", brand = "Emperor", price = 200000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = {1, 2, 3, 4}},
        {name = "Huntley", brand = "Enus", price = 200000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = {1, 2, 3, 4}},
        {name = "Landstalker", brand = "Dundreary", price = 200000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = {1, 2, 3, 4}},
        {name = "Mesa", brand = "Canis", price = 200000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = {1, 2, 3, 4}},
        {name = "Patriot", brand = "Mammoth", price = 200000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = {1, 2, 3, 4}},
    }},
    {name = "Supersport", vehicles = {
        {name = "Adder", brand = "Truffade", price = 240000, hp = 350, turbo = 300, traktion = 500, handling = 900, mods = {0, 1, 2, 3, 4}},
        {name = "Autarch", brand = "Överflöd", price = 200000, hp = 554, turbo = 500, traktion = 300, handling = 700, mods = {0, 1, 3, 7, 9, 15, 23}},
        {name = "Zentorno", brand = "Pegassi", price = 2400000, hp = 600, turbo = 550, traktion = 400, handling = 1000, mods = {0, 1, 3, 7, 9, 15, 23}},
        {name = "Prior", brand = "Tesla", price = 20000, hp = 900, turbo = 0, traktion = 800, handling = 750, mods = all},
        {name = "bolide", displayName = "Bolide", brand = "Bugatti", price = 20000, hp = 540, turbo = 300, traktion = 200, handling = 210, mods = all},
        {name = "benze55", displayName = "E55 AMG", brand = "Mercedes-Benz", price = 340000, hp = 540, turbo = 300, traktion = 200, handling = 210, mods = all},
        {name = "r820", displayName = "R8", brand = "Audi", price = 240000, hp = 350, turbo = 300, traktion = 500, handling = 900, mods = all},
        {name = "rs3lms", displayName = "RS3", brand = "Audi", price = 240000, hp = 350, turbo = 300, traktion = 500, handling = 900, mods = all},
        {name = "Bullet", brand = "Vapid", price = 2400000, hp = 230, turbo = 500, traktion = 600, handling = 500, mods = {0, 1, 2, 3, 4}}}
    }
}

-- in-memory spawnpoint array for this script execution instance
local spawnPoints = {}

-- auto-spawn enabled flag
local autoSpawnEnabled = false
local autoSpawnCallback

-- support for mapmanager maps
AddEventHandler('getMapDirectives', function(add)
    -- call the remote callback
    add('spawnpoint', function(state, model)
        -- return another callback to pass coordinates and so on (as such syntax would be [spawnpoint 'model' { options/coords }])
        return function(opts)
            local x, y, z, heading

            local s, e = pcall(function()
                -- is this a map or an array?
                if opts.x then
                    x = opts.x
                    y = opts.y
                    z = opts.z
                else
                    x = opts[1]
                    y = opts[2]
                    z = opts[3]
                end

                x = x + 0.0001
                y = y + 0.0001
                z = z + 0.0001

                -- get a heading and force it to a float, or just default to null
                heading = opts.heading and (opts.heading + 0.01) or 0

                -- add the spawnpoint
                addSpawnPoint({
                    x = x, y = y, z = z,
                    heading = heading,
                    model = model
                })

                -- recalculate the model for storage
                if not tonumber(model) then
                    model = GetHashKey(model, _r)
                end

                -- store the spawn data in the state so we can erase it later on
                state.add('xyz', { x, y, z })
                state.add('model', model)
            end)

            if not s then
                Citizen.Trace(e .. "\n")
            end
        end
        -- delete callback follows on the next line
    end, function(state, arg)
        -- loop through all spawn points to find one with our state
        for i, sp in ipairs(spawnPoints) do
            -- if it matches...
            if sp.x == state.xyz[1] and sp.y == state.xyz[2] and sp.z == state.xyz[3] and sp.model == state.model then
                -- remove it.
                table.remove(spawnPoints, i)
                return
            end
        end
    end)
end)


-- loads a set of spawn points from a JSON string
function loadSpawns(spawnString)
    -- decode the JSON string
    local data = json.decode(spawnString)

    -- do we have a 'spawns' field?
    if not data.spawns then
        error("no 'spawns' in JSON data")
    end

    -- loop through the spawns
    for i, spawn in ipairs(data.spawns) do
        -- and add it to the list (validating as we go)
        addSpawnPoint(spawn)
    end
end

local spawnNum = 1

function addSpawnPoint(spawn)
    -- validate the spawn (position)
    if not tonumber(spawn.x) or not tonumber(spawn.y) or not tonumber(spawn.z) then
        error("invalid spawn position")
    end

    -- heading
    if not tonumber(spawn.heading) then
        error("invalid spawn heading")
    end

    -- model (try integer first, if not, hash it)
    local model = spawn.model

    if not tonumber(spawn.model) then
        model = GetHashKey(spawn.model)
    end

    -- is the model actually a model?
    if not IsModelInCdimage(model) then
        error("invalid spawn model")
    end

    -- is is even a ped?
    -- not in V?
    --[[if not IsThisModelAPed(model) then
        error("this model ain't a ped!")
    end]]

    -- overwrite the model in case we hashed it
    spawn.model = model

    -- add an index
    spawn.idx = spawnNum
    spawnNum = spawnNum + 1

    -- all OK, add the spawn entry to the list
    table.insert(spawnPoints, spawn)

    return spawn.idx
end

-- removes a spawn point
function removeSpawnPoint(spawn)
    for i = 1, #spawnPoints do
        if spawnPoints[i].idx == spawn then
            table.remove(spawnPoints, i)
            return
        end
    end
end

-- changes the auto-spawn flag
function setAutoSpawn(enabled)
    autoSpawnEnabled = enabled
end

-- sets a callback to execute instead of 'native' spawning when trying to auto-spawn
function setAutoSpawnCallback(cb)
    autoSpawnCallback = cb
    autoSpawnEnabled = true
end

-- function as existing in original R* scripts
local function freezePlayer(id, freeze)
    local player = id
    SetPlayerControl(player, not freeze, false)

    local ped = GetPlayerPed(player)

    if not freeze then
        if not IsEntityVisible(ped) then
            SetEntityVisible(ped, true)
        end

        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end

        FreezeEntityPosition(ped, false)
        --SetCharNeverTargetted(ped, false)
        SetPlayerInvincible(player, false)
    else
        if IsEntityVisible(ped) then
            SetEntityVisible(ped, false)
        end

        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        --SetCharNeverTargetted(ped, true)
        SetPlayerInvincible(player, true)
        --RemovePtfxFromPed(ped)

        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end

function loadScene(x, y, z)
	if not NewLoadSceneStart then
		return
	end

    NewLoadSceneStart(x, y, z, 0.0, 0.0, 0.0, 20.0, 0)

    while IsNewLoadSceneActive() do
        networkTimer = GetNetworkTimer()

        NetworkUpdateLoadScene()
    end
end

-- to prevent trying to spawn multiple times
local spawnLock = false

-- spawns the current player at a certain spawn point index (or a random one, for that matter)
function spawnPlayer(spawnIdx, cb)

    local style = GetConvar("style"..GetPlayerName(PlayerId()), "Kein Style")
    local entry = GetConvar("entry"..GetPlayerName(PlayerId()), "Fehler bei der Einreise")
    local coords = GetConvar("coords"..GetPlayerName(PlayerId()), "Keine Koordinaten")
    coords = json.decode(coords)
    style = json.decode(style)

    if spawnLock then
        return
    end

    spawnLock = true

    Citizen.CreateThread(function()
        -- if the spawn isn't set, select a random one
        if not spawnIdx then
            spawnIdx = GetRandomIntInRange(1, #spawnPoints + 1)
        end

        -- get the spawn from the array
        local spawn

        if type(spawnIdx) == 'table' then
            spawn = spawnIdx

            -- prevent errors when passing spawn table
            spawn.x = spawn.x + 0.00
            spawn.y = spawn.y + 0.00
            spawn.z = spawn.z + 0.00

            spawn.heading = spawn.heading and (spawn.heading + 0.00) or 0
        else
            spawn = spawnPoints[spawnIdx]
        end

        if not spawn.skipFade then
            DoScreenFadeOut(500)

            while not IsScreenFadedOut() do
                Citizen.Wait(0)
            end
        end

        -- validate the index
        if not spawn then
            Citizen.Trace("tried to spawn at an invalid spawn index\n")

            spawnLock = false

            return
        end

        -- freeze the local player
        freezePlayer(PlayerId(), true)

        if tonumber(style) ~= 0 then
            if style["gender"] == "female" then
                spawn.model = "mp_f_freemode_01"
            end
        end

        -- if the spawn has a model set
        if spawn.model then
            RequestModel(spawn.model)

            -- load the model for this spawn
            while not HasModelLoaded(spawn.model) do
                RequestModel(spawn.model)

                Wait(0)
            end

            -- change the player model
            SetPlayerModel(PlayerId(), spawn.model)

            -- release the player model
            SetModelAsNoLongerNeeded(spawn.model)
            
            -- RDR3 player model bits
            if N_0x283978a15512b2fe then
				N_0x283978a15512b2fe(PlayerPedId(), true)
            end
        end

        -- preload collisions for the spawnpoint
        RequestCollisionAtCoord(spawn.x, spawn.y, spawn.z)

        -- spawn the player
        local ped = PlayerPedId()
        
        if tonumber(entry) == 0 then
            if tonumber(style) == 0 then
                SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false, true)
                NetworkResurrectLocalPlayer(spawn.x, spawn.y, spawn.z, spawn.heading, true, true, false)
                SetEntityRotation(ped, 0, -0, 175.9685)
                exports.duke_identity:start()
            else
                SetPedPreloadPropData(PlayerPedId(), 0, style["face"])
                SetPedPreloadPropData(PlayerPedId(), 2, style["hair"])
                SetPedPreloadPropData(PlayerPedId(), 3, style["arms"])
                SetPedPreloadPropData(PlayerPedId(), 4, style["leg"])
                SetPedPreloadPropData(PlayerPedId(), 6, style["shoe"])
                SetPedPreloadPropData(PlayerPedId(), 8, style["undershirt"])
                SetPedPreloadPropData(PlayerPedId(), 11, style["torso"])
    
                SetPedComponentVariation(PlayerPedId(), 0, style["face"])
                SetPedComponentVariation(PlayerPedId(), 2, style["hair"])
                SetPedComponentVariation(PlayerPedId(), 3, style["arms"])
                SetPedComponentVariation(PlayerPedId(), 4, style["leg"])
                SetPedComponentVariation(PlayerPedId(), 6, style["shoe"])
                SetPedComponentVariation(PlayerPedId(), 8, style["undershirt"])
                SetPedComponentVariation(PlayerPedId(), 2, style["hair"], style["hairColor"])
                SetPedComponentVariation(PlayerPedId(), 11, style["torso"])
                SetEntityCoordsNoOffset(PlayerPedId(), -1140.822, -2806.093, 27.70873, false, false, false, true)
                NetworkResurrectLocalPlayer(-1140.822, -2806.093, 27.70873, spawn.heading, true, true, false)
                SetEntityRotation(PlayerPedId(), 0, -0, -126.9268)
            end
        else
            if tonumber(style) == 0 then
                SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false, true)
                NetworkResurrectLocalPlayer(spawn.x, spawn.y, spawn.z, spawn.heading, true, true, false)
                SetEntityRotation(ped, 0, -0, 175.9685)
                exports.duke_identity:start()
            else
                SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
                NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, spawn.heading, true, true, false)

                SetPedPreloadPropData(PlayerPedId(), 0, style["face"])
                SetPedPreloadPropData(PlayerPedId(), 2, style["hair"])
                SetPedPreloadPropData(PlayerPedId(), 3, style["arms"])
                SetPedPreloadPropData(PlayerPedId(), 4, style["leg"])
                SetPedPreloadPropData(PlayerPedId(), 6, style["shoe"])
                SetPedPreloadPropData(PlayerPedId(), 8, style["undershirt"])
                SetPedPreloadPropData(PlayerPedId(), 11, style["torso"])
    
                SetPedComponentVariation(PlayerPedId(), 0, style["face"])
                SetPedComponentVariation(PlayerPedId(), 2, style["hair"])
                SetPedComponentVariation(PlayerPedId(), 3, style["arms"])
                SetPedComponentVariation(PlayerPedId(), 4, style["leg"])
                SetPedComponentVariation(PlayerPedId(), 6, style["shoe"])
                SetPedComponentVariation(PlayerPedId(), 8, style["undershirt"])
                SetPedComponentVariation(PlayerPedId(), 2, style["hair"], style["hairColor"])
                SetPedComponentVariation(PlayerPedId(), 11, style["torso"])
            end
        end

        Citizen.Wait(3000)

        -- V requires setting coords as well
        --SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false, true)

        --NetworkResurrectLocalPlayer(spawn.x, spawn.y, spawn.z, spawn.heading, true, true, false)

        -- gamelogic-style cleanup stuff
        ClearPedTasksImmediately(ped)
        --SetEntityHealth(ped, 300) -- TODO: allow configuration of this?
        RemoveAllPedWeapons(ped) -- TODO: make configurable (V behavior?)
        ClearPlayerWantedLevel(PlayerId())

        -- why is this even a flag?
        --SetCharWillFlyThroughWindscreen(ped, false)

        -- set primary camera heading
        --SetGameCamHeading(spawn.heading)
        --CamRestoreJumpcut(GetGameCam())

        -- load the scene; streaming expects us to do it
        --ForceLoadingScreen(true)
        --loadScene(spawn.x, spawn.y, spawn.z)
        --ForceLoadingScreen(false)

        local time = GetGameTimer()

        while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 5000) do
            Citizen.Wait(0)
        end

        for i = 1, #Config.Categories do
            for e = 1, #Config.Categories[i].vehicles do
                local ModelHash = GetHashKey(Config.Categories[i].vehicles[e].name)
                if not IsModelInCdimage(ModelHash) then return end
                RequestModel(ModelHash)
                while not HasModelLoaded(ModelHash) do
                    Citizen.Wait(10)
                end
                SetModelAsNoLongerNeeded(ModelHash)
                print("Loaded "..Config.Categories[i].vehicles[e].name)
            end
        end

        ShutdownLoadingScreen()

        if IsScreenFadedOut() then
            DoScreenFadeIn(500)

            while not IsScreenFadedIn() do
                Citizen.Wait(0)
            end
        end

        -- and unfreeze the player
        freezePlayer(PlayerId(), false)

        TriggerEvent('playerSpawned', spawn)

        if cb then
            cb(spawn)
        end

        spawnLock = false

        --if tonumber(entry) == 0 then
            --exports.duke_identity:openEntry(true)
        --end

    end)
end

-- automatic spawning monitor thread, too
local respawnForced
local diedAt

Citizen.CreateThread(function()
    -- main loop thing
    while true do
        Citizen.Wait(50)

        local playerPed = PlayerPedId()

        if playerPed and playerPed ~= -1 then
            -- check if we want to autospawn
            if autoSpawnEnabled then
                if NetworkIsPlayerActive(PlayerId()) then
                    if (diedAt and (math.abs(GetTimeDifference(GetGameTimer(), diedAt)) > 2000)) or respawnForced then
                        if autoSpawnCallback then
                            autoSpawnCallback()
                        else
                            spawnPlayer()
                        end

                        respawnForced = false
                    end
                end
            end

            if IsEntityDead(playerPed) then
                if not diedAt then
                    diedAt = GetGameTimer()
                end
            else
                diedAt = nil
            end
        end
    end
end)

function forceRespawn()
    spawnLock = false
    respawnForced = true
end

exports('spawnPlayer', spawnPlayer)
exports('addSpawnPoint', addSpawnPoint)
exports('removeSpawnPoint', removeSpawnPoint)
exports('loadSpawns', loadSpawns)
exports('setAutoSpawn', setAutoSpawn)
exports('setAutoSpawnCallback', setAutoSpawnCallback)
exports('forceRespawn', forceRespawn)
