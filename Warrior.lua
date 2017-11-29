
local engine = ...
local function combat()
  if not config('main', 'enable') then return end

  local inInstance, instanceType = IsInInstance()
  if instanceType ~= "pvp" and instanceType ~= "arena" then
    -- Surviving seems essential
    if UnitThreatSituation("player") ~= nill then
      if UnitThreatSituation("player") > 1 then
        if player.enemies(10) > 0 and castable(SB.DiebytheSword) then
          return cast(SB.DiebytheSword,target)
        end
      end
    end

    if target.alive and target.enemy and then

      -- if we're not attacking
      if not IsCurrentSpell(6603) and then
        StartAttack("target")
      end

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

      -- Avatar checks
      if castable(SB.Avatar,target) and player.talent(3,3) then
        if target.timetodie <= 20 then
          return cast(SB.Avatar,target)
        end
        if player.spell(AB.GCD).cooldown < 0.25 and (player.buff(AB.BattleCry).up
        or player.spell(SB.BattleCry).cooldown < 15) then
          return cast(SB.Avatar,target)
        end
      end

      -- Battlecry checks
      if castable(SB.BattleCry,target) then
        if target.debuff(242188).count == 2 and player.buff(AB.ShatteredDefenses).up
        and player.spell(AB.GCD).cooldown == 0 and player.tier(20) < 4 then
          return cast(SB.BattleCry,target)
        end
        if target.timetodie >= 70 or player.tier(20) >= 4
        or player.enemies(8,true) >= 2 then
          if player.spell(AB.GCD).cooldown <= 0.5 and lastcast(SB.Ravager) then
            return cast(SB.BattleCry,target)
          end
          if player.talent(7,3) == false
          and player.spell(AB.GCD).cooldown == 0 and
          target.debuff(AB.ColossusSmash).remains >= 5 and
          (player.spell(SB.BladestormArms).cooldown == 0
          or player.tier(20) < 4) and (player.talent(3,2) == false
          or target.debuff(AB.Rend).remains > 4)
          then
            return cast(SB.BattleCry,target)
          end
        end
      end

      --[[  cleave situation
      --]]
      if player.enemies(8,true) >= 2 and player.talent(1,3) then

        local Ucd = 2 * (player.gcd)
        -- Warbreaker
        if castable(SB.Warbreaker,target)
        and player.spell(SB.Ravager).cooldown <= player.gcd
        and player.spell(SB.BattleCry).cooldown <= Ucd
        and target.inmelee then
          return cast(SB.Warbreaker,target)
        end

        -- Ravager
        if castable(SB.Ravager,target) then
          if lastcast(SB.Warbreaker) then
            return cast(SB.Ravager,target)
          end
        end

        -- MS on CD
        if castable(SB.MortalStrike,target) and
        (player.power.rage.actual >= 20 or (player.talent(1,1) and
        player.power.rage.actual >= 18)) then
          return cast(SB.MortalStrike,target)
        end

        -- Execute proc
        if itemequipped(137052) then
          if player.buff(225947).up and castable(SB.Execute,target) then
            return cast(SB.Execute,target)
          end
        end

        -- ColossusSmash
        if castable(SB.ColossusSmash,target)
        and player.spell(SB.Warbreaker).cooldown > 2 then
          if player.buff(AB.ShatteredDefenses).down
          and player.buff(AB.PreciseStrikes).down then
            return cast(SB.ColossusSmash,target)
          end
        end



        -- FocusedRageArm
        if player.talent(6,3) then
          if castable(SB.FocusedRageArm,target)
          and (player.power.rage.actual > 100 or player.buff(227266).up) then
            return cast(SB.FocusedRageArm,target)
          end
        end

        -- Whirlwind
        if player.talent(5,1) and castable(SB.Whirlwind,target) then
          if (target.debuff(AB.ColossusSmash).up
          or player.power.rage.deficit < 50) and (player.talent(6,3) == false
          or player.buff(227266).up or player.buff(AB.Cleave).up) then
            return cast(SB.Whirlwind,target)
          end
        end

        -- Rend
        if castable(SB.Rend,target)
        and target.debuff(AB.Rend).remains <= 2.4 and
        (player.power.rage.actual >= 30 or (player.talent(1,1) and
        player.power.rage.actual >= 27)) then
          return cast(SB.Rend,target)
        end

        -- Bladestorm
        if castable(SB.BladestormArms,target) then
          return cast(SB.BladestormArms,target)
        end

        -- Cleave
        if castable(SB.Cleave,target) and
        (player.power.rage.actual >= 10 or (player.talent(1,1) and
        player.power.rage.actual >= 9)) then
          return cast(SB.Cleave,target)
        end

        -- WhirlWind - buff Cleave
        if castable(SB.Whirlwind,target) then
          if player.power.rage.actual > 40 or player.buff(AB.Cleave).up then
            return cast(SB.Whirlwind,target)
          end
        end
      end

      --[[  AoE situation
      --]]
      if player.enemies(8,true) >= 5 and player.talent(1,3) == false then

        local Ucd = 2 * (player.gcd)
        -- Warbreaker
        if castable(SB.Warbreaker,target)
        and player.spell(SB.Ravager).cooldown <= player.gcd
        and player.spell(SB.BattleCry).cooldown <= Ucd
        and target.inmelee then
          return cast(SB.Warbreaker,target)
        end

        -- Ravager
        if castable(SB.Ravager,target) then
          if lastcast(SB.Warbreaker) then
            return cast(SB.Ravager,target)
          end
        end

        -- BladestormArms
        if player.castable(SB.BladestormArms,target) then
          if player.buff(AB.BattleCry).up and (player.tier(20) >= 4
          or itemequipped(IB.TheGreatStormsEye)) then
            return cast(SB.BladestormArms,target)
          end
        end

        -- ColossusSmash
        if castable(SB.ColossusSmash,target)
        and player.spell(SB.Warbreaker).cooldown > 2 then
          if player.buff(AB.InForTheKill).down and player.talent(6,2) then
            return cast(SB.ColossusSmash,target)
          end
        end

        -- CS cycle

        -- Cleave
        if castable(SB.Cleave,target) and
        (player.power.rage.actual >= 10 or (player.talent(1,1) and
        player.power.rage.actual >= 9)) then
          if player.enemies(8) >= 5 then
            return cast(SB.Cleave,target)
          end
        end

        -- Whirlwind
        

      end

      --[[  Execute situation
      --]]
      if target.health.percent <= 20 and player.enemies(8,true) < 5 then
        -- BladestormArms if we've the head or 4pc on burst
        if castable(SB.BladestormArms,target) and player.talent(7,3) == false
        then
          if player.buff(AB.BattleCry).up and (player.tier(20) >= 4 or
          itemequipped(IB.TheGreatStormsEye)) then
            return cast(SB.BladestormArms,target)
          end
        end

        -- If we have ShatteredDefenses down
        if player.buff(AB.ShatteredDefenses).down then
          -- go for ColossusSmash
          if castable(SB.ColossusSmash,target) then
            if player.buff(AB.BattleCry).down then
              return cast(SB.ColossusSmash,target)
            end
            if target.debuff(242188).count == 2 and
            (player.spell(AB.BattleCry).cooldown < 1
            or player.buff(AB.BattleCry).up) then
              return cast(SB.ColossusSmash,target)
            end
          end -- castable ColossusSmash
          -- or go for warkreaker
          if castable(SB.Warbreaker,target) and target.inmelee then
            if player.spell(SB.MortalStrike).cooldown <=
            player.spell(AB.GCD).cooldown
            and target.debuff(242188).count == 2 then
              return cast(SB.Warbreaker,target)
            end
          end -- castable warkreaker
        end -- ShatteredDefenses down

        -- focused rage if we're too high on rage
        if player.talent(6,3) then
          if player.power.rage.deficit < 35 then
            return cast(SB.FocusedRageArm,target)
          end
        end -- End of FocusedRageArm

        -- Rend
        if castable(SB.Rend,target) then
          if target.debuff(AB.Rend).remains < 5 and
          player.spell(SB.BattleCry).cooldown < 2 and
          (player.spell(SB.BladestormArms).cooldown < 2 or
          player.tier(20) < 4) and
          (player.power.rage.actual >= 30 or (player.talent(1,1) and
          player.power.rage.actual >= 27))
          then
            return cast(SB.Rend,target)
          end
        end

        -- Ravager
        if castable(SB.Ravager,target) then
          if player.spell(SB.Ravager).cooldown <= player.gcd and
          target.debuff(AB.ColossusSmash).remains > 6 then
            return cast(SB.Ravager,target)
          end
        end

        -- Whirlwind
        if castable(SB.Whirlwind,target) then
          if player.talent(5,1) and player.buff(253383).count == 3 and
          target.debuff(AB.ColossusSmash).up and player.buff(AB.BattleCry).down
          and (player.power.rage.actual >= 30 or (player.talent(1,1) and
          player.power.rage.actual >= 27))
          then
            return cast(SB.Whirlwind,target)
          end
        end

        -- MortalStrike
        if castable(SB.MortalStrike,target) then
          if target.debuff(242188).count == 2 and
          player.buff(AB.ShatteredDefenses).up and
          (player.power.rage.actual >= 20 or (player.talent(1,1) and
          player.power.rage.actual >= 18))
          then
            return cast(SB.MortalStrike,target)
          end
        end

        -- Overpower
        if castable(SB.Overpower,target) then
          if player.power.rage.actual < 40 then
            return cast(SB.Overpower,target)
          end
        end

        -- Execute
        if castable(SB.Execute,target) then
          if player.buff(AB.ShatteredDefenses).down or
          player.power.rage.actual >= 40 or (player.talent(1,1) and
          player.power.rage.actual >= 36) then
            return cast(SB.Execute,target)
          end
        end

        -- BladestormArms interrupt
        if player.buff(SB.BladestormArms).up and player.tier(20) < 4 then
          return CancelUnitBuff("player", AB.BladestormArms)
        end
      end

      --[[  ST situation
      --]]
      if target.health.percent > 20 then

        -- If we have the head or the 4pc and we're bursting - cast BS
        if player.talent(7,3) == false then
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
          if castable(SB.Warbreaker,target) and target.inmelee then
            if (player.buff(225947).up or player.spell(SB.MortalStrike).cooldown <=
            player.spell(61304).cooldown) and player.talent(5,1) == false then
              return cast(SB.Warbreaker,target)
            end
            if (player.talent(5,1) and target.debuff(AB.ColossusSmash).remains
            < player.gcd) then
              return cast(SB.Warbreaker,target)
            end
          end
        end

        -- Checks for FocusedRage
        if player.talent(6,3) then
          if player.buff(207982).count < 3 then
            if player.spell(SB.ColossusSmash).cooldown > player.gcd and
            player.buff(227266).down and (player.power.rage.actual >= 130 or
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
          if target.debuff(AB.Rend).remains <= player.gcd and
          (player.power.rage.actual >= 30 or (player.talent(1,1) and
          player.power.rage.actual >= 27))
          then
            return cast(SB.Rend,target)
          end
          if target.debuff(AB.Rend).remains < 5 and
          player.spell(SB.BattleCry).cooldown < 2 and
          (player.spell(SB.BladestormArms).cooldown < 2 or player.tier(20) < 4)
          and castable(SB.Rend,target) and
          (player.power.rage.actual >= 30 or (player.talent(1,1) and
          player.power.rage.actual >= 27))
          then
            return cast(SB.Rend,target)
          end
        end

        -- If burst CD is <= to the GCD and we're fine with CS debuff - cast Ravager
        if player.talent(7,3) and castable(SB.Ravager,target) then
          if player.spell(SB.BattleCry).cooldown <= player.gcd
          and target.debuff(AB.ColossusSmash).duration > 6
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
        if castable(SB.MortalStrike,target) then
          if (player.buff(AB.ShatteredDefenses).up or target.debuff(242188).down)
          and (player.power.rage.actual >= 20 or (player.talent(1,1) and
          player.power.rage.actual >= 18))
          then
            return cast(12294,target)
          end
        end

        -- refreshing Rend on next gcd if it's close to end
        if player.talent(3,2) then
          if target.debuff(AB.Rend).remains <= 2.4 and castable(SB.Rend,target)
          and (player.power.rage.actual >= 30 or (player.talent(1,1) and
          player.power.rage.actual >= 27))
          then
            return cast(SB.Rend,target)
          end
        end

        -- Whirlwind if we don't have the FoB talent
        if (player.talent(5,1) or player.enemies(8,true) > 1) and
        castable(SB.Whirlwind,target) and (player.power.rage.actual >= 30 or
        (player.talent(1,1) and player.power.rage.actual >= 27))
        then
          return cast(SB.Whirlwind,target)
        end

        -- cast slam when we don't have FoB have 52rage, not rend or not ravager
        if player.talent(5,1) == false and player.enemies(8,true) == 1 then
          if (player.power.rage.actual >= 52 or player.talent(3,2) == false
          or player.talent(7,3) == false) and castable(SB.Slam,target) and
          (player.power.rage.actual >= 20 or (player.talent(1,1) and
          player.power.rage.actual >= 18))
          then
            return cast(SB.Slam,target)
          end
        end

        -- Overpower if nothing else is a priority
        if player.talent(1,2) then
          if castable(SB.Overpower,target) then
            return cast(SB.Overpower,target)
          end
        end

        -- BladestormArms if we don't have the 4pc
        if player.talent(7,3) == false then
          if player.tier(20) >= 4 and castable(SB.BladestormArms,target) then
            return cast(SB.BladestormArms,target)
          end
        end
      end -- End of >20%
    end -- End of target alive
  end -- instanceType
end -- Combat

local function resting()
  if not config('main', 'enable') then return end

  -- checking for dbm pulls
  function hkEvent_CHAT_MSG_ADDON(noidea, prefix, message, channel)
    if prefix == "D4" and string.sub(message,1,2) == "PT" then
      timer = string.sub(message,4,5);
      if timer <= 0.5 and target.exists and usable(127844) then
        return use(127844)
      end
      if timer == 0 and target.exists and castable(SB.Charge,target) then
        return cast(SB.Charge,target)
      end
    end
  end -- End of dbm Checks

end

return {
    combat = combat,
    resting = resting,
    -- Version (major.minor.sub)
    version = '1.0.0'
  }
