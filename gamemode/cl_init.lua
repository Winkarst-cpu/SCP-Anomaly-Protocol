include("sh_init.lua")

SCP.LocalPlayer = SCP.LocalPlayer or LocalPlayer
function LocalPlayer()
    return IsValid(SCP.cachedClient) and SCP.cachedClient or SCP.LocalPlayer()
end