function GM:InitPostEntity()
    self.cachedClient = LocalPlayer()
end

function GM:HUDShouldDraw()
    return false
end