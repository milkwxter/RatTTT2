local L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[RAT.name] = "Rat"
L["info_popup_" .. RAT.name] = [[You are the Rat! You will learn the name of a Traitor after some time.]]
L["body_found_" .. RAT.abbr] = "They were a Rat."
L["search_role_" .. RAT.abbr] = "This person was a Rat!"
L["target_" .. RAT.name] = "Rat"
L["ttt2_desc_" .. RAT.name] = [[The Rat will learn the name of a Traitor after a certain amount of time.]]

-- CUSTOM ROLE LANGUAGE STRINGS
L["label_rat_traitor_reveal_time"] = "How long should it take to expose a Traitor to the Rat?"
L["label_rat_instant_expose"] = "Instantly expose rat? Rat must still wait for a timer: "

-- TIMER ROLE LANGUAGE STRINGS
L["ratTimerName"] = "Rat Expose Timer"
L["ratTimerDesc"] = "When this timer finishes, exposes a Traitor to you."
