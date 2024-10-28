return {
  "nvimdev/dashboard-nvim",
  opts = function(_, opts)
    local logo = [[
       ██╗   ██╗██╗   ██╗██████╗ ███████╗██╗          Z
       ╚██╗ ██╔╝██║   ██║██╔══██╗╚══███╔╝██║      Z    
        ╚████╔╝ ██║   ██║██████╔╝  ███╔╝ ██║   z       
         ╚██╔╝  ██║   ██║██╔══██╗ ███╔╝  ██║ z         
          ██║   ╚██████╔╝██║  ██║███████╗██║           
          ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝           
  ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    opts.config.header = vim.split(logo, "\n")
    local projects = {
      action = pick,
      desc = " Projects",
      icon = " ",
      key = "p",
    }
    projects.desc = projects.desc .. string.rep(" ", 43 - #projects.desc)
    projects.key_format = "  %s"

    table.insert(opts.config.center, 3, projects)
  end,
}
