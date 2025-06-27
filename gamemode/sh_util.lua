--- Utility functions
-- @module SCP.Util
SCP.Util = SCP.Util or {}

--- Prints a debug message to the console.
-- @realm shared
-- @param text string The message to print.
function SCP.Util:Log(text)
    MsgC(color_white, "[SCP: AP :: DEBUG] - " .. text .. "\n")
end

local warningColor = Color(255, 200, 120)

--- Prints a warning message to the console.
-- @realm shared
-- @param text string The message to print.
function SCP.Util:LogWarning(text)
    MsgC(warningColor, "[SCP: AP :: WARNING] - " .. text .. "\n")
end

local errorColor = Color(255, 120, 120)

--- Prints a error message to the console.
-- @realm shared
-- @param text string The message to print.
function SCP.Util:LogError(text)
    MsgC(errorColor, "[SCP: AP :: ERROR] - " .. text .. "\n")
end

--- Includes a file based on the realm.
-- @realm shared
-- @param path string The path to the file.
-- @param realm string The realm to include the file in.
function SCP.Util:Include(path, realm)
    if ( !isstring(path) ) then
        self:LogError("Failed to include file " .. path .. "!", SCP_LOG_ERROR)
        return
    end

    if ( ( realm == "server" or path:find("sv_") ) and SERVER ) then
        include(path)
        self:Log("Included file " .. path .. ".")
    elseif ( realm == "shared" or path:find("shared.lua") or path:find("sh_") ) then
        if ( SERVER ) then
            AddCSLuaFile(path)
        end

        include(path)
        self:Log("Included file " .. path .. ".")
    elseif ( realm == "client" or path:find("cl_") ) then
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
        self:LogError("Failed to include directory " .. directory .. "!", SCP_LOG_ERROR)
        return
    end

    local dir = debug.getinfo(2).source
    dir = dir:sub(2, dir:find("/[^/]*$")):gsub("gamemodes/", "") .. directory

    if ( !file.Exists(dir, "LUA") ) then
        self:LogError("Failed to include directory " .. dir .. "!", SCP_LOG_ERROR)
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