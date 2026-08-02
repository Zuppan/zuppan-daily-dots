-- This script instantly kicks images out of the playlist as they load
local function scrub_playlist(event)
    local total_files = mp.get_property_number("playlist-count", 0)
    local i = 0
    while i < total_files do
        local path = mp.get_property("playlist/" .. i .. "/filename")
        if path then
            local ext = path:lower():match("%.([^.]+)$")
            -- Check if the extension is an image
            if ext == "jpg" or ext == "jpeg" or ext == "png" or ext == "gif" or ext == "webp" or ext == "bmp" then
                mp.commandv("playlist-remove", i)
                total_files = total_files - 1 -- Adjust count for the deleted file
            else
                i = i + 1
            end
        else
            i = i + 1
        end
    end
end

-- Trigger the scrub whenever files are dropped or loaded
mp.register_event("start-file", scrub_playlist)
