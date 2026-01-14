SMODS.Joker {
    key = "malvi",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    pos = { x = 4, y = 11 }, -- change these
	--atlas = "corru_atlas",
    config = { extra = { flavours = {'tag_polychrome','tag_negative','tag_rare','tag_investment','tag_voucher','tag_handy','tag_garbage','tag_coupon','tag_double','tag_economy'}}, poker_hand = 'High Card' },
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key = 'tag_investment', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_voucher', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_polychrome', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_negative', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_handy', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_rare', set = 'Tag'}
		info_queue[#info_queue+1] = {key = 'tag_garbage', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_coupon', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_double', set = 'Tag'}
		info_queue[#info_queue+1] = {key = 'tag_economy', set = 'Tag'}
        return { vars = { card.ability.extra.flavours, localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.poker_hand then
			add_tag(Tag(pseudorandom_element(card.ability.extra.flavours, pseudoseed('malvi'))))
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'vremade_to_do')
            return {
                message = localize('k_reset')
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = handname
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'vremade_to_do')
    end
}