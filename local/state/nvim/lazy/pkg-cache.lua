return {pkgs={{name="noice.nvim",file="lazy.lua",dir="/root/.local/share/nvim/lazy/noice.nvim",spec=function()
return {
  -- nui.nvim can be lazy loaded
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "folke/noice.nvim",
  },
}

end,source="lazy",},{name="nvim-dap-python",file="nvim-dap-python-scm-1.rockspec",dir="/root/.local/share/nvim/lazy/nvim-dap-python",spec={"nvim-dap-python",specs={{"mfussenegger/nvim-dap",},},build=false,},source="rockspec",},{name="plenary.nvim",file="community",dir="/root/.local/share/nvim/lazy/plenary.nvim",spec={"nvim-lua/plenary.nvim",lazy=true,},source="lazy",},},version=12,}