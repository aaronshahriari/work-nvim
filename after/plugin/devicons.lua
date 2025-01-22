local devicons = require("nvim-web-devicons")

devicons.setup {
  override = {
    -- Add icons for custom filetypes or extensions
    apex = {
      icon = "", -- Choose an icon
      color = "#4287f5", -- Set a color
      name = "apex",
    },
    soql = {
      icon = "󰮆",
      color = "#f242f5",
      name = "soql",
    },
  },
}
