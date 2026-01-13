KAIJUTIL = {}

SMODS.Atlas {
    key = "kaiju_atlas",
    path = "Jokers.png",
    px = 71,
    py = 95,
}

SMODS.load_file("utils.lua")()

to_big = to_big or function (value)
    return value
end

local sub = "jokers"
local jokers = NFS.getDirectoryItems(SMODS.current_mod.path..sub)
for k, v in pairs(jokers) do
    assert(SMODS.load_file(sub.."/"..v))()
end