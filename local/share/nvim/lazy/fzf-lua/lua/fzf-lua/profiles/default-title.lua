local function title(str, opts)
  return vim.tbl_deep_extend("keep", opts or {},
    {
      winopts = {
        -- title = { { " " .. str .. " ", "IncSearch" } },
        title = " " .. str .. " ",
      }
    })
end
return {
  desc                 = "defaults using title instead of prompt",
  defaults             = { prompt = false },
  winopts              = { title_pos = "center" },
  files                = title("Files"),
  buffers              = title("Buffers"),
  tabs                 = title("Tabs"),
  lines                = title("Lines"),
  blines               = title("Buffer Lines"),
  treesitter           = title("Treesitter"),
  grep                 = title("Grep"),
  grep_curbuf          = title("Buffer Grep"),
  git                  = {
    files    = title("Git Files"),
    status   = title("Git Status"),
    commits  = title("Git Commits"),
    bcommits = title("Git BCommits"),
    blame    = title("Git Blame"),
    branches = title("Git Branches"),
    stash    = title("Git Stash"),
  },
  args                 = title("Args"),
  oldfiles             = title("Oldfiles"),
  quickfix             = title("Quickfix List"),
  quickfix_stack       = title("Quickfix List Stack"),
  loclist              = title("Location List"),
  loclist_stack        = title("Location List Stack"),
  tags                 = title("Tags"),
  btags                = title("Buffer Tags"),
  colorschemes         = title("Colorschemes"),
  awesome_colorschemes = title("Awesome Colorschemes"),
  highlights           = title("Highlights"),
  helptags             = title("Neovim Help"),
  manpages             = title("Man Pages"),
  lsp                  = {
    title_prefix = "LSP",
    symbols      = { title_prefix = "LSP" },
    finder       = title("LSP Finder"),
    code_actions = title("Code Actions"),
  },
  diagnostics          = title("Diagnostics"),
  builtin              = title("FzfLua Builtin"),
  profiles             = title("FzfLua Profiles"),
  marks                = title("Marks"),
  jumps                = title("Jumps"),
  tagstack             = title("Tagstack"),
  commands             = title("Commands"),
  autocmds             = title("Autocmds"),
  command_history      = title("Command history"),
  search_history       = title("Search history"),
  registers            = title("Registers"),
  keymaps              = title("Keymaps"),
  spell_suggest        = title("Spell Suggestions"),
  filetypes            = title("Filetypes"),
  packadd              = title("Packer Packadd"),
  menus                = title("Menus"),
  tmux                 = title("Tmux Buffers"),
  dap                  = {
    commands       = title("DAP Commands"),
    configurations = title("DAP Configurations"),
    variables      = title("DAP Variables"),
    frames         = title("DAP Frames"),
    breakpoints    = title("DAP Breakpoints"),
  },
}