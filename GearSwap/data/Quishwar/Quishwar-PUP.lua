----------------------------------------------------------------------------------------
--  __  __           _                     __   _____                        _
-- |  \/  |         | |                   / _| |  __ \                      | |
-- | \  / | __ _ ___| |_ ___ _ __    ___ | |_  | |__) |   _ _ __  _ __   ___| |_ ___
-- | |\/| |/ _` / __| __/ _ \ '__|  / _ \|  _| |  ___/ | | | '_ \| '_ \ / _ \ __/ __|
-- | |  | | (_| \__ \ ||  __/ |    | (_) | |   | |   | |_| | |_) | |_) |  __/ |_\__ \
-- |_|  |_|\__,_|___/\__\___|_|     \___/|_|   |_|    \__,_| .__/| .__/ \___|\__|___/
--                                                         | |   | |
--                                                         |_|   |_|
-----------------------------------------------------------------------------------------
--[[

    Originally Created By: Faloun
    Programmers: Arrchie, Kuroganashi, Byrne, Tuna
    Testers:Arrchie, Kuroganashi, Haxetc, Patb, Whirlin, Petsmart
    Contributors: Xilkk, Byrne, Blackhalo714

    ASCII Art Generator: http://www.network-science.de/ascii/
    
]]

-- Initialization function for this job file.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
end

function user_setup()
    -- Alt-F10 - Toggles Kiting Mode.

    --[[
        F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
        
        These are for when you are fighting with or without Pet
        When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    ]]
    state.OffenseMode:options("MasterPet", "Master")

    --[[
        Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
        
        Used when you are Engaged with Pet
        Used when you are Idle and Pet is Engaged
    ]]
    state.HybridMode:options("Normal", "Tank", "Acc", "TP", "Regen", "Ranged")

    --[[
        Alt-F12 - Turns off any emergency mode
        
        Ctrl-F10 - Cycle type of Physical Defense Mode in use.
        F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    ]]
    state.PhysicalDefenseMode:options("PetDT", "MasterDT")

    --[[
        Alt-F12 - Turns off any emergency mode

        F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    ]]
    state.MagicalDefenseMode:options("PetMDT")

    --[[ IDLE Mode Notes:

        F12 - Update currently equipped gear, and report current status.
        Ctrl-F12 - Cycle Idle Mode.
        
        Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    ]]
    state.IdleMode:options("Idle", "MasterDT")

    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    --The actual Pet Mode and Pet Style cycles
    --Default Mode is Tank
    state.PetModeCycle = M {"TANK", "DD", "MAGE"}
    --Default Pet Cycle is Tank
    state.PetStyleCycle = state.PetStyleCycleTank

    --Toggles
    --[[
        Alt + E will turn on or off Auto Maneuver
    ]]
    state.AutoMan = M(false, "Auto Maneuver")

    --[[
        //gs c toggle autodeploy
    ]]
    state.AutoDeploy = M(false, "Auto Deploy")

    --[[
        Alt + D will turn on or off Lock Pet DT
        (Note this will block all gearswapping when active)
    ]]
    state.LockPetDT = M(false, "Lock Pet DT")

    --[[
        Alt + (tilda) will turn on or off the Lock Weapon
    ]]
    state.LockWeapon = M(false, "Lock Weapon")

    --[[
        //gs c toggle setftp
    ]]
    state.SetFTP = M(false, "Set FTP")

   --[[
        This will hide the entire HUB
        //gs c hub all
    ]]
    state.textHideHUB = M(false, "Hide HUB")

    --[[
        This will hide the Mode on the HUB
        //gs c hub mode
    ]]
    state.textHideMode = M(false, "Hide Mode")

    --[[
        This will hide the State on the HUB
        //gs c hub state
    ]]
    state.textHideState = M(false, "Hide State")

    --[[
        This will hide the Options on the HUB
        //gs c hub options
    ]]
    state.textHideOptions = M(false, "Hide Options")

    --[[
        This will toggle the HUB lite mode
        //gs c hub lite
    ]]  
    state.useLightMode = M(false, "Toggles Lite mode")

    --[[
        This will toggle the default Keybinds set up for any changeable command on the window
        //gs c hub keybinds
    ]]
    state.Keybinds = M(false, "Hide Keybinds")

    --[[ 
        This will toggle the CP Mode 
        //gs c toggle CP 
    ]]
    state.CP = M(false, "CP")
    CP_CAPE = gear.Capacity_Cape

    --[[
        Enter the slots you would lock based on a custom set up.
        Can be used in situation like Salvage where you don't want
        certain pieces to change.

        //gs c toggle customgearlock
    ]]
    state.CustomGearLock = M(false, "Custom Gear Lock")
    --Example customGearLock = T{"head", "waist"}
    customGearLock = T{}

    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
    send_command("bind !e gs c toggle AutoMan")
    send_command("bind !d gs c toggle LockPetDT")
    send_command("bind !f6 gs c predict")
    send_command("bind ^` gs c toggle LockWeapon")
    send_command("bind home gs c toggle setftp")
    send_command("bind PAGEUP gs c toggle autodeploy")
    send_command("bind PAGEDOWN gs c hide keybinds")
    send_command("bind end gs c toggle CP")
    send_command("bind = gs c clear")

    select_default_macro_book()
    set_lockstyle()

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    pos_x = 2300
    pos_y = 200
    setupTextWindow(pos_x, pos_y)
    
