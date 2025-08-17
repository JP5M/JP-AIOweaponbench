Config = {}

-- OT Skills Configuration
Config.useOTSkills = false -- requires our skills system, you can find here: https://forum.cfx.re/t/paid-ot-skills/4917372
Config.xpreward = 5

-- Repair Configuration
Config.requireditem = 'money'
Config.requireditemamount = 1000
Config.repairtime = 5000
Config.repairItem = 'weaponrepairkit'

-- Scratch Configuration
Config.requiredScratchitem = 'money'
Config.requiredscratchamount = 5000
Config.scratchItem = 'weaponscratchkit'
Config.scratchtime = 5000

-- Tampering Configuration
Config.requiredTamperingitem = 'money'
Config.requiredTamperingamount = 10000
Config.tamperingItem = 'weapontamperingkit'
Config.tamperingTime = 10000

-- Weapon Individual Configurations
Config.require = {
    ['WEAPON_COMBATPDW'] = {
        -- Repair Configuration
        requireditem = 'money',
        requireditemamount = 2000,
        repairtime = 10000,
        -- Scratch Configuration
        requiredScratchitem = 'money',
        requiredscratchamount = 5000,
        scratchtime = 25000,
        -- Tampering Configuration
        requiredTamperingitem = 'money',
        requiredTamperingamount = 10000,
        tamperingTime = 10000
    },
}

-- Bench Configuration
Config.locations = {
    {
        coords = vector3(-567.8292, -1696.3129, 19.0366),
        heading = 210.3678,
        spawnprop = true, -- spawns the workbench at the location 
        free = false, -- allows weapons to be repaired for free at the location
        repair = true, -- allows weapons to be repaired at the location
        freeScratching = false, -- allows weapons to be scratched for free at the location
        scratch = true, -- allows weapons to be scratched at the location
        freeTampering = false, -- allows weapons to be tampered for free at the location
        tampering = true, -- allows weapons to be tampered at the location
    }
}