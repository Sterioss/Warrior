if tier20 == nil then tier20 = {} end
tier20 { 147190, 147187, 147192, 147189, 147191, 147188, }

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
    if player.buff(BattleCry).up and
    (equipeditems >= 4 or itemequipped(TheGreatStormsEye))
    and castable(Bladestorm,target) then
      return cast(Bladestorm,target)
    end

    -- If we don't have the Shattered buff - cast CS
    if player.buff(ShatteredDefenses).down and castable(ColossusSmash,target)
    then
      return cast(ColossusSmash,target)
    end

    -- If rend remaining time is under 2.4 or we're about to burst - cast rend
    if (target.debuff(rend).duration <= player.GCD or
    (target.debuff(rend).duration < 5 and
    player.spell(BattleCry).cooldown < 2 and
    (player.spell(Bladestorm).cooldown < 2 or equipeditems >= 2)))
    and castable(Rend,target)
    then
      return cast(Rend,target)
    end

    -- If overpower is up and we're not bursting - cast overpower
    if player.buff(Overpower).up and player.buff(BattleCry).down
    and castable(Overpower,target)
    then
      return cast(Overpower,target)
    end
