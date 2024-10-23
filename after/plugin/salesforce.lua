require("sf").setup({
    -- Unless you want to customize, no need to copy-paste any of these
    -- They are applied automatically

    -- This plugin has both hotkeys and user commands supplied
    -- This flag enable/disable hotkeys while user commands are always enabled
    enable_hotkeys = false,

    -- Metadata related hotkeys (e.g. push/retrieve Apex) are only enabled in
    -- these filetypes
    hotkeys_in_filetypes = {
        "apex", "sosl", "soql"
    },

    -- Define what metadata to be listed in `list_md_to_retrieve()` (<leader>ml)
    types_to_retrieve = {
        "ApexClass",
        "ApexTrigger",
        "StaticResource",
        "LightningComponentBundle"
    },
})

local Sf = require('sf')
-- remaps
vim.keymap.set("n", "<leader>aa", Sf.run_anonymous)
vim.keymap.set("n", "<C-p>", Sf.toggle_term)
vim.keymap.set("n", "<leader>q", Sf.run_query)
