-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

-- See the video here: https://www.youtube.com/watch?v=TNRFegMqbWA
-- about this modified Nvchad 2.5 version
-- And the related explanation here:https://github.com/ProgrammingRainbow/NvChad-2.5

---@type ChadrcConfig
local M = {}

-- M.ui = {
--     theme = "bearded-arc",
--     statusline = {
--         separator_style = "arrow",
--         overriden_modules = function()
--           local st_modules = require "nvchad_ui.statusline.default"
--
--           return {
--             fileInfo = function()
--               local fn = vim.fn
--               local sep = "%#St_file_sep#"
--               local str = st_modules.fileInfo()
--               local parts = {}
--               for match in (str..sep):gmatch("(.-)"..sep) do
--                 table.insert(parts, match)
--               end
--               local new_sep_r = string.gsub(parts[2],' %%','')
--               local icon = "  "
--               local filename = (fn.expand "%" == "" and "Empty ") or fn.expand "%:t"
--               local foldername = (fn.expand("%:p:h") == "" and "Empty") or fn.expand("%:p:h:t")
--
--               local modified_indicator = ""
--               if vim.bo.modified then
--                 modified_indicator = " "
--               end
--
--               if filename ~= "Empty " then
--                 local devicons_present, devicons = pcall(require, "nvim-web-devicons")
--
--                 if devicons_present then
--                   local ft_icon = devicons.get_icon(filename)
--                   icon = (ft_icon ~= nil and " " .. ft_icon) or ""
--                 end
--
--                 filename = " " .. foldername .. " -> " .. filename .. modified_indicator .. " "
--               end
--
--               return "%#St_file_info#" .. icon .. filename .. "%#St_file_sep#" .. new_sep_r
--             end
--           }
--         end
--       }
-- }



M.ui = {
    theme = "bearded-arc",
    -- transparency = "true"
    statusline = {
        separator_style = "arrow",
        -- overriden_modules = nil,
        -- theme = "default"
        -- theme = "minimal"
        theme = "vscode_colored"
        -- theme = "vscode"
    }
    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
}

return M
