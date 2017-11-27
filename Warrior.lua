local function combat()
  if target.alive and target.enemy then

    -- racials checks
    if player.race == 'Orc' then
      if castable(SB.BloodFury,target) and (player.buff(AB.BattleCry).up or
      target.timetodie <= 16) then
        return cast(SB.BloodFury,target)
      end
    elseif player.race == 'Troll' then
      if castable(26297,target) and (player.buff(AB.BattleCry).up or
      target.timetodie <= 11) then
        return cast(26297,target)
      end
    elseif player.race == 'BloodElf' then
      if castable(SB.ArcaneTorrent,target) and player.buff(227266).down and
      player.power.rage.deficit > 40
      and player.spell(SB.BattleCry).cooldown ~= 0 then
        return cast(SB.ArcaneTorrent,target)
      end
    end

    -- Battlecry checks
    if castable(SB.BattleCry,target) then
      if ((target.timetodie >= 70 or player.tier(20) >= 4) and
      ((player.spell(AB.GCD).cooldown <= 0.5 and lastcast(SB.Ravager)) or
      not player.talent(7,3) and player.spell(AB.GCD).cooldown == 0 and
      target.debuff(AB.ColossusSmash).remains >= 5 and
      (player.spell(SB.BladestormArms.cooldown == 0) or player.tier(20) >= 4)
      and (not player.talent(3,2) or player.debuff(AB.rend).remains > 4))) or
      player.buff(242188).count == 2 and player.buff(AB.ShatteredDefenses).up
      and player.spell(AB.GCD).cooldown == 0 and player.tier(20) < 4 then
        return cast(SB.BattleCry,target)
      end
    end

    if target.health.percent <= 20 then

    end

    -- If we have the head or the 4pc and we're bursting - cast BS
    if not player.talent(7,3) then
      if player.buff(AB.BattleCry).up and
      (player.tier(20) >= 4 or itemequipped(IB.TheGreatStormsEye))
      and castable(SB.BladestormArms,target) then
        return cast(SB.BladestormArms,target)
      end
    end

    -- If we don't have the Shattered buff - cast CS or Warbreaker
    if player.buff(AB.ShatteredDefenses).down then
      if castable(SB.ColossusSmash,target) then
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
        player.buff(227266).up and (player.power.rage.actual >= 130 or
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
      if target.debuff(AB.Rend).remains <= player.gcd
      then
        return cast(SB.Rend,target)
      end
      if target.debuff(AB.Rend).remains < 5 and
      player.spell(SB.BattleCry).cooldown < 2 and
      (player.spell(SB.BladestormArms).cooldown < 2 or player.tier(20) < 4)
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
    if itemequipped(137052) then
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
      if target.debuff(AB.Rend).remains <= 2.4 and castable(SB.Rend,target)
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
      if (player.power.rage.actual >= 52 or not player.talent(3,2)
      or not player.talent(7,3)) and castable(SB.Slam,target)
      then
        return cast(SB.Slam,target)
      end
    end

    -- Overpower if nothing else is a priority
    if castable(SB.Overpower,target) then
      return cast(SB.Overpower,target)
    end

    -- BladestormArms if we don't have the 4pc
    if player.tier(20) >= 4 and castable(SB.BladestormArms,target) then
      return cast(SB.BladestormArms,target)
    end
  end
end

local function resting()
end

return {
    combat = combat,
    resting = resting,
    -- Version (major.minor.sub)
    version = '1.0.0'
  }
