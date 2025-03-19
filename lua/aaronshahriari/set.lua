-- not allow the mouse
-- vim.o.mouse = ""

vim.opt.guicursor = "a:blinkon0"
-- no block on insert
-- vim.opt.guicursor = "n-v-c:block,i-ci:ver25,r-cr:hor20"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = "80";

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scroll = 25
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.list = true
vim.opt.listchars:append({ tab = '  ', nbsp = ' ', trail = ' ', eol = '↲' })

-- used for obsidian
vim.opt.conceallevel = 1

vim.opt.cursorline = false

-- create terminal config
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
        vim.opt_local.colorcolumn = ""
    end,
})

-- set tabnames
vim.o.showtabline = 1 -- always show the tabline
vim.o.tabline = '%!v:lua.MyTabline()'

-- custom tabline function
function MyTabline()
    local s = ''
    for i = 1, vim.fn.tabpagenr('$') do
        local winnr = vim.fn.tabpagewinnr(i)           -- get the window number for the tab
        local bufnr = vim.fn.tabpagebuflist(i)[winnr]  -- get the buffer for the window
        local bufname = vim.fn.bufname(bufnr)          -- get the buffer name
        local file = vim.fn.fnamemodify(bufname, ':t') -- extract only the file name

        -- -- handle [No Name] as oil tree
        if file == '' then
            file = 'Oil'
        end

        -- highlight the current tab
        if i == vim.fn.tabpagenr() then
            s = s .. '%#TabLineSel# ' .. (file ~= '' and file or '[No Name]') .. ' %#TabLine#'
        else
            s = s .. '%#TabLine# ' .. (file ~= '' and file or '[No Name]') .. ' '
        end
    end
    return s
end

-- setting filetypes
vim.filetype.add({
    extension = {
        cls = 'apex',
        apex = 'apex',
        trigger = 'apex',
        soql = 'soql',
        sosl = 'sosl',
        log = 'sflog',
    }
})

-- set commentstring for a specific filetype
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "apex", "cls" },
    callback = function()
        vim.bo.commentstring = "// %s"
    end,
})
