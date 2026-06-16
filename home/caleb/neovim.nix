{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = false;
    withRuby = false;

    extraPackages = with pkgs; [
      # LSP servers
      lua-language-server
      clang-tools
      typescript-language-server
      vscode-langservers-extracted
      bash-language-server
      haskell-language-server
      pyright
      nixd
      omnisharp-roslyn

      # Formatters (called by conform.nvim)
      stylua
      prettier
      shfmt
      haskellPackages.fourmolu
      python3Packages.black
      nixpkgs-fmt
      csharpier
    ];

    # was lua/config/*
    initLua = /* lua */ ''
            -- leader keys
            vim.g.mapleader = " "
            vim.g.maplocalleader = "\\"

            ------------------------------------------------------------------
            -- options (was lua/config/options.lua)
            ------------------------------------------------------------------
            local opt = vim.opt

            opt.number = true

            opt.expandtab = true
            opt.tabstop = 2
            opt.softtabstop = 2
            opt.shiftwidth = 2

            opt.guicursor = "n-v-c:block,i:blinkon100-blinkoff100-blinkwait100"

            opt.clipboard = "unnamedplus"

            opt.colorcolumn = "100"

            opt.ignorecase = true
            opt.smartcase = true

            ------------------------------------------------------------------
            -- keymaps (was lua/config/keymaps.lua)
            ------------------------------------------------------------------
            local km = vim.keymap

            -- escape to exit terminal mode
            vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

            -- window navigation
            km.set("n", "<C-h>", "<C-w>h")
            km.set("n", "<C-j>", "<C-w>j")
            km.set("n", "<C-k>", "<C-w>k")
            km.set("n", "<C-l>", "<C-w>l")

            vim.g.netrw_winsize = 25
            vim.g.netrw_banner = 0
            vim.g.netrw_sizestyle = "H"
      vim.g.netrw_liststyle = 1

            local function open_or_focus_netrw()
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].filetype == "netrw" then
                  vim.api.nvim_set_current_win(win)
                  return
                end
              end
              vim.cmd("Lex")
            end

            local function open_or_focus_terminal()
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].buftype == "terminal" then
                  vim.api.nvim_set_current_win(win)
                  return
                end
              end
              vim.cmd("botright split")
              vim.cmd("terminal")
              vim.cmd("resize 12")
            end

            local function focus_file()
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].filetype ~= "netrw" and vim.bo[buf].buftype ~= "terminal" then
                  vim.api.nvim_set_current_win(win)
                  return
                end
              end
              vim.cmd("botright vsplit | enew")
            end

            local function reset_layout()
              vim.cmd("silent! only")
              vim.cmd("enew")
              vim.cmd("botright split")
              vim.cmd("terminal")
              vim.cmd("resize 12")
              vim.cmd("wincmd k")
              vim.cmd("Lex")
            end

            km.set("n", "<leader>e", open_or_focus_netrw)
            km.set("n", "<leader>t", open_or_focus_terminal)
            km.set("n", "<leader>f", focus_file)
            km.set("n", "<leader>`", reset_layout)

            ------------------------------------------------------------------
            -- autocmds (was lua/config/autocmds.lua)
            ------------------------------------------------------------------
            -- fix C-hjkl in netrw
            vim.api.nvim_create_autocmd("FileType", {
              pattern = "netrw",
              callback = function()
                km.set("n", "<C-h>", "<C-w>h", { buffer = true })
                km.set("n", "<C-j>", "<C-w>j", { buffer = true })
                km.set("n", "<C-k>", "<C-w>k", { buffer = true })
                km.set("n", "<C-l>", "<C-w>l", { buffer = true })
              end,
            })
    '';

    # was lua/plugins/*
    plugins = with pkgs.vimPlugins; [
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = /* lua */ ''
          require("catppuccin").setup({})
          vim.cmd.colorscheme("catppuccin")
        '';
      }

      {
        plugin = lualine-nvim;
        type = "lua";
        config = /* lua */ ''
          require("lualine").setup({
            options = {
              icons_enabled = true,
              theme = "auto",
              component_separators = { left = "", right = "" },
              section_separators = { left = "", right = "" },
            },
          })
        '';
      }

      # lualine icons
      nvim-web-devicons

      markdown-preview-nvim

      {
        plugin = nvim-treesitter.withPlugins (p: with p; [
          lua
          nix
          bash
          c
          cpp
          python
          haskell
          typescript
          javascript
          css
          html
          json
        ]);
        type = "lua";
        config = /* lua */ ''
          require("nvim-treesitter.configs").setup({
            highlight = { enable = true },
            indent = { enable = true },
          })
        '';
      }

      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = /* lua */ ''
          -- nvim-lspconfig ships lsp/<server>.lua configs that vim.lsp.enable
          -- consumes (Neovim 0.11+ native LSP). Server binaries come from
          -- programs.neovim.extraPackages above.
          vim.lsp.config("*", {
            capabilities = {
              workspace = {
                didChangeWatchedFiles = {
                  dynamicRegistration = true,
                },
              },
            },
          })

          vim.lsp.config("lua_ls", {
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
              },
            },
          })

          vim.lsp.enable({
            "lua_ls",
            "clangd",
            "ts_ls",
            "cssls",
            "html",
            "bashls",
            "hls",
            "pyright",
            "jsonls",
            "nixd",
            "omnisharp",
          })

          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
              local opts = { buffer = event.buf }
              vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
              vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
              vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
              vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
              vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
              vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
            end,
          })
        '';
      }

      {
        plugin = fidget-nvim;
        type = "lua";
        config = /* lua */ ''
          require("fidget").setup({})
        '';
      }

      {
        plugin = conform-nvim;
        type = "lua";
        config = /* lua */ ''
          require("conform").setup({
            formatters_by_ft = {
              lua = { "stylua" },
              c = { "clang_format" },
              cpp = { "clang_format" },
              javascript = { "prettier" },
              typescript = { "prettier" },
              css = { "prettier" },
              html = { "prettier" },
              json = { "prettier" },
              sh = { "shfmt" },
              haskell = { "fourmolu" },
              python = { "black" },
              nix = { "nixpkgs_fmt" },
              cs = { "csharpier" },
            },
            format_on_save = {
              timeout_ms = 500,
              lsp_fallback = true,
            },
          })
        '';
      }
    ];
  };
}
