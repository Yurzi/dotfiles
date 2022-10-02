local colorscheme = 'sonokai';
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme);
if not status_ok then
    vim.notify('colorscheme ' .. colorscheme .. 'not found !');
    return;
end

vim.g.sonokai_better_performance = 1;
vim.g.sonokai_enable_italic = 1;
