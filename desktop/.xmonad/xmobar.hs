Config { font     = "xft:xos4 Terminus:style=Bold:size=16"
       , bgColor  = "#14181f"
       , fgColor  = "#c9ccca"
       , border   = NoBorder
       , position = Top
       , commands = [ Run Cpu     [ "--template" , "CPU: <total>%"
                                  , "--Low" , "3"
                                  , "--High" , "50"
                                  , "--high" , "#d25d5d"
                                  ] 10
                    , Run Memory  ["-t","Mem: <usedratio>%"] 10
                    , Run Date    "%d.%m. %X" "date" 10
                    , Run Battery [ "--template" , "Bat: <left>% <acstatus>"
                                  , "--low"      , "#d25d5d"
                                  , "--Low"      , "10"
                                  , "--normal"   , "#e0925c"
                                  , "--High"     , "20"
                                  , "--high"     , "#518234"
                                  , "--"
                                          -- discharging status
                                          , "-o"	, "(<timeleft>)"
                                          -- charging status
                                          , "-O"	, "On"
                                          -- charged status
                                          , "-i"	, "On"
                                  ] 50
                    , Run DynNetwork [ "--template",
                                       "<dev> <fc=#7c838b>|</fc>"
                                     ] 10
                    , Run StdinReader
                    ]
       , sepChar  = "%"
       , alignSep = "}{"
       , template = " %StdinReader% }{ %dynnetwork% %battery% <fc=#7c838b>|</fc> %cpu% <fc=#7c838b>|</fc> %memory%      %date% "
       }

