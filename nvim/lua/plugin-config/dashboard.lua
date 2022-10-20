local status, db = pcall(require, "dashboard")
if not status then
  vim.notify("dashboard not found!")
  return
end

db.hide_statusline = false

db.custom_footer = {
  "",
  "",
  "https://blog.yurzi.net",
}

db.custom_center = {
  {
    icon = "  ",
    desc = "Projects                            ",
    action = "Telescope projects",
  },
  {
    icon = "  ",
    desc = "Recently files                      ",
    action = "Telescope oldfiles",
  },
  {
    icon = "  ",
    desc = "Edit keybindings                    ",
    action = "edit ~/Appdata/Local/nvim/lua/keybindings.lua",
  },
  {
    icon = "  ",
    desc = "Edit Projects                       ",
    action = "edit ~/Appdata/Local/nvim-data/project_nvim/project_history",
  },
  -- {
  --   icon = '  ',
  --   desc = 'Edit .bashrc                        ',
  --   action = 'edit ~/.bashrc',
  -- },
  -- {
  --   icon = '  ',
  --   desc = 'Change colorscheme                  ',
  --   action = 'ChangeColorScheme',
  -- },
  -- {
  --   icon = '  ',
  --   desc = 'Edit init.lua                       ',
  --   action = 'edit ~/.config/nvim/init.lua',
  -- },
  -- {
  --   icon = '  ',
  --   desc = 'Find file                           ',
  --   action = 'Telescope find_files',
  -- },
  -- {
  --   icon = '  ',
  --   desc = 'Find text                           ',
  --   action = 'Telescopecope live_grep',
  -- },
}

db.custom_header = {
  "",
  "",
  "██╗   ██╗██╗   ██╗██████╗ ███████╗██╗",
  "╚██╗ ██╔╝██║   ██║██╔══██╗╚══███╔╝██║",
  " ╚████╔╝ ██║   ██║██████╔╝  ███╔╝ ██║",
  "  ╚██╔╝  ██║   ██║██╔══██╗ ███╔╝  ██║",
  "   ██║   ╚██████╔╝██║  ██║███████╗██║",
  "   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝",
  "                                     ",
  "",
  "",
}
