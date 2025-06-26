function GM:InitPostEntity()
    SCP.cachedClient = LocalPlayer()
end

function GM:HUDShouldDraw(name)
    return name == "NetGraph"
end