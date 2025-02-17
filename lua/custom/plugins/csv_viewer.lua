return {
  "hat0uma/csvview.nvim",
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    parser = {
      async_chunksize = 50,
      delimiter = {
        default = ",",
        ft = {
          tsv = "\t",
        },
      },
      quote_char = '"',
      comments = {},
    },
    view = {
      min_column_width = 5,
      spacing = 2,
      display_mode = "border",
    },
    keymaps = {
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },
      jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
      jump_next_row = { "<Enter>", mode = { "n", "v" } },
      jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
    },
  },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  config = function()
    -- Check the file type and only load the plugin for .csv and .txt files
    local ft = vim.bo.filetype
    if ft ~= "csv" and ft ~= "txt" then
      return
    end

    -- Enable CsvView for allowed file types
    vim.cmd("CsvViewEnable")
  end,
}
