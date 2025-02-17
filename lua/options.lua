require "nvchad.options"
if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.o.shell = "powershell.exe"
end
