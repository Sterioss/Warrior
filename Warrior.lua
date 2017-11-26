if tier20 == nil then tier20 = {} end
tier20 = { 147190, 147187, 147192, 147189, 147191, 147188 }

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

    -- If we don't have the Shattered buff - cast CS
    if player.buff(AB.ShatteredDefenses).down
    and castable(SB.ColossusSmash,target)
    then
      return cast(SB.ColossusSmash,target)
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
