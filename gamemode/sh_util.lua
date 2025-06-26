--- Utility functions
-- @module SCP.Util
SCP.Util = SCP.Util or {}

SCP_LOG_DEBUG = 1
SCP_LOG_WARNING = 2
SCP_LOG_ERROR = 3

local logTypes = {
    [SCP_LOG_DEBUG] = { "DEBUG", color_white },
    [SCP_LOG_WARNING] = { "WARNING", Color(255, 200, 120) },
    [SCP_LOG_ERROR] = { "ERROR", Color(255, 120, 120) },
}

--- Prints a message to the console.
-- @realm shared
-- @param text string The message to print.
-- @param logType number The type of the log. Defaults to debug.
function SCP.Util:Log(text, logType)
    logType = logTypes[logType] or logTypes[SCP_LOG_DEBUG]

    MsgC(logType[2], "[SCP: AP :: " .. logType[1] .. "] - " .. text .. "\n")
end

SCP_REALM_SERVER = 1
SCP_REALM_SHARED = 2
SCP_REALM_CLIENT = 3

--- Includes a file based on the realm.
-- @realm shared
-- @param path string The path to the file.
-- @param realm string The realm to include the file in.
function SCP.Util:Include(path, realm)
    if ( !isstring(path) ) then
        self:Log("Failed to include file " .. path .. "!", SCP_LOG_ERROR)
        return
    end

    if ( ( realm == SCP_REALM_SERVER or path:find("sv_") ) and SERVER ) then
        include(path)
        self:Log("Included file " .. path .. ".")
    elseif ( realm == SCP_REALM_SHARED or path:find("shared.lua") or path:find("sh_") ) then
        if ( SERVER ) then
            AddCSLuaFile(path)
        end

        include(path)
        self:Log("Included file " .. path .. ".")
    elseif ( realm == SCP_REALM_CLIENT or path:find("cl_") ) then
        if ( SERVER ) then
            AddCSLuaFile(path)
        else
            include(path)
            self:Log("Included file " .. path .. ".")
        end
    end
end

--- Includes all files in a folder.
-- @realm shared
-- @param directory string The directory to include the files from.
-- @param realm string The realm to include files in.
function SCP.Util:IncludeFolder(directory, realm)
    if ( !isstring(directory) ) then
        self:Log("Failed to include directory " .. directory .. "!", SCP_LOG_ERROR)
        return
    end

    local dir = debug.getinfo(2).source
    dir = dir:sub(2, dir:find("/[^/]*$")):gsub("gamemodes/", "") .. directory

    if ( !file.Exists(dir, "LUA") ) then
        self:Log("Failed to include directory " .. dir .. "!", SCP_LOG_ERROR)
        return
    end

    local files, directories = file.Find(dir .. "/*.lua", "LUA")
    for i = 1, #files do
        self:Include(dir .. "/" .. files[i], realm)
    end

    for i = 1, #directories do
        self:IncludeFolder(dir .. "/" .. directories[i], realm)
    end

    self:Log("Included directory " .. dir .. ".")
end