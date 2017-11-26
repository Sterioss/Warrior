local engine = ...
local tier20 = { 147190, 147187, 147192, 147189, 147191, 147188 }
-- returns how many parts items we have
local function T20parts()
  equipeditems = 0
  for i=1, tier20[] do
    if tier20[i] ~= nill then
      if itemequipped(tier20[i]) then
        equipeditems + 1
      end
    end
  end
  return equipeditems
end

local function Combat()
  -- If we have something we can attack
  if UnitCanAttack('player', target) and player.inmelee and
   target.infront(target,180) and target.alive
  then

    -- If we have the head or the 4pc and we're bursting - cast BS
    if not player.talent(7,3) then
      if player.buff(AB.BattleCry).up and
      (T20parts >= 4 or itemequipped(IB.TheGreatStormsEye))
      and castable(SB.Bladestorm,target) then
        return cast(SB.Bladestorm,target)
      end
    end

    -- If we don't have the Shattered buff - cast CS or Warbreaker
    if player.buff(AB.ShatteredDefenses).down then
      if castable(SB.ColossusSmash,target) then
      then
        return cast(SB.ColossusSmash,target)
      end
      if (player.buff(225947).up or player.spell(SB.MortalStrike).cooldown <=
      player.spell(61304).cooldown) and (not player.talent(5,1) or
      (player.talent(5,1) and target.debuff(AB.ColossusSmash) < player.gcd)) and
      castable(SB.Warbreaker,target)
      then
        return cast(SB.Warbreaker,target)
      end
    end

    -- Checks for FocusedRage
    if player.talent(6,3) then
      if player.buff(AB.FocusedRageArm).count < 3 then
        if not player.spell(SB.ColossusSmash).cooldown == 0 and
        player.buff(227266).up and (player.power.rage >= 130 or
        target.debuff(AB.ColossusSmash).down or player.talent(7,1) and
        player.spell(SB.BattleCry).cooldown <= 8) and
        castable(SB.FocusedRageArm,target)
        then
          return cast(SB.FocusedRageArm,target)
        end
      end
    end

    -- If rend remaining time is under 2.4 or we're about to burst - cast rend
    if player.talent(3,2) then
      if (target.debuff(AB.Rend).duration <= player.GCD or
      (target.debuff(AB.Rend).duration < 5 and
      player.spell(SB.BattleCry).cooldown < 2 and
      (player.spell(SB.Bladestorm).cooldown < 2 or T20parts >= 2)))
      and castable(SB.Rend,target)
      then
        return cast(SB.Rend,target)
      end
    end

    -- If burst CD is <= to the GCD and we're fine with CS debuff - cast Ravager
    if player.talent(7,3) then
      if player.spell(SB.BattleCry).cooldown <= player.spell(AB.GCD).cooldown
      and target.debuff(AB.ColossusSmash).duration > 6
      and castable(SB.Ravager,target)
      then
        return cast(SB.Ravager,target)
      end
    end

    -- legendary ring buff up -> cast execute
    if player.itemequipped(137052) then
      if player.buff(225947).up and castable(SB.Execute,target) then
        return cast(SB.Execute,target)
      end
    end

    -- If overpower is up and we're not bursting - cast overpower
    if player.talent(1,2) then
      if player.buff(AB.Overpower).up and player.buff(AB.BattleCry).down
      and castable(SB.Overpower,target)
      then
        return cast(SB.Overpower,target)
      end
    end

    -- casting MS if the buff's up
    if player.buff(AB.ShatteredDefenses).up or player.buff(242188).down
    and castable(12294,target) then
      return cast(12294,target)
    end

    -- refreshing Rend on next gcd if it's close to end
    if player.talent(3,2) then
      if target.debuff(AB.Rend).duration <= 2.4 and castable(SB.Rend,target)
      then
        return cast(SB.Rend,target)
      end
    end

    -- WhirlWind if we don't have the FoB talent
    if player.talent(5,1) and --[[ check for WW targent > 1 ]]
    castable(SB.WhirlWind,target) then
      return cast(SB.WhirlWind,target)
    end

    -- cast slam when we don't have FoB have 52rage, not rend or not ravager
    if not player.talent(5,1) --[[ check for WW targets = 1 ]] then
      if (player.power.rage >= 52 or not player.talent(3,2)
      or not player.talent(7,3)) and castable(SB.Slam,target)
      then
        return cast(SB.Slam,target)
      end
    end

    -- Overpower if nothing else is a priority
    if castable(SB.Overpower,target) then
      return cast(SB.Overpower,target)
    end

    -- Bladestorm if we don't have the 4pc
    if T20parts < 4 and castable(SB.Bladestorm,target) then
      return cast(SB.Bladestorm,target)
    end
