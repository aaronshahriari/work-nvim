return {
  "xixiaofinland/sf.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "ibhagwan/fzf-lua",
  },

  config = function()
    require('sf').setup({
      enable_hotkeys = false,
      default_dir = '/force-app/main/default/',
      hotkeys_in_filetypes = {
        "apex", "sosl", "soql", "cls"
      },
    })

    local function run_sf_commands(command)
      local allowed_extensions = { "apex", "cls", "soql" }
      if not vim.tbl_contains(allowed_extensions, vim.fn.expand('%:e')) then
        print("This command can only be used in Salesforce files.")
        return
      end

      local filepath = vim.fn.expand('%:p')
      local orgs = { "bgTest", "bgMain" }
      vim.ui.select(orgs, {
        prompt = "Choose a Salesforce Org",
      }, function(choice)
        if choice then
          local cmd
          if command == "apex" then
            cmd = string.format("sf apex run -f %s -o %s", filepath, choice)
          elseif command == "soql" then
            cmd = string.format("sf data query -w 5 -f %s -o %s", filepath, choice)
          else
            print("No Command SF Command Input")
            return
          end

          local terminal_buf_id = vim.fn.bufnr('term://*')
          if terminal_buf_id ~= -1 then
            local job_id = vim.b[terminal_buf_id].terminal_job_id
            if job_id then
              vim.fn.chansend(job_id, cmd .. "\n")
            else
              print("Terminal found, but no active terminal job.")
            end
          else
            print("No terminal found. Please open a terminal to run the command.")
          end
        else
          print("No org selected.")
        end
      end)
    end

    vim.keymap.set("n", "<leader>aa", function() run_sf_commands("apex") end)
    vim.keymap.set("n", "<leader>q", function() run_sf_commands("soql") end)

    -- NEED SOMETHING NEW HERE
    -- sf data query -q ~highlighted-query~ -o ~curr_org~
    -- vim.keymap.set("v", "<leader>q", Sf.run_highlighted_soql, { buffer = true, desc = "SOQL run highlighted text" })
    local function highlighted_soql()
      local allowed_extensions = { "soql" }
      if not vim.tbl_contains(allowed_extensions, vim.fn.expand('%:e')) then
        print("This command can only be used in Salesforce files.")
        return
      end

      local old_reg = vim.fn.getreg('"')
      local old_regtype = vim.fn.getregtype('"')
      vim.cmd('noautocmd normal! "vy"')
      local selected_text = vim.fn.getreg("v")
      selected_text = vim.fn.trim(selected_text)
      local orgs = { "bgTest", "bgMain" }
      vim.ui.select(orgs, {
        prompt = "Choose a Salesforce Org",
      }, function(choice)
        if choice then
          local cmd = string.format("sf data query -q \"%s\" -o %s", selected_text, choice)
          vim.fn.setreg('"', old_reg, old_regtype)

          local terminal_buf_id = vim.fn.bufnr('term://*')
          if terminal_buf_id ~= -1 then
            local job_id = vim.b[terminal_buf_id].terminal_job_id
            if job_id then
              vim.fn.chansend(job_id, cmd .. "\n")
            else
              print("Terminal found, but no active terminal job.")
            end
          else
            print("No terminal found. Please open a terminal to run the command.")
          end
        else
          print("No org selected.")
        end
      end)
    end

    vim.keymap.set("v", "<leader>s", highlighted_soql)
  end
}
