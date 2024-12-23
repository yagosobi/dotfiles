local map = vim.keymap.set

vim.cmd([[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]]) -- h/t https://jeffkreeftmeijer.com/vim-number/

-- keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "scroll up and center" })

-- save and quit
map({ "n", "v", "i" }, "<C-S>", "<C-c>:update<cr>", { desc = "save" })
map("n", "<leader>q", ":q<cr>", { desc = "quit" })

-- keep matches center screen when cycling with n|n
map("n", "n", "nzzzv", { desc = "Fwd  search '/' or '?'" })
map("n", "N", "Nzzzv", { desc = "Back search '/' or '?'" })

-- move selected lines up/down in visual mode
map("x", "<C-k>", ":move '<-2<CR>gv=gv", {})
map("x", "<C-j>", ":move '>+1<CR>gv=gv", {})

-- search and replace
map("n", "c.", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "search and replace word under cursor" })
map("n", "c>", [[:%s/\V<C-r><C-a>//g<Left><Left>]], { desc = "search and replace WORD under cursor" })

-- turn off search matches with double-<esc>
map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-- keep visual selection when (de)indenting
map("v", "<", "<gv", {})
map("v", ">", ">gv", {})

-- create new lines in Normal mode
map("n", "<leader>o", "o<Esc>^Da<Esc>k", { desc = "newline below", silent = true })
map("n", "<leader>O", "O<Esc>^Da<Esc>j", { desc = "newline above", silent = true })

-- without yanking
map({ "n", "v" }, "<leader>c", [["_c]], { desc = "change without register" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete without register" })
map("v", "<leader>p", [["_dP]], { desc = "paste without register" })

-- disable ex mode and remap recording
map("n", "Q", "<nop>", {})
map("n", "q", "<nop>", {})
map("n", "<C-q>", "q", {})
