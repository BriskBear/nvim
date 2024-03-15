local keymap = vim.keymap

-- [[ Basic Keymaps ]]
keymap.set('i', 'kj', '<esc>',                                         { desc = 'Home Row Escape, No more Vim-Pinkey!' })
keymap.set('n', '<C-x>', ':q<CR>',                                     { desc = 'Ctrl-x to quit, like nano' })
keymap.set('n', '<C-s>', ':w<CR>',                                     { desc = 'Ctrl-x to quit, like nano' })
keymap.set({ 'i','n' }, '<C-l>', ':Format<CR>:echo "AutoFormat!"<CR>', { desc = 'Auto [F]ormat' })
keymap.set('n', '<leader>q', ':qa!<CR>',                               { desc = '[Q]uit all without saving' })
keymap.set('n', '<leader>r', ':source /etc/xdg/nvim/init.lua<CR>',     { desc = '[R]eload Config' })
keymap.set('n', '<M-p>', ':set list!<CR>',                             { desc = 'Move tab [Left]' })
keymap.set('n', '<C-Left>', ':-tabmove<CR>',                           { desc = 'Move tab [Left]' })
keymap.set('n', '<C-Right>', ':+tabmove<CR>',                          { desc = 'Move tab [Right]' })
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>',                           { silent = true }) -- Keymaps for better default experience
keymap.set('n', 'k', "v:count == -1 ? 'gk' : 'k'",                     { expr = true, silent = true })
keymap.set('n', 'j', "v:count == -1 ? 'gj' : 'j'",                     { expr = true, silent = true }) -- Remap for dealing with word wrap
keymap.set({ 'n', 'x' }, 'ga', '<Plug>(EasyAlign)',                    { desc = 'Enable EasyAlign' })
keymap.set('n', 'D', 'gg$vT:x:r!date -u +\\%s<CR>kJ:w<CR>',                     { desc = 'Timestamp Header' })
vim.cmd('vmap <M-A> gaip*<c-X>') -- Visual Select regex align

-- [[ TabOpen Config files ]]
keymap.set('n', '<leader>init', ':execute "tabfind " .. $XH .. "/" .. "nvim/init.lua"<CR>',           { desc = 'Edit [init].lua' })
keymap.set('n', '<leader>bra', ':execute "tabfind " .. $XH .. "/" .. "nvim/legacy/brackets.vim"<CR>', { desc = 'Edit [bra]ckets' })
keymap.set('n', '<leader>key', ':execute "tabfind " .. $XH .. "/" .. "nvim/lua/keymap.lua"<CR>',      { desc = 'Edit [key]map' })
keymap.set('n', '<leader>col', ':tabfind $HOME/.local/share/nvim/lazy/onedark.nvim/<CR>',             { desc = 'Edit [col]ors' })

-- [[ Case Manipulation ]]
keymap.set('v', 'cc', ':Camelize<CR>', { desc = 'Convert snake_case to [C]amel[C]ase' })
keymap.set('v', 'sc', ':Snakeize<CR>', { desc = 'Convert CamelCase to [s]nake_[c]ase' })

-- [[ Comments ]]
keymap.set({ 'i','n' }, '<C-_>', '<esc>:call ToggleComment()<CR>', { desc = 'Comment [/] Un-comment a line' })
