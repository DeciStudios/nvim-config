local M = {}

M.quotes = {
    "How do you expect to get highground, if you don't take the time to build?",
    "You don't get mats by breaking other people's builds",
    "Some land on highground, others build up to it.",
    "Epic will never ask for your password, but she will.",
    "The smaller the circle, the better the people.",
    "The people with scars are the strongest.",
    "Even when you get the kill, watch out for those who try to steal your loot.",
    "You can have a full friends list, but an empty lobby.",
    "If they weren't in the storm with you, then why take them to the final circle",
    "Appreciate every season, you never know if it's the last chapter",
    "You can wrap yourself up with bandages, but you can never be fully healed",
    "People see you win the game, but they never see how many times you've lost",
    "Don't treat her like a gold pump, if she doesn't treat you like a grey tac.",
    "She wanted my chug jug, but found out it was only a mini shield.",
    "You can keep changing skins, but at the end of the day, you're always the same player",
    "Always appear confident, never let them know you're on 1 hp.",
    "Even the best players will sometimes get lost in the storm.",
    "Every elimination is a step closer to victory.",
    "It's only when you're winning, that people spectate.",
    "Keep in mind, at the beginning, even the bots were better than you.",
    "It's only when the map changes, that people miss the old one.",
    "Even max shields won't save you from the storm.",
}

-- Seed the random number generator once when the module is loaded


function M.quote_of_the_day()
    local seed = os.date("%Y%m%d")
    math.randomseed(tonumber(seed))
    local index = math.random(1, #M.quotes)
    return M.quotes[index]
end

return M
