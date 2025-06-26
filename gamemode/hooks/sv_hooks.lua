function GM:PlayerSpray(client)
    return true
end

function GM:PlayerShouldTaunt(client, act)
    return false
end

function GM:CanPlayerSuicide(client)
    return false
end

function GM:PlayerDeathThink(client)
    return false
end

gameevent.Listen("OnRequestFullUpdate")
function GM:OnRequestFullUpdate(data)
    Player(data.userid):KillSilent()
end