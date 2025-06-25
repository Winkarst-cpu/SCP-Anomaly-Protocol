SCP.Util = SCP.Util or {}

SCP_LOG_DEBUG = 1
SCP_LOG_WARNING = 2
SCP_LOG_ERROR = 3

local logTypes = {
    [SCP_LOG_DEBUG] = { "DEBUG", color_white },
    [SCP_LOG_WARNING] = { "WARNING", Color(255, 255, 0) },
    [SCP_LOG_ERROR] = { "ERROR", Color(255, 0, 0) },
}

-- Inspired by Parallax Framework.
--- Prints a message to the console.
-- @realm shared
-- @param text string The message to print.
-- @param logType number The type of the log. Can be left empty.
function SCP.Util:Log(text, logType)
    logType = logTypes[logType] or logTypes[SCP_LOG_DEBUG]

    MsgC(logType[2], "[SCP: AP :: " .. logType[1] .. "] - " .. text .. "\n")
end

-- Inspired by Parallax Framework.
--- Includes a file based on the realm.
-- @realm shared
-- @param path string The path to the file.
-- @param realm string The realm to include the file in.
function SCP.Util:Include(path, realm)
    if ( !isstring(path) or !file.Exists(path, "LUA") ) then
        self:Log("Failed to include file " .. path .. "!", SCP_LOG_ERROR)
        return
    end

    if ( ( realm == "server" or string.find(path, "sv_") ) and SERVER ) then
        include(path)
    elseif ( realm == "shared" or string.find(path, "shared.lua") or string.find(path, "sh_") ) then
        if ( SERVER ) then
            AddCSLuaFile(path)
        end

        include(path)
    elseif ( realm == "client" or string.find(path, "cl_") ) then
        if ( SERVER ) then
            AddCSLuaFile(path)
        else
            include(path)
        end
    end
end

-- Inspired by Parallax Framework.
--- Includes all files in a folder based on the realm.
-- @realm shared
-- @param directory string The directory to include the files from.
-- @param bFromLua boolean Whether or not the files are being included from Lua.
function SCP.Util:IncludeFolder(directory, bFromLua)
    if ( !isstring(directory) ) then
        self:Log("Failed to include directory " .. directory .. "!", SCP_LOG_ERROR)
        return
    end

    local baseDir = ""

    if ( !bFromLua ) then
        baseDir = debug.getinfo(2).source
        baseDir = baseDir:sub(2, baseDir:find("/[^/]*$")):gsub("gamemodes/", "")
    end

    local files = file.Find(baseDir .. directory .. "/*.lua", "LUA")
    for i = 1, #files do
        self:Include(baseDir .. directory .. "/" .. files[i])
    end

    return true
end