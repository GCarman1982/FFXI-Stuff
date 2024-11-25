-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()

    -- Capacity Cape
    gear.Capacity_Cape = {name="Mecisto. Mantle"}

    -- Nyame set
    gear.Nyame_head = {name="Nyame Helm"}
    gear.Nyame_body = {name="Nyame Mail"}
    gear.Nyame_hands = {name="Nyame Gauntlets"}
    gear.Nyame_legs = {name="Nyame Flanchard"}
    gear.Nyame_feet = {name="Nyame Sollerets"}

    -- Mpaca set
    gear.Mpaca_head = {name="Mpaca's Cap"}
    gear.Mpaca_body = {name="Mpaca's Doublet"}
    gear.Mpaca_hands = {name="Mpaca's Gloves"}
    gear.Mpaca_legs = {name="Mpaca's Hose"}
    gear.Mpaca_feet = {name="Mpaca's Boots"}

    -- Malignance set
    gear.Malignance_head = {name="Malignance Chapeau"}
    gear.Malignance_body = {name="Malignance Tabard"}
    gear.Malignance_hands = {name="Malignance Gloves"}
    gear.Malignance_legs = {name="Malignance Tights"}
    gear.Malignance_feet = {name="Malignance Boots"}

    -- Herc set
    gear.Herc_WS_MAB_hands = {name="Herculean Gloves", augments={'"Mag.Atk.Bns."+5','Weapon skill damage +5%','INT+9'}}

    -- Taeon pet set
    gear.Taeon_pet_head = {name="Taeon Chapeau", augments={'Pet: Attack+25 Pet: Rng. Acc.+25'}}
    gear.Taeon_pet_body = {name="Taeon Tabard", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+5','Pet: Damage taken -3%'}}
    gear.Taeon_pet_hands = {name="Taeon Gloves", augments={'Pet: Accuracy+17 Pet: Rng. Acc.+17','Pet: "Dbl. Atk."+5','Pet: Damage taken -3%'}}
    gear.Taeon_pet_legs = {name="Taeon Tights", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -3%'}}
    gear.Taeon_pet_feet = {name="Taeon Boots", augments={'Pet: Attack+20 Pet: Rng.Atk.+20','Pet: "Dbl. Atk."+4','Pet: Damage taken -4%'}}

    -- Heyoka set
    gear.Heyoka_head = {name="Heyoka Cap"}
    gear.Heyoka_body = {name="Heyoka Harness"}
    gear.Heyoka_hands = {name="Heyoka Mittens"}
    gear.Heyoka_legs = {name="Heyoka Subligar"}
    gear.Heyoka_feet = {name="Heyoka Leggings"}

    -- WS Elemental belt
    gear.Elemental_belt = {name="Fotia Belt"}

    -- TP Bonus gear
    gear.Moonshade_Earring = {name="Moonshade Earring"}

    -- Movement speed gear
    gear.MovSpd_adoulin_body = {name="Councilor's Garb"}
    gear.MovSpd_hermes_feet = {name="Hermes' Sandals"}

    -- DT All jobs
    gear.DT_Twilight_Torque = {name="Twilight Torque"}
    gear.DT_Defending_Ring = {name="Defending Ring"}

    -- Ninja useable accross other jobs
    gear.Utsusemi_Neck = {name="Magoraga Beads"}

    -- Carmine set
    gear.Carmine_head = {name="Carmine Mask +1"}
    gear.Carmine_hands = {name="Carmine Fin. Gauntlets"}
    gear.Carmine_legs = {name="Carmine Cuisses +1"}
    gear.Carmine_feet = {name="Carmine Greaves +1"}

    -- Multi Job Ambuscade sets
    gear.Meghanada_Ambuscade_head = {name="Meghanada Visor +2"}
    gear.Meghanada_Ambuscade_body = {name="Meghanada Cuirie +2"}
    gear.Meghanada_Ambuscade_hands = {name="Meghanada Gloves +2"}
    gear.Meghanada_Ambuscade_legs = {name="Meghanada Chausses +2"}
    gear.Meghanada_Ambuscade_feet = {name="Meghanada Jambeaux +2"}
    gear.Mummu_Ambuscade_head = {name="Mummu Bonnet +2"}
    gear.Mummu_Ambuscade_body = {name="Mummu Jacket +2"}
    gear.Mummu_Ambuscade_hands = {name="Mummu Wrists +2"}
    gear.Mummu_Ambuscade_legs = {name="Mummu Kecks +2"}
    gear.Mummu_Ambuscade_feet = {name="Mummu Gamash +2"}
    gear.Taliah_Ambuscade_head = {name="Tali'ah Turban +2"}
    gear.Taliah_Ambuscade_body = {name="Tali'ah Jacket +2"}
    gear.Taliah_Ambuscade_hands = {name="Tali'ah Gloves +2"}
    gear.Taliah_Ambuscade_legs = {name="Tali'ah Seraweels +2"}
    gear.Taliah_Ambuscade_feet = {name="Tali'ah Crackows +2"}
    gear.Hizamaru_Ambuscade_head = {name="Hizamaru Somen +2"}
    gear.Hizamaru_Ambuscade_body = {name="Hizamaru Haramaki +2"}
    gear.Hizamaru_Ambuscade_hands = {name="Hizamaru Kote +2"}
    gear.Hizamaru_Ambuscade_legs = {name="Hizamaru Hizayoroi +2"}
    gear.Hizamaru_Ambuscade_feet = {name="Hizamaru Sune-Ate +2"}
end

laggy_zones = S{'Al Zahbi', 'Aht Urhgan Whitegate', 'Eastern Adoulin', 'Mhaura', 'Nashmau', 'Selbina', 'Western Adoulin'}

windower.register_event('zone change',
    function()
      -- Caps FPS to 30 via Config addon in certain problem zones
        --[[if laggy_zones:contains(world.zone) then
            send_command('config FrameRateDivisor 2')
        else
            send_command('config FrameRateDivisor 1')
        end]]--

        -- Auto load Omen add-on
        if world.zone == 'Reisenjima Henge' then
            send_command('lua l omen')
        end
    end
)