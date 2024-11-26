local sets = require("sets")
local texts = require("texts")
local burden = require("burden")

local pet_actions = 
{
    [136] = "activate",
    [139] = "deactivate",
    [141] = "fire",
    [142] = "ice",
    [143] = "wind",
    [144] = "earth",
    [145] = "thunder",
    [146] = "water",
    [147] = "light",
    [148] = "dark",
    [309] = "cooldown",
    [310] = "deus_ex_automata",
}

local maneuvers = 
S{
    141,
    142,
    143,
    144,
    145,
    146,
    147,
    148,
}

hub_pet_burden = [[ \cs(255, 115, 0)======= Pet Burden =======\cr
- \cs(125, 125, 0)Fire :\cr ${fire|0} - ${time_fire|0}s - ${risk_fire|0}%
- \cs(125, 125, 0)Ice :\cr ${ice|0} - ${time_ice|0}s - ${risk_ice|0}%
- \cs(125, 125, 0)Wind :\cr ${wind|0} - ${time_wind|0}s - ${risk_wind|0}%
- \cs(125, 125, 0)Earth :\cr ${earth|0} - ${time_earth|0}s - ${risk_earth|0}%
- \cs(125, 125, 0)Thunder :\cr ${thunder|0} - ${time_thunder|0}s - ${risk_thunder|0}%
- \cs(125, 125, 0)Water :\cr ${water|0} - ${time_water|0}s - ${risk_water|0}%
- \cs(125, 125, 0)Light :\cr ${light|0} - ${time_light|0}s - ${risk_light|0}%
- \cs(125, 125, 0)Dark :\cr ${dark|0} - ${time_dark|0}s - ${risk_dark|0}%
]]

local default_settings = T{}
    default_settings.pos = {}
    default_settings.pos.x = pos_x
    default_settings.pos.y = pos_y
    default_settings.bg = {}
    default_settings.bg.alpha = 200
    default_settings.bg.red = 40
    default_settings.bg.green = 40
    default_settings.bg.blue = 55
    default_settings.bg.visible = true
    default_settings.flags = {}
    default_settings.flags.right = false
    default_settings.flags.bottom = false
    default_settings.flags.bold = true
    default_settings.flags.draggable = true
    default_settings.flags.italic = false
    default_settings.padding = 10
    default_settings.text = {}
    default_settings.text.size = 12
    default_settings.text.font = 'Arial'
    default_settings.text.fonts = {}
    default_settings.text.alpha = 255
    default_settings.text.red = 147
    default_settings.text.green = 161
    default_settings.text.blue = 161
    default_settings.text.stroke = {}
    default_settings.text.stroke.width = 0
    default_settings.text.stroke.alpha = 255
    default_settings.text.stroke.red = 0
    default_settings.text.stroke.green = 0
    default_settings.text.stroke.blue = 0

local hud = texts.new(hub_pet_burden, default_settings)

function update_hud(element)
    hud[element] = burden[element]

    risk = burden[element] - burden.threshold
    hud["risk_" .. element] = risk > 0 and risk or 0
    hud["color_" .. element] = "255," .. (risk > 33 and 0 or 255) .. "," .. (risk > 0 and 0 or 255)
    hud["time_" .. element] = (burden[element] / burden.decay_rate) * 3
end

windower.register_event("action", function(act)
    local abil_id = act['param']
    local actor_id = act['actor_id']
    local player = windower.ffxi.get_player()
    local pet_index = windower.ffxi.get_mob_by_index(player.index).pet_index

    if player.main_job_id ~= 18 then
        return
    end

    if act["category"] == 6 and actor_id == player.id and pet_actions[abil_id] then
        burden:update(pet_actions[abil_id]) -- Always assumes good burden (+15).
        if maneuvers:contains(abil_id) then
            if act.targets[1].actions[1].param > 0 then
                burden[pet_actions[abil_id]] = burden.threshold + act.targets[1].actions[1].param -- Corrects for bad burden when over threshold.
            end
            update_hud(pet_actions[abil_id])
        end
    end
end)

local function decay_event()
    for element in pairs(burden) do
        update_hud(element)
    end
end
burden.set_decay_event(decay_event)

windower.register_event("zone change", function()
    burden:zone()
end)

local function update_decay_rate(buff_id)
    if buff_id == 305 then
        burden:update_decay_rate()
    end
end

windower.register_event("gain buff", update_decay_rate)
windower.register_event("lose buff", update_decay_rate)

decay_event()

return hud
