lua << EOF
local ok, markview = pcall(require, "markview")
if ok then
  markview.setup({
    modes = { "n", "no", "c" },
    hybrid_modes = { "n" },
  })
end

local function strip_markdown(text)
  text = text:gsub("%*%*(.-)%*%*", "%1")
  text = text:gsub("%*(.-)%*", "%1")
  text = text:gsub("__(.-)__", "%1")
  text = text:gsub("(%s)_([^_]+)_(%s)", "%1%2%3")
  text = text:gsub("^_([^_]+)_(%s)", "%1%2")
  text = text:gsub("(%s)_([^_]+)_$", "%1%2")
  text = text:gsub("~~(.-)~~", "%1")
  text = text:gsub("`(.-)`", "%1")
  text = text:gsub("%[([^%]]-)%]%(([^%)]+)%)", "%1 (%2)")
  text = text:gsub("^> ", "")
  text = text:gsub("\n> ", "\n")
  text = text:gsub("^#+ ", "")
  text = text:gsub("\n#+ ", "\n")
  return text
end

local function open_link()
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")
  for text, url in line:gmatch("%[([^%]]*)%]%(([^%)]+)%)") do
    local pattern = "%[" .. text:gsub("([%%%]%[%(%)%.%+%-%*%?%^%$])", "%%%1") .. "%]%(" .. url:gsub("([%%%]%[%(%)%.%+%-%*%?%^%$])", "%%%1") .. "%)"
    local start, finish = line:find(pattern)
    if start and col >= start and col <= finish then
      vim.ui.open(url)
      return
    end
  end
  local plain_url = line:match("https?://[%w%.%-%_~:/?#%[%]@!$&'%(%)%*%+,;=%%]+")
  if plain_url then
    vim.ui.open(plain_url)
    return
  end
  local _, first_url = line:match("%[([^%]]*)%]%(([^%)]+)%)")
  if first_url then
    vim.ui.open(first_url)
  end
end

vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  pattern = { "markdown", "*.md" },
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.keymap.set("x", "y", function()
      vim.cmd('normal! "zy')
      local text = vim.fn.getreg("z")
      text = strip_markdown(text)
      vim.fn.setreg("+", text)
      vim.fn.setreg('"', text)
    end, { buffer = true, desc = "Yank stripped markdown" })
  end,
})

vim.api.nvim_create_user_command("MarkviewOpenLink", open_link, {})
vim.api.nvim_create_user_command("MarkviewYank", function(opts)
  local start_line = opts.line1
  local end_line = opts.line2
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local text = table.concat(lines, "\n")
  text = strip_markdown(text)
  vim.fn.setreg("+", text)
  vim.notify("Yanked " .. (end_line - start_line + 1) .. " lines (markdown stripped)", vim.log.levels.INFO)
end, { range = true })
EOF
