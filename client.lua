local props = {}

local function openRepairBench(i)
    local options = {}
    local repairOptions = {}
    local scratchOptions = {}
    local tamperingOptions = {}
    local location = Config.locations[i]
    local items = lib.callback.await('openRepairBench', false)
    if items then
        if location.repair then
            options[1] = {
                title = 'Repair Weapons',
                icon = 'fa-solid fa-wrench',
                menu = 'repairbench'
            }
        end
        if location.scratch then
            options[2] = {
                title = 'Scratch VINs',
                icon = 'fa-solid fa-xmark',
                menu = 'scratchvin'
            }
        end
        if location.tampering then
            options[3] = {
                title = 'Weapon tampering',
                icon = 'fa-solid fa-xmark',
                menu = 'weapontampering'
            }
        end

        for name, data in pairs(items) do
            for _, v in pairs(data) do
                if v.slot then
                    repairOptions[#repairOptions + 1] = { id = name .. v.slot, title = v.label, description = string.format('Durability: %s', v.metadata.durability .. '%'), serverEvent = 'OT_weaponrepair:startweaponrepair', args = { slot = v.slot, name = name, bench = i } }
                end
            end
        end

        for name, data in pairs(items) do
            for _, v in pairs(data) do
                if v.slot then
                    if v.metadata.serial == Config.scratchedText or not v.metadata.serial then

                    else
                        scratchOptions[#scratchOptions + 1] = { id = name .. v.slot, title = v.label, description = string.format('Serial: %s', v.metadata.serial), serverEvent = 'OT_weaponrepair:startweaponscratchjob', args = { slot = v.slot, name = name, bench = i } }
                    end
                end
            end
        end

        for name, data in pairs(items) do
            for _, v in pairs(data) do
                if v.slot then
                    if v.metadata.tampered or not v.metadata.serial then
                        -- Do not add tampered weapons to the tampering options
                    else
                       tamperingOptions[#tamperingOptions + 1] = { id = name .. v.slot, title = v.label, description = string.format('Serial: %s', v.metadata.serial), serverEvent = 'OT_weaponrepair:startweapontamperingjob', args = { slot = v.slot, name = name, bench = i } } -- Add only non-tampered weapons to the tampering options
                    end
                end
            end
        end

        lib.registerContext({ id = 'mainmenu', title = 'All in one weapon station', options = options })
        lib.registerContext({ id = 'repairbench', title = 'Repair weapons', options = repairOptions, menu = 'mainmenu' })
        lib.registerContext({ id = 'scratchvin', title = 'Scratch VINs', options = scratchOptions, menu = 'mainmenu' })
        lib.registerContext({ id = 'weapontampering', title = 'Weapon tampering', options = tamperingOptions, menu = 'mainmenu' })
        lib.showContext('mainmenu')
    end
end

RegisterNetEvent('OT_weaponrepair:repairitem', function(name)
    if lib.progressBar({
            duration = Config.require[name] and Config.require[name].repairtime or Config.repairtime,
            label = 'Repairing Weapon',
            useWhileDead = false,
            canCancel = false,
            anim = {
                dict = 'mini@repair',
                clip = 'fixing_a_ped'
            },
            disable = {
                move = true,
                car = true
            }
        }) then
        TriggerServerEvent('OT_weaponrepair:fixweapon')
    end
end)

RegisterNetEvent('OT_weaponrepair:scratchitem', function(name)
    if lib.progressBar({
            duration = Config.require[name] and Config.require[name].repairtime or Config.repairtime,
            label = 'Scratching Weapon',
            useWhileDead = false,
            canCancel = false,
            anim = {
                dict = 'mini@repair',
                clip = 'fixing_a_ped'
            },
            disable = {
                move = true,
                car = true
            }
        }) then
        TriggerServerEvent('OT_weaponrepair:scratchweapon')
    end
end)

RegisterNetEvent('OT_weaponrepair:tamperitem', function(name)
    if lib.progressBar({
            duration = Config.require[name] and Config.require[name].repairtime or Config.repairtime,
            label = 'Tampering with weapon',
            useWhileDead = false,
            canCancel = false,
            anim = {
                dict = 'mini@repair',
                clip = 'fixing_a_ped'
            },
            disable = {
                move = true,
                car = true
            }
        }) then
        TriggerServerEvent('OT_weaponrepair:tamperweapon')
    end
end)


local target = GetResourceState('ox_target') == 'started' and true or false
for i = 1, #Config.locations do
    local location = Config.locations[i]

    if location.spawnprop then
        local benchfar = lib.points.new(location.coords, 50,
            { coords = location.coords, heading = location.heading, index = i })

        function benchfar:onEnter()
            lib.requestModel(`gr_prop_gr_bench_02a`)
            props[self.index] = CreateObject(`gr_prop_gr_bench_02a`, self.coords.x, self.coords.y, self.coords.z, false,
                false, false)
            SetEntityHeading(props[self.index], self.heading)
            FreezeEntityPosition(props[self.index], true)
            if target then
                exports.ox_target:addLocalEntity(props[i], {
                    {
                        name = 'weaponrepair:openRepairBench',
                        icon = 'fa-solid fa-wrench',
                        label = 'Open Repair Bench',
                        canInteract = function(entity, distance, coords, name, bone)
                            return distance <= 2.0
                        end,
                        onSelect = function(entity, distance, coords, name, bone)
                            openRepairBench(i)
                        end
                    }
                })
            end
        end

        function benchfar:onExit()
            if DoesEntityExist(props[self.index]) then
                if target then
                    exports.ox_target:removeLocalEntity(props[self.index], { 'weaponrepair:openRepairBench' })
                end
                DeleteEntity(props[self.index])
            end
        end
    end

    if target then
        if not location.spawnprop then
            exports.ox_target:addBoxZone({
                coords = location.coords,
                size = vec3(2, 2, 2),
                rotation = location.heading,
                options = {
                    {
                        name = 'weaponrepair:openRepairBenchZone',
                        icon = 'fa-solid fa-wrench',
                        label = 'Open Weapon Bench',
                        canInteract = function(entity, distance, coords, name, bone)
                            return distance <= 3.0
                        end,
                        onSelect = function(entity, distance, coords, name, bone)
                            openRepairBench(i)
                        end
                    }
                }
            })
        end
    else
        local bench = lib.points.new(location.coords, 2, { index = i })

        function bench:onEnter()
            lib.showTextUI('[E] - Open Weapon Bench', { icon = 'wrench' })
        end

        function bench:onExit()
            lib.hideTextUI()
        end

        function bench:nearby()
            if IsControlJustReleased(0, 38) then
                openRepairBench(self.index)
            end
        end
    end
end

AddEventHandler('onResourceStop', function(name)
    if name ~= cache.resource then return end
    for _, v in pairs(props) do
        if DoesEntityExist(v) then
            if target then
                exports.ox_target:removeLocalEntity(v, { 'weaponrepair:openRepairBench' })
            end
            DeleteEntity(v)
        end
    end
end)


function GetCurrentWeaponItem()
    local playerPed = PlayerPedId()
    local weaponHash = GetSelectedPedWeapon(playerPed)
    local slot = lib.callback.await('jp_aio:getCurrentWeaponItem', false, weaponHash)
    if not slot then return nil end
    local item = slot
    if item and item.name and GetHashKey(item.name) == weaponHash then
        return item
    end
    return nil
end

CreateThread(function()
    while true do
        Wait(0)
        if IsPedArmed(PlayerPedId(), 6) and IsPedShooting(PlayerPedId()) then
            local item = GetCurrentWeaponItem()
            if not item then
                print('Player ID:', PlayerId(), 'Item does not exist')
                return
            end
            if item and item.metadata and item.metadata.tampered then
                local coords = GetEntityCoords(PlayerPedId())
                AddExplosion(coords.x, coords.y, coords.z, 0, 0, true, false, 1.0)
                SetEntityHealth(PlayerPedId(), (GetEntityHealth(PlayerPedId()) - Config.explosionDamage))
                TriggerServerEvent('jp_aio:removeWeaponItem', item.slot, item.name, item.metadata)
            end
        end
    end
end)