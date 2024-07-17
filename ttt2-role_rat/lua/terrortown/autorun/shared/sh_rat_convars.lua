CreateConVar("ttt2_rat_traitor_reveal_timer", 120, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_rat_instant_expose", 0, {FCVAR_ARCHIVE, FCVAR_NOTIFY})

hook.Add("TTTUlxDynamicRCVars", "TTTUlxDynamicRatCVars", function(tbl)
  tbl[ROLE_RAT] = tbl[ROLE_RAT] or {}

table.insert(tbl[ROLE_RAT], {
      cvar = "ttt2_rat_traitor_reveal_timer",
      slider = true,
      min = 60,
      max = 240,
      decimal = 0,
      desc = "ttt2_rat_traitor_reveal_timer (def. 120)"
})
end)