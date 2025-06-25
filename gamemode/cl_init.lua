include("sh_init.lua")

-- Inspired by Parallax Framework.
BaseLocalPlayer = BaseLocalPlayer or LocalPlayer
function LocalPlayer()
    if ( IsValid(SCP.cachedClient) ) then
        return SCP.cachedClient
    end

    return BaseLocalPlayer()
end