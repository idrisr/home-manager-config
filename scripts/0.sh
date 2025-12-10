#!/usr/bin/env bash
LOG=$(mktemp)

nvim --headless -c 'lua << EOF
local warned=false
local old_notify=vim.notify
vim.notify=function(msg,level,opts)
  if level==vim.log.levels.WARN then
    io.stderr:write("[WARN] "..msg.."\n")
    warned=true
  end
  old_notify(msg,level,opts)
end
vim.api.nvim_create_autocmd("VimEnter",{callback=function()
  if warned then os.exit(1) else os.exit(0) end
end})
EOF' +qall 2>"$LOG"

cat "$LOG"
rc=$?
rm "$LOG"
exit $rc
