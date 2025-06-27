GM.Name = "SCP: Anomaly Protocol"
GM.Author = "winkarst"
GM.Website = "https://github.com/Winkarst-cpu/SCP-Anomaly-Protocol"

SCP = SCP or {}

-- Include our gamemode.
include("sh_util.lua")

SCP.Util:Include("hooks/sh_hooks.lua", "shared")
SCP.Util:Include("hooks/cl_hooks.lua", "client")
SCP.Util:Include("hooks/sv_hooks.lua", "server")

SCP.Util:Include("net/cl_net.lua", "client")
SCP.Util:Include("net/sv_net.lua", "server")

SCP.Util:IncludeFolder("libraries/shared", "shared")
SCP.Util:IncludeFolder("libraries/client", "client")
SCP.Util:IncludeFolder("libraries/server", "server")
SCP.Util:IncludeFolder("libraries/thirdparty")

SCP.Util:IncludeFolder("meta/shared", "shared")
SCP.Util:IncludeFolder("meta/client", "client")
SCP.Util:IncludeFolder("meta/server", "server")

SCP.Util:IncludeFolder("vgui", "client")