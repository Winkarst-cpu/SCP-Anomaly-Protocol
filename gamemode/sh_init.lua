GM.Name = "SCP: Anomaly Protocol"
GM.Author = "winkarst"
GM.Website = "https://github.com/Winkarst-cpu/SCP-Anomaly-Protocol"

SCP = SCP or {}

include("sh_util.lua")

SCP.Util:Include("hooks/cl_hooks.lua")
SCP.Util:Include("hooks/sh_hooks.lua")
SCP.Util:Include("hooks/sv_hooks.lua")

SCP.Util:IncludeFolder("libraries/client", SCP_REALM_CLIENT)
SCP.Util:IncludeFolder("libraries/server", SCP_REALM_SERVER)
SCP.Util:IncludeFolder("libraries/shared", SCP_REALM_SHARED)
SCP.Util:IncludeFolder("libraries/thirdparty")

SCP.Util:IncludeFolder("meta/client", SCP_REALM_CLIENT)
SCP.Util:IncludeFolder("meta/server", SCP_REALM_SERVER)
SCP.Util:IncludeFolder("meta/shared", SCP_REALM_SHARED)