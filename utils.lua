

function KAIJUTIL.apply_plasma_effect(card, only_visual)
  -- Actually balance the chips and mult
  if not only_visual then
    local tot = hand_chips + mult
    hand_chips = mod_chips(math.floor(tot / 2))
    mult = mod_mult(math.floor(tot / 2))
  end

  update_hand_text({ delay = 0 }, { mult = mult, chips = hand_chips })

  -- Cosmetic effects
  G.E_MANAGER:add_event(Event({
    func = (function()
      -- Play sounds and change the color of the scoring values
      play_sound('gong', 0.94, 0.3)
      play_sound('gong', 0.94 * 1.5, 0.2)
      play_sound('tarot1', 1.5)
      ease_colour(G.C.UI_CHIPS, { 0.8, 0.45, 0.85, 1 })
      ease_colour(G.C.UI_MULT, { 0.8, 0.45, 0.85, 1 })

      -- If a card was passed, show the balanced message on it
      if card then
        SMODS.calculate_effect({
          message = localize('k_balanced'),
          colour  = { 0.8, 0.45, 0.85, 1 },
          instant = true
        }, card)
      end

      -- Return the colors to normal
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        blocking = false,
        delay = 4.3,
        func = (function()
          ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
          ease_colour(G.C.UI_MULT, G.C.RED, 2)
          return true
        end)
      }))

      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        blocking = false,
        no_delete = true,
        delay = 6.3,
        func = (function()
          G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] =
              G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
          G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] =
              G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
          return true
        end)
      }))
      return true
    end)
  }))

  delay(0.6)
end