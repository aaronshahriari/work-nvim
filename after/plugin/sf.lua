-- CREATE BASE COMMANDS FOR SF CLI

-- create a file in .sf/config.json
-- { "target-org": "bgMain/bgSand" }
function File_exists(filename)
  local file = os.rename(filename, filename)
  return file ~= nil
end

vim.api.nvim_create_user_command('SwitchOrg', function()
  if File_exists("sfdx-project.json") then
    print("exists")
    local orgs = {"bgSand", "bgMain"}
    vim.ui.select(orgs, { prompt = 'Select Org:', }, function(selected)
      if selected then
        local local_org = '{ "target-org": "' .. selected .. '" }'
        local file = io.open(".sf/config.json", "w")  -- Open the file in write mode
        if file then
          file:write(local_org)
          file:close()
        else
          print("Error opening file!")
        end
      end
    end)
  else
    print("Not In SF Directory")
  end
end, {})

local job_id = 0
vim.keymap.set("n", "<leader>st", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 12)

  job_id = vim.bo.channel
end)

vim.keymap.set("n", "<leader>t", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("L")

  job_id = vim.bo.channel
end)

-- testing anonymous apex
-- vim.keymap.set("n", "<leader>aa",function()
--   local file_name = vim.fn.expand("%")
--   local apex_cmd = ""
--   vim.fn.chansend(job_id, { apex_cmd })
-- end)

vim.keymap.set("n", "<leader>q",function()
  local file_name = vim.fn.expand("%")
  local query_cmd = "sf data query -f '" .. file_name .. "'\r\n"
  vim.fn.chansend(job_id, { query_cmd })
end)

vim.keymap.set("v", "<leader>q", function()
  local old_reg = vim.fn.getreg('"')
  local old_regtype = vim.fn.getregtype('"')
  vim.cmd('noautocmd normal! "vy"')
  local selection = vim.fn.getreg("v")
  vim.fn.setreg('"', old_reg, old_regtype)
  local query_cmd = "sf data query -q '" .. selection .. "'\r\n"
  vim.fn.chansend(job_id, { query_cmd })
end)
