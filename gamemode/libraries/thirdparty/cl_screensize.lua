-- By @Srlion

local cScrW = ScrW()
local cScrH = ScrH()

function ScrW()
    return cScrW
end

function ScrH()
    return cScrH
end

hook.Add("OnScreenSizeChanged", "UpdateScreenSize", function(_, _, newW, newH)
    cScrW = newW
    cScrH = newH
end)