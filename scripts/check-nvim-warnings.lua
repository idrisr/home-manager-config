local wait_ms = tonumber(vim.env.CHECK_NVIM_WARNINGS_WAIT_MS) or 2500

local function trim(s)
  if not s then
    return ''
  end
  return (s:gsub('^%s+', ''):gsub('%s+$', ''))
end

local function read_messages()
  if vim.api.nvim_exec2 then
    local ok, res = pcall(vim.api.nvim_exec2, 'messages', { output = true })
    if ok and res and res.output then
      return res.output
    end
  end
  local ok, res = pcall(vim.api.nvim_command_output, 'messages')
  if ok and res then
    return res
  end
  return ''
end

local notified = {}
do
  local orig_notify = vim.notify
  local levels = vim.log.levels
  vim.notify = function(msg, level, opts)
    level = level or levels.INFO
    if level >= levels.WARN then
      table.insert(
        notified,
        string.format('[notify][%s] %s', tostring(level), tostring(msg))
      )
    end
    return orig_notify(msg, level, opts)
  end
end

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    vim.defer_fn(function()
      local findings = {}
      local function add(label, value)
        value = trim(value)
        if value ~= '' then
          table.insert(findings, string.format('[%s] %s', label, value))
        end
      end

      add('warningmsg', vim.v.warningmsg)
      add('errmsg', vim.v.errmsg)
      add('messages', read_messages())

      if #notified > 0 then
        for _, entry in ipairs(notified) do
          add('notify', entry)
        end
      end

      local ok_notify, notify = pcall(require, 'notify')
      if ok_notify and notify and type(notify.history) == 'function' then
        local history = notify.history()
        if history and type(history) == 'table' then
          local levels = vim.log.levels
          for _, item in ipairs(history) do
            local level = item.level or item.level_number or item[2]
            local message = item.message or item[1]
            if level and message then
              if type(message) == 'table' then
                message = table.concat(message, '\n')
              end
              if type(level) == 'string' then
                local upper = level:upper()
                if levels[upper] then
                  level = levels[upper]
                end
              end
              if type(level) == 'number' and level >= levels.WARN then
                add('notify-history', message)
              end
            end
          end
        end
      end

      if #findings > 0 then
        io.stderr:write(table.concat(findings, '\n') .. '\n')
        pcall(vim.cmd, 'cquit 1')
      else
        pcall(vim.cmd, 'cquit 0')
      end
    end, wait_ms)
  end,
})
