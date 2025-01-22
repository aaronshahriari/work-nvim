require("obsidian").setup({
  workspaces = {
    {
      name = "Personal",
      path = "~/../../mnt/c/Users/AaronShahriari/Aaron_Vault",
    },
    {
      name = "Brundage Group",
      path = "~/../../mnt/c/Users/AaronShahriari/BrundageGroup",
    },
  },
  disable_frontmatter = true,
  ui = {
    enable = true,         -- set to false to disable all additional syntax features
    update_debounce = 200, -- update delay after a text change (in milliseconds)
    -- Define how various check-boxes are displayed
    checkboxes = {
      [" "] = { char = "", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
      [">"] = { char = "", hl_group = "ObsidianRightArrow" },
      ["<"] = { char = "", hl_group = "ObsidianRightArrow" },
      ["~"] = { char = "󰜺", hl_group = "ObsidianTilde" },
    },
  },
  open_app_foreground = false,
  open_notes_in = "hsplit",
  callbacks = {
    -- Runs anytime you enter the buffer for a note.
    enter_note = function(client, note)
      vim.cmd(":silent ObsidianOpen")
    end,
  },
  daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    folder = "BrundageGroup/Dailies",
    -- Optional, if you want to change the date format for the ID of daily notes.
    date_format = "%Y-%m-%d",
    -- Optional, if you want to change the date format of the default alias of daily notes.
    alias_format = "Todo",
    -- Optional, default tags to add to each new daily note created.
    default_tags = { "daily-notes" },
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = nil
  },
})
vim.keymap.set("n", "gf", function()
  if require("obsidian").util.cursor_on_markdown_link() then
    return "<cmd>ObsidianFollowLink<CR>"
  else
    return "gf"
  end
end, { noremap = false, expr = true })
