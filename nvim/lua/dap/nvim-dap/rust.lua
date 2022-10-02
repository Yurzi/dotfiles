local mason_packages_path = vim.fn.stdpath("data") .. "\\mason\\package\\"
local codelldb_path = mason_packages_path .. "codelldb\\extension\\adapter\\codelldb.exe"
local liblldb_path = mason_packages_path .. "codelldb\\extension\\lldb\\lib\\liblldb.lib"

return {
  adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
}