end

function file_unload()
    send_command("unbind !f7")
    send_command("unbind ^f7")
    send_command("unbind !f8")
    send_command("unbind ^f8")
    send_command("unbind !e")
    send_command("unbind !d")
    send_command("unbind !f6")
    send_command("unbind ^`")
    send_command("unbind home")
    send_command("unbind PAGEUP")
    send_command("unbind PAGEDOWN")
    send_command("unbind end")
    send_command("unbind =")
end

function job_setup()
    include("PUP-LIB.lua")
    include('organizer-lib')
    lockstyleset = 1

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
end

function init_gear_sets()
    --Table of Contents
    ---Gear Variables
    ---Master Only Sets
    ---Hybrid Only Sets
    ---Pet Only Sets
    ---Misc Sets

    -------------------------------------------------------------------------
    --  _____                  __      __        _       _     _
    -- / ____|                 \ \    / /       (_)     | |   | |
    --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
    --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
    --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
    -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
    -------------------------------------------------------------------------
    --[[
        This section is best ultilized for defining gear that is used among multiple sets
        You can simply use or ignore the below
    ]]
    Animators = {"Animator P", "Animator P II", "Neo Animator"}
    Animators.Range = "Animator P II"
    Animators.Melee = "Animator P +1"
    Animators.WS = "Neo Animator"

    --Adjust to your reforge level
    --Sets up a Key, Value Pair
    Artifact_Foire = {}
    Artifact_Foire.Head_PRegen = "Foire Taj +1"
    Artifact_Foire.Body_WSD_PTank = "Foire Tobe +2"
    Artifact_Foire.Hands_Mane_Overload = "Foire Dastanas +2"
    Artifact_Foire.Legs_PCure = "Foire Churidars +1"
    Artifact_Foire.Feet_Repair_PMagic = "Foire Babouches +1"

    Relic_Pitre = {}
    Relic_Pitre.Head_PRegen = "Pitre Taj +1" --Enhances Optimization
    Relic_Pitre.Body_PTP = "Pitre Tobe +1" --Enhances Overdrive
    Relic_Pitre.Hands_WSD = "Pitre Dastanas +1" --Enhances Fine-Tuning
    Relic_Pitre.Legs_PMagic = "Pantin Churidars +2" --Enhances Ventriloquy
    Relic_Pitre.Feet_PMagic = "Pantin Babouches +1" --Role Reversal

    Empy_Karagoz = {}
    Empy_Karagoz.Head_PTPBonus = "Karagoz Capello +1"
    Empy_Karagoz.Body_Overload = "Karagoz Farsetto"
    Empy_Karagoz.Hands = "Karagoz Guanti"
    Empy_Karagoz.Legs_Combat = "Karagoz Pantaloni"
    Empy_Karagoz.Feet_Tatical = "Cirque Scarpe +1"

    Visucius = {}
    Visucius.PetDD = {
        name="Visucius's Mantle",
        augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20',
        'Pet: Accuracy+10 Pet: Rng. Acc.+10',
        'Pet: Haste+10'
        }
    }
    Visucius.PetRegen = {
        name="Visucius's Mantle",
        augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20',
        'Accuracy+10 Attack+10',
        'Pet: Attack+6 Pet: Rng.Atk.+6','Pet: "Regen"+10',
        'Pet: Magic dmg. taken-10%'
        }
    }
    Visucius.Master = {
        name="Visucius's Mantle",
        augments={'STR+20',
        'Accuracy+20 Attack+20',
        'STR+10',
        'Weapon skill damage +10%'
        }
    }

    --------------------------------------------------------------------------------
    --  __  __           _               ____        _          _____      _
    -- |  \/  |         | |             / __ \      | |        / ____|    | |
    -- | \  / | __ _ ___| |_ ___ _ __  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- | |\/| |/ _` / __| __/ _ \ '__| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | (_| \__ \ ||  __/ |    | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__,_|___/\__\___|_|     \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                                  __/ |
    --                                                 |___/
    ---------------------------------------------------------------------------------
    --This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
    sets.idle = {
        head=gear.Nyame_head,
        body=gear.Nyame_body,
        hands=gear.Nyame_hands,
        legs=gear.Nyame_legs,
        feet=gear.MovSpd_hermes_feet,
        neck=gear.DT_Twilight_Torque,
        waist="Isa Belt",
        left_ear="Genmei Earring",
        right_ear="Infused Earring",
        left_ring="Fortified Ring",
        right_ring=gear.DT_Defending_Ring,
        back="Contriver's Cape"
    }

    -------------------------------------Fastcast
    sets.precast.FC = {
       -- Add your set here 
    }

    -------------------------------------Midcast
    sets.midcast = {} --Can be left empty

    sets.midcast.FastRecast = {
       -- Add your set here 
    }

    -------------------------------------Kiting
    sets.Kiting = {feet = "Hermes' Sandals"}

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck = gear.Utsusemi_Neck, body = "Passion Jacket"})

    -- Precast sets to enhance JAs
    sets.precast.JA = {} -- Can be left empty

    sets.precast.JA["Tactical Switch"] = {feet = Empy_Karagoz.Feet_Tatical}

    sets.precast.JA["Ventriloquy"] = {legs = Relic_Pitre.Legs_PMagic}

    sets.precast.JA["Role Reversal"] = {feet = Relic_Pitre.Feet_PMagic}

    sets.precast.JA["Overdrive"] = {body = Relic_Pitre.Body_PTP}

    sets.precast.JA["Repair"] = {
        ammo = "Automat. Oil +3",
        feet = Artifact_Foire.Feet_Repair_PMagic
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {
        neck = "Buffoon's Collar",
        body = Empy_Karagoz.Body_Overload,
        hands = Artifact_Foire.Hands_Mane_Overload,
        ear1 = "Burana Earring",
        back = "Visucius's Mantle"
    }

    sets.precast.JA["Activate"] = {back = "Visucius's Mantle", feet=gear.Mpaca_feet}

    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {}

    --Waltz set (chr and vit)
    sets.precast.Waltz = {
       body = "Passion Jacket"
    }

    sets.precast.Waltz["Healing Waltz"] = {}

    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head=gear.Mpaca_head,
        body=Artifact_Foire.Body_WSD_PTank,
        hands=gear.Herc_WS_MAB_hands,
        legs=gear.Hizamaru_Ambuscade_legs,
        feet=gear.Mpaca_feet,
        neck="Shulmanu Collar",
        waist="Grunfeld Rope",
        left_ear="Ishvara Earring",
        right_ear="Cessance Earring",
        left_ring="Refescent Ring",
        right_ring="Niqmaddu Ring",
        back=Visucius.Master
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = set_combine(sets.precast.WS, {
        head=gear.Mpaca_head,
        body=gear.Mpaca_body,
        hands=gear.Mpaca_hands,
        legs=gear.Mpaca_legs,
        feet=gear.Mpaca_feet,
        neck="Shulmanu Collar",
        waist=gear.Elemental_belt,
        left_ear=gear.Moonshade_Earring,
        right_ear="Cessance Earring",
        left_ring="Refescent Ring",
        right_ring="Niqmaddu Ring"
    })

    sets.precast.WS["Stringing Pummel"].Mod = set_combine(sets.precast.WS["Stringing Pummel"], {})

    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
        head=gear.Mpaca_head,
        body=gear.Mpaca_body,
        hands=gear.Mpaca_hands,
        legs=gear.Mpaca_legs,
        feet=gear.Mpaca_feet,
        neck="Shulmanu Collar",
        left_ear=gear.Moonshade_Earring,
        right_ear="Cessance Earring",
        left_ring="Refescent Ring",
        right_ring="Niqmaddu Ring"
    })

    sets.precast.WS["Shijin Spiral"] = set_combine(sets.precast.WS,
    {
        head=gear.Mpaca_head,
        body=gear.Mpaca_body,
        hands=gear.Mpaca_hands,
        legs=gear.Mpaca_legs,
        feet=gear.Mpaca_feet,
        neck="Shulmanu Collar",
        waist=gear.Elemental_belt,
        left_ear=gear.Moonshade_Earring,
        right_ear="Cessance Earring",
        left_ring="Refescent Ring",
        right_ring="Niqmaddu Ring"
    })

    sets.precast.WS["Howling Fist"] = set_combine(sets.precast.WS, {
        head=gear.Mpaca_head,
        body=gear.Nyame_body,
        feet=gear.Nyame_feet
    })

    -------------------------------------Idle
    --[[
        Pet is not active
        Idle Mode = MasterDT
    ]]
    sets.idle.MasterDT = {
        head=gear.Nyame_head,
        body=gear.Nyame_body,
        hands=gear.Nyame_hands,
        legs=gear.Nyame_legs,
        feet=gear.Nyame_feet,
        neck=gear.DT_Twilight_Torque,
        waist="Isa Belt",
        left_ear="Genmei Earring",
        right_ear="Infused Earring",
        left_ring="Fortified Ring",
        right_ring=gear.DT_Defending_Ring,
        back="Contriver's Cape"
    }

    -------------------------------------Engaged
    --[[
        Offense Mode = Master
        Hybrid Mode = Normal
    ]]
    sets.engaged.Master = {
        head=gear.Mpaca_head,
        body=gear.Mpaca_body,
        hands=gear.Mpaca_hands,
        legs=gear.Mpaca_legs,
        feet=gear.Mpaca_feet,
        neck="Shulmanu Collar",
        waist="Klouskap Sash",
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        left_ring="Hetairoi Ring",
        right_ring="Niqmaddu Ring",
        back=Visucius.Master
    }

    -------------------------------------Acc
    --[[
        Offense Mode = Master
        Hybrid Mode = Acc
    ]]
    sets.engaged.Master.Acc = {
        head=gear.Malignance_head,
        body=gear.Mpaca_body,
        hands=gear.Mpaca_hands,
        legs=gear.Mpaca_legs,
        feet=gear.Mpaca_feet,
        neck="Shulmanu Collar",
        waist="Grunfeld Rope",
        left_ear="Telos Earring",
        right_ear="Digni. Earring",
        left_ring="Hizamaru Ring",
        right_ring="Tali'ah Ring",
        back=Visucius.Master
    }

    -------------------------------------TP
    --[[
        Offense Mode = Master
        Hybrid Mode = TP
    ]]
    sets.engaged.Master.TP = set_combine(sets.engaged.Master, {
        head=gear.Malignance_head
    })

    -------------------------------------DT
    --[[
        Offense Mode = Master
        Hybrid Mode = DT
    ]]
    sets.engaged.Master.DT = {
        head=gear.Nyame_head,
        body=gear.Nyame_body,
        hands=gear.Nyame_hands,
        legs=gear.Nyame_legs,
        feet=gear.Nyame_feet,
        neck=gear.DT_Twilight_Torque,
        waist="Isa Belt",
        left_ear="Telos Earring",
        right_ear="Digni. Earring",
        left_ring="Hizamaru Ring",
        right_ring="Tali'ah Ring",
        back="Contriver's Cape"
    }

    ----------------------------------------------------------------------------------
    --  __  __         _           ___     _     ___      _
    -- |  \/  |__ _ __| |_ ___ _ _| _ \___| |_  / __| ___| |_ ___
    -- | |\/| / _` (_-<  _/ -_) '_|  _/ -_)  _| \__ \/ -_)  _(_-<
    -- |_|  |_\__,_/__/\__\___|_| |_| \___|\__| |___/\___|\__/__/
    -----------------------------------------------------------------------------------

    --[[
        These sets are designed to be a hybrid of player and pet gear for when you are
        fighting along side your pet. Basically gear used here should benefit both the player
        and the pet.
    ]]
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Normal
    ]]
    sets.engaged.MasterPet = {
        head=gear.Malignance_head,
        body=gear.Mpaca_body,
        hands=gear.Heyoka_hands,
        legs=gear.Mpaca_legs,
        feet=gear.Taliah_Ambuscade_feet,
        neck="Shulmanu Collar",
        left_ring="Varar Ring",
        right_ring="Niqmaddu Ring",
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        back=Visucius.PetDD
    }

    -------------------------------------Acc
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Acc
    ]]
    sets.engaged.MasterPet.Acc = set_combine(sets.engaged.Master.Acc, {})

    -------------------------------------TP
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = TP
    ]]
    sets.engaged.MasterPet.TP = {
        head=gear.Malignance_head,
        body=gear.Mpaca_body,
        hands=gear.Heyoka_hands,
        legs=gear.Taliah_Ambuscade_legs,
        feet=gear.Mpaca_feet,
        neck="Shulmanu Collar",
        waist="Klouskap Sash",
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        left_ring="Raja's Ring",
        right_ring="Niqmaddu Ring",
        back=Visucius.PetDD
    }

    -------------------------------------DT
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = DT
    ]]
    sets.engaged.MasterPet.DT = set_combine(sets.engaged.Master.DT, {
        back=Visucius.PetRegen
       })

    -------------------------------------Regen
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Regen
    ]]
    sets.engaged.MasterPet.Regen = {
       -- Add your set here 
    }

    ----------------------------------------------------------------
    --  _____     _      ____        _          _____      _
    -- |  __ \   | |    / __ \      | |        / ____|    | |
    -- | |__) |__| |_  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- |  ___/ _ \ __| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  |  __/ |_  | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|   \___|\__|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                  __/ |
    --                                 |___/
    ----------------------------------------------------------------

    -------------------------------------Magic Midcast
    sets.midcast.Pet = {
        left_ear="Burana Earring",
        left_ring="Thurandaut Ring",
        right_ring="Niqmaddu Ring",
        back=Visucius.PetRegen
    }

    sets.midcast.Pet.Cure = {
        head={ name="Naga Somen", augments={'Pet: MP+80','Automaton: "Cure" potency +4%','Automaton: "Fast Cast"+3',}},
        body={ name="Naga Samue", augments={'Pet: MP+80','Automaton: "Cure" potency +4%','Automaton: "Fast Cast"+3',}},
        hands={ name="Naga Tekko", augments={'Pet: MP+75','Automaton: "Cure" potency +3%','Automaton: "Fast Cast"+2',}},
        legs=Artifact_Foire.Legs_PCure,
        feet={ name="Naga Kyahan", augments={'Pet: MP+50','Automaton: "Cure" potency +2%','Automaton: "Fast Cast"+1',}},
        back=Visucius.PetRegen
    }

    sets.midcast.Pet["Healing Magic"] = {
        head={ name="Naga Somen", augments={'Pet: MP+80','Automaton: "Cure" potency +4%','Automaton: "Fast Cast"+3',}},
        body={ name="Naga Samue", augments={'Pet: MP+80','Automaton: "Cure" potency +4%','Automaton: "Fast Cast"+3',}},
        hands={ name="Naga Tekko", augments={'Pet: MP+75','Automaton: "Cure" potency +3%','Automaton: "Fast Cast"+2',}},
        legs=Artifact_Foire.Legs_PCure,
        feet={ name="Naga Kyahan", augments={'Pet: MP+50','Automaton: "Cure" potency +2%','Automaton: "Fast Cast"+1',}},
        back=Visucius.PetRegen
    }

    sets.midcast.Pet["Elemental Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Enfeebling Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Dark Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Divine Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Enhancing Magic"] = {
       -- Add your set here 
    }

    -------------------------------------Idle
    --[[
        This set will become default Idle Set when the Pet is Active 
        and sets.idle will be ignored
        Player = Idle and not fighting
        Pet = Idle and not fighting

        Idle Mode = Idle
    ]]
    sets.idle.Pet = {
        head=gear.Mpaca_head,
        body=gear.Mpaca_body,
        hands=gear.Mpaca_hands,
        legs=gear.Mpaca_legs,
        feet=gear.MovSpd_hermes_feet,
        neck="Shulmanu Collar",
        waist="Klouskap Sash",
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        left_ring="Hetairoi Ring",
        right_ring="Niqmaddu Ring",
        back="Contriver's Cape"
    }

    --[[
        If pet is active and you are idle and pet is idle
        Player = idle and not fighting
        Pet = idle and not fighting

        Idle Mode = MasterDT
    ]]
    sets.idle.Pet.MasterDT = set_combine(sets.idle.Pet, {})
    -------------------------------------Enmity
    sets.pet = {} -- Not Used

    --Equipped automatically
    sets.pet.Enmity = {
        head=gear.Heyoka_head,
        body=gear.Heyoka_body,
        hands=gear.Heyoka_hands,
        legs=gear.Heyoka_legs,
        feet=gear.Taliah_Ambuscade_feet,
        left_ear="Rimeice Earring"
    }

    --[[
        Activated by Alt+D or
        F10 if Physical Defense Mode = PetDT
    ]]
    sets.pet.EmergencyDT = {
       -- Add your set here 
    }

    -------------------------------------Engaged for Pet Only
    --[[
      For Technical Users - This is layout of below
      sets.idle[idleScope][state.IdleMode][ Pet[Engaged] ][CustomIdleGroups] 

      For Non-Technical Users:
      If you the player is not fighting and your pet is fighting the first set that will activate is sets.idle.Pet.Engaged
      You can further adjust this by changing the HyrbidMode using Ctrl+F9 to activate the Acc/TP/DT/Regen/Ranged sets
    ]]
    --[[
        Idle Mode = Idle
        Hybrid Mode = Normal
    ]]
    sets.idle.Pet.Engaged = {
        head=gear.Mpaca_head,
        body=gear.Mpaca_body,
        hands=gear.Mpaca_hands,
        legs=gear.Mpaca_legs,
        feet=gear.Mpaca_feet,
        neck="Shulmanu Collar",
        waist="Klouskap Sash",
        left_ear="Burana Earring",
        right_ear="Handler's Earring +1",
        left_ring="Thurandaut Ring",
        right_ring="Varar Ring",
        back=Visucius.PetDD
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Tank
    ]]
    sets.idle.Pet.Engaged.Tank = {
         head=Artifact_Foire.Head_PRegen,
         body=gear.Taeon_pet_body,
         hands=gear.Taeon_pet_hands,
         legs=gear.Taeon_pet_legs,
         feet=gear.Taeon_pet_feet,
         neck="Shulmanu Collar",
         waist="Klouskap Sash",
         left_ear="Rimeice Earring",
         right_ear="Handler's Earring +1",
         left_ring="Thurandaut Ring",
         right_ring="Varar Ring",
         back=Visucius.PetDD
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Acc
    ]]
    sets.idle.Pet.Engaged.Acc = {
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = TP
    ]]
    sets.idle.Pet.Engaged.TP = set_combine(sets.idle.Pet.Engaged, {
       head = gear.Taliah_Ambuscade_head,
       body = Relic_Pitre.Body_PTP,
       hands = gear.Heyoka_hands,
       legs = gear.Taliah_Ambuscade_legs,
       feet = gear.Taeon_pet_feet,
       right_ear = "Burana Earring"
    })

    --[[
        Idle Mode = Idle
        Hybrid Mode = Regen
    ]]
    sets.idle.Pet.Engaged.Regen = {
        head = Relic_Pitre.Head_PRegen,
        neck = "Bathy Choker",
        left_ear = "Infused Earring",
        back = "Contriver's Cape"
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Ranged
    ]]
    sets.idle.Pet.Engaged.Ranged =
        set_combine(
        sets.idle.Pet.Engaged,
        {
            legs = Empy_Karagoz.Legs_Combat
        }
    )

    -------------------------------------WS
    --[[
        WSNoFTP is the default weaponskill set used
    ]]
    sets.midcast.Pet.WSNoFTP = {
        head =Empy_Karagoz.Head_PTPBonus,
        hands =gear.Mpaca_hands
    }

    --[[
        If we have a pet weaponskill that can benefit from WSFTP
        then this set will be equipped
    ]]
    sets.midcast.Pet.WSFTP = {
        head =Empy_Karagoz.Head_PTPBonus,
        hands =gear.Mpaca_hands
    }

    --[[
        Base Weapon Skill Set
        Used by default if no modifier is found
    ]]
    sets.midcast.Pet.WS = {
        head=Empy_Karagoz.Head_PTPBonus,
        body=gear.Nyame_body,
        hands=gear.Mpaca_hands,
        legs=gear.Nyame_hands,
        feet=gear.Mpaca_feet,
        neck="Deino Collar",
        waist="Klouskap Sash",
        left_ear="Burana Earring",
        right_ear="Handler's Earring +1",
        left_ring="Thurandaut Ring",
        right_ring="Varar Ring",
        back=Visucius.PetDD
    }

    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] =
        set_combine(
        sets.midcast.Pet.WSNoFTP,
        {
            -- Add your gear here that would be different from sets.midcast.Pet.WSNoFTP
            head = Empy_Karagoz.Head_PTPBonus
        }
    )

    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] =
        set_combine(
        sets.midcast.Pet.WSFTP,
        {
            -- Add your gear here that would be different from sets.midcast.Pet.WSFTP
            head = Empy_Karagoz.Head_PTPBonus
        }
    )

    ---------------------------------------------
    --  __  __ _             _____      _
    -- |  \/  (_)           / ____|    | |
    -- | \  / |_ ___  ___  | (___   ___| |_ ___
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = {
       feet = gear.MovSpd_hermes_feet
    }

    sets.idle.Town.Adoulin = set_combine(sets.idle.Town, {
        body = gear.MovSpd_adoulin_body
    })

    -- Resting sets
    sets.resting = {
       left_ear = "Infused Earring",
       neck = "Bathy Choker",
       head = Relic_Pitre.Head_PRegen
    }

    sets.defense.MasterDT = sets.idle.MasterDT

    sets.defense.PetDT = sets.pet.EmergencyDT

    sets.defense.PetMDT = set_combine(sets.pet.EmergencyDT, {})
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_animators()
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end


windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end

        if areas.Adoulin:contains(world.area) then
            equip(sets.idle.Town.Adoulin)
        else
            equip(sets.idle.Town)
        end

        -- show or hide acutocontrol on area change
        if areas.Cities:contains(world.area) then
            send_command('acon hide')
        else
            send_command('acon show')
        end

    end
)

function update_animators()
    if state.PetModeCycle.value == 'TANK' or state.PetModeCycle.value == 'DD' and state.PetStyleCycle.value == 'BONE' then
        equip(set_combine(sets.engaged.MasterPet, {
            range = Animators.Melee
        }))
    elseif state.PetModeCycle.value == 'MAGE' then
        equip(set_combine(sets.engaged.MasterPet, {
            range = Animators.Range
        }))
    elseif state.PetModeCycle.value == 'DD' then
        equip(set_combine(sets.engaged.MasterPet, {
            range = Animators.Ranged
        }))
    else
        equip(sets.engaged.MasterPet, {
            range = Animators.Melee
        })
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == "WAR" then
        set_macro_page(2, 2)
    elseif player.sub_job == "NIN" then
        set_macro_page(1, 2)
    elseif player.sub_job == "DNC" then
        set_macro_page(1, 2)
    else
        set_macro_page(1, 2)
    end
end

-- Lockstyle set on load
function set_lockstyle()
    if player.sub_job == "WAR" then
        lockstyleset = 1
    elseif player.sub_job == "NIN" then
        lockstyleset = 1
    elseif player.sub_job == "DNC" then
        lockstyleset = 1
    else
        lockstyleset = 1
    end
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end

