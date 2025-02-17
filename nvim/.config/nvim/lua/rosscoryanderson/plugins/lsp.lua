return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    require("conform").setup({
      formatters_by_ft = {
      }
    })
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup({
      ensure_installed = {
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
      }
    })
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        -- "gopls",
        "jsonls",
        "sqlls",
        "yamlls",
        "bashls",
        "dockerls",
        "html",
        "cssls",
        "marksman",
        "lexical",
        "graphql",
        "eslint",
        "tailwindcss",
        "svelte",

      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = "capabilities",
          }
        end,

        zls = function()
          local lspconfig = require("lspconfig")
          lspconfig.zls.setup({
            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
            settings = {
              zls = {
                enable_inlay_hints = true,
                enable_snippets = true,
                warn_style = true,
              },
            },
          })
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave = 0
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,
        ["rust_analyzer"] = function()
          local lspconfig = require("lspconfig")
          local util = require 'lspconfig.util'
          local async = require 'lspconfig.async'

          local function is_library(fname)
            local user_home = vim.fs.normalize(vim.env.HOME)
            local cargo_home = os.getenv 'CARGO_HOME' or user_home .. '/.cargo'
            local registry = cargo_home .. '/registry/src'
            local git_registry = cargo_home .. '/git/checkouts'

            local rustup_home = os.getenv 'RUSTUP_HOME' or user_home .. '/.rustup'
            local toolchains = rustup_home .. '/toolchains'

            for _, item in ipairs { toolchains, registry, git_registry } do
              if util.path.is_descendant(item, fname) then
                local clients = util.get_lsp_clients { name = 'rust_analyzer' }
                return #clients > 0 and clients[#clients].config.root_dir or nil
              end
            end
          end

          lspconfig.rust_analyzer.setup({
            cmd = { 'rust-analyzer' },
            filetypes = { 'rust' },
            single_file_support = true,
            root_dir = function(fname)
              local reuse_active = is_library(fname)
              if reuse_active then
                return reuse_active
              end

              local cargo_crate_dir = util.root_pattern 'Cargo.toml' (fname)
              local cargo_workspace_root

              if cargo_crate_dir ~= nil then
                local cmd = {
                  'cargo',
                  'metadata',
                  '--no-deps',
                  '--format-version',
                  '1',
                  '--manifest-path',
                  cargo_crate_dir .. '/Cargo.toml',
                }

                local result = async.run_command(cmd)

                if result and result[1] then
                  result = vim.json.decode(table.concat(result, ''))
                  if result['workspace_root'] then
                    cargo_workspace_root = vim.fs.normalize(result['workspace_root'])
                  end
                end
              end

              return cargo_workspace_root
                  or cargo_crate_dir
                  or util.root_pattern 'rust-project.json' (fname)
                  or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
            end,
            capabilities = {
              experimental = {
                serverStatusNotification = true,
              },
            },
            before_init = function(init_params, config)
              -- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
              if config.settings and config.settings['rust-analyzer'] then
                init_params.initializationOptions = config.settings['rust-analyzer']
              end
            end,
          })
        end,
        ["sqlls"] = function()
          local lspconfig = require("lspconfig")
          local util = require 'lspconfig.util'

          lspconfig.sqlls.setup({
            cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
            filetypes = { 'sql', 'mysql' },
            root_dir = util.root_pattern '.sqllsrc.json',
            settings = {},
          })
        end,
        ["jsonls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.jsonls.setup({
            cmd = { 'vscode-json-language-server', '--stdio' },
            filetypes = { 'json', 'jsonc' },
            init_options = {
              provideFormatter = true,
            },
            root_dir = function(fname)
              return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
            end,
            single_file_support = true,
          })
        end,
        ["yamlls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.yamlls.setup({
            cmd = { 'yaml-language-server', '--stdio' },
            filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
            root_dir = function(fname)
              return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
            end,
            single_file_support = true,
            settings = {
              -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
              redhat = { telemetry = { enabled = false } },
            },
          })
        end,
        ["dockerls"] = function()
          local lspconfig = require("lspconfig")
          local util = require("lspconfig.util")

          lspconfig.dockerls.setup({
            cmd = { 'docker-langserver', '--stdio' },
            filetypes = { 'dockerfile' },
            root_dir = util.root_pattern 'Dockerfile',
            single_file_support = true,
          })
        end,
        ["html"] = function()
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true

          require 'lspconfig'.html.setup {
            capabilities = capabilities,
          }
        end,
        ["cssls"] = function()
          local lspconfig = require("lspconfig")
          local util = require("lspconfig.util")
          lspconfig.cssls.setup({
            cmd = { 'vscode-css-language-server', '--stdio' },
            filetypes = { 'css', 'scss', 'less' },
            init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
            root_dir = util.root_pattern('package.json', '.git'),
            single_file_support = true,
            settings = {
              css = { validate = true },
              scss = { validate = true },
              less = { validate = true },
            },
          })
        end,
        ["marksman"] = function()
          local lspconfig = require("lspconfig")
          local util = require("lspconfig.util")

          local bin_name = 'marksman'
          local cmd = { bin_name, 'server' }

          lspconfig.marksman.setup({
            cmd = cmd,
            filetypes = { 'markdown', 'markdown.mdx' },
            root_dir = function(fname)
              local root_files = { '.marksman.toml' }
              return util.root_pattern(unpack(root_files))(fname)
                  or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
            end,
            single_file_support = true,
          })
        end,
        ["lexical"] = function()
          local lspconfig = require("lspconfig")
          local util = require("lspconfig.util")
          lspconfig.lexical.setup({
            filetypes = { 'elixir', 'eelixir', 'heex', 'surface' },
            root_dir = function(fname)
              return util.root_pattern 'mix.exs' (fname)
                  or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
            end,
            single_file_support = true,
          })
        end,
        ["graphql"] = function()
          local lspconfig = require("lspconfig")
          local util = require("lspconfig.util")

          lspconfig.graphql.setup({
            cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
            filetypes = { 'graphql', 'typescriptreact', 'javascriptreact' },
            root_dir = util.root_pattern('.graphqlrc*', '.graphql.config.*', 'graphql.config.*'),
          })
        end,
        ["eslint"] = function()
          local lspconfig = require("lspconfig")
          local util = require("lspconfig.util")
          local lsp = vim.lsp

          local function fix_all(opts)
            opts = opts or {}

            local eslint_lsp_client = util.get_active_client_by_name(opts.bufnr, 'eslint')
            if eslint_lsp_client == nil then
              return
            end

            local request
            if opts.sync then
              request = function(bufnr, method, params)
                eslint_lsp_client.request_sync(method, params, nil, bufnr)
              end
            else
              request = function(bufnr, method, params)
                eslint_lsp_client.request(method, params, nil, bufnr)
              end
            end

            local bufnr = util.validate_bufnr(opts.bufnr or 0)
            request(0, 'workspace/executeCommand', {
              command = 'eslint.applyAllFixes',
              arguments = {
                {
                  uri = vim.uri_from_bufnr(bufnr),
                  version = lsp.util.buf_versions[bufnr],
                },
              },
            })
          end

          local root_file = {
            '.eslintrc',
            '.eslintrc.js',
            '.eslintrc.cjs',
            '.eslintrc.yaml',
            '.eslintrc.yml',
            '.eslintrc.json',
            'eslint.config.js',
            'eslint.config.mjs',
            'eslint.config.cjs',
            'eslint.config.ts',
            'eslint.config.mts',
            'eslint.config.cts',
          }

          lspconfig.eslint.setup({
            default_config = {
              cmd = { 'vscode-eslint-language-server', '--stdio' },
              filetypes = {
                'javascript',
                'javascriptreact',
                'javascript.jsx',
                'typescript',
                'typescriptreact',
                'typescript.tsx',
                'vue',
                'svelte',
                'astro',
              },
              -- https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
              root_dir = function(fname)
                root_file = util.insert_package_json(root_file, 'eslintConfig', fname)
                return util.root_pattern(unpack(root_file))(fname)
              end,
              -- Refer to https://github.com/Microsoft/vscode-eslint#settings-options for documentation.
              settings = {
                validate = 'on',
                packageManager = nil,
                useESLintClass = false,
                experimental = {
                  useFlatConfig = false,
                },
                codeActionOnSave = {
                  enable = false,
                  mode = 'all',
                },
                format = true,
                quiet = false,
                onIgnoredFiles = 'off',
                rulesCustomizations = {},
                run = 'onType',
                problems = {
                  shortenToSingleLine = false,
                },
                -- nodePath configures the directory in which the eslint server should start its node_modules resolution.
                -- This path is relative to the workspace folder (root dir) of the server instance.
                nodePath = '',
                -- use the workspace folder location or the file location (if no workspace folder is open) as the working directory
                workingDirectory = { mode = 'location' },
                codeAction = {
                  disableRuleComment = {
                    enable = true,
                    location = 'separateLine',
                  },
                  showDocumentation = {
                    enable = true,
                  },
                },
              },
              on_new_config = function(config, new_root_dir)
                -- The "workspaceFolder" is a VSCode concept. It limits how far the
                -- server will traverse the file system when locating the ESLint config
                -- file (e.g., .eslintrc).
                config.settings.workspaceFolder = {
                  uri = new_root_dir,
                  name = vim.fn.fnamemodify(new_root_dir, ':t'),
                }

                -- Support flat config
                if
                    vim.fn.filereadable(new_root_dir .. '/eslint.config.js') == 1
                    or vim.fn.filereadable(new_root_dir .. '/eslint.config.mjs') == 1
                    or vim.fn.filereadable(new_root_dir .. '/eslint.config.cjs') == 1
                    or vim.fn.filereadable(new_root_dir .. '/eslint.config.ts') == 1
                    or vim.fn.filereadable(new_root_dir .. '/eslint.config.mts') == 1
                    or vim.fn.filereadable(new_root_dir .. '/eslint.config.cts') == 1
                then
                  config.settings.experimental.useFlatConfig = true
                end

                -- Support Yarn2 (PnP) projects
                local pnp_cjs = new_root_dir .. '/.pnp.cjs'
                local pnp_js = new_root_dir .. '/.pnp.js'
                if vim.loop.fs_stat(pnp_cjs) or vim.loop.fs_stat(pnp_js) then
                  config.cmd = vim.list_extend({ 'yarn', 'exec' }, config.cmd)
                end
              end,
              handlers = {
                ['eslint/openDoc'] = function(_, result)
                  if result then
                    vim.ui.open(result.url)
                  end
                  return {}
                end,
                ['eslint/confirmESLintExecution'] = function(_, result)
                  if not result then
                    return
                  end
                  return 4 -- approved
                end,
                ['eslint/probeFailed'] = function()
                  vim.notify('[lspconfig] ESLint probe failed.', vim.log.levels.WARN)
                  return {}
                end,
                ['eslint/noLibrary'] = function()
                  vim.notify('[lspconfig] Unable to find ESLint library.', vim.log.levels.WARN)
                  return {}
                end,
              },
            },
            commands = {
              EslintFixAll = {
                function()
                  fix_all { sync = true, bufnr = 0 }
                end,
                description = 'Fix all eslint problems for this buffer',
              },
            },
          })
        end,
        ["bashls"] = function()
          local lspconfig = require("lspconfig")

          lspconfig.bashls.setup({
            cmd = { 'bash-language-server', 'start' },
            settings = {
              bashIde = {
                -- Glob pattern for finding and parsing shell script files in the workspace.
                -- Used by the background analysis features across files.

                -- Prevent recursive scanning which will cause issues when opening a file
                -- directly in the home directory (e.g. ~/foo.sh).
                --
                -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
                globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
              },
            },
            filetypes = { 'bash', 'sh' },
            root_dir = function(fname)
              return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
            end,
            single_file_support = true,
          })
        end,
        ["tailwindcss"] = function()
          local lspconfig = require("lspconfig")
          local util = require("lspconfig.util")
          lspconfig.tailwindcss.setup({
            cmd = { 'tailwindcss-language-server', '--stdio' },
            -- filetypes copied and adjusted from tailwindcss-intellisense
            filetypes = {
              -- html
              'aspnetcorerazor',
              'astro',
              'astro-markdown',
              'blade',
              'clojure',
              'django-html',
              'htmldjango',
              'edge',
              'eelixir', -- vim ft
              'elixir',
              'ejs',
              'erb',
              'eruby', -- vim ft
              'gohtml',
              'gohtmltmpl',
              'haml',
              'handlebars',
              'hbs',
              'html',
              'htmlangular',
              'html-eex',
              'heex',
              'jade',
              'leaf',
              'liquid',
              'markdown',
              'mdx',
              'mustache',
              'njk',
              'nunjucks',
              'php',
              'razor',
              'slim',
              'twig',
              -- css
              'css',
              'less',
              'postcss',
              'sass',
              'scss',
              'stylus',
              'sugarss',
              -- js
              'javascript',
              'javascriptreact',
              'reason',
              'rescript',
              'typescript',
              'typescriptreact',
              -- mixed
              'vue',
              'svelte',
              'templ',
            },
            settings = {
              tailwindCSS = {
                validate = true,
                lint = {
                  cssConflict = 'warning',
                  invalidApply = 'error',
                  invalidScreen = 'error',
                  invalidVariant = 'error',
                  invalidConfigPath = 'error',
                  invalidTailwindDirective = 'error',
                  recommendedVariantOrder = 'warning',
                },
                classAttributes = {
                  'class',
                  'className',
                  'class:list',
                  'classList',
                  'ngClass',
                },
                includeLanguages = {
                  eelixir = 'html-eex',
                  eruby = 'erb',
                  templ = 'html',
                  htmlangular = 'html',
                },
              },
            },
            on_new_config = function(new_config)
              if not new_config.settings then
                new_config.settings = {}
              end
              if not new_config.settings.editor then
                new_config.settings.editor = {}
              end
              if not new_config.settings.editor.tabSize then
                -- set tab size for hover
                new_config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
              end
            end,
            root_dir = function(fname)
              return util.root_pattern(
                    'tailwind.config.js',
                    'tailwind.config.cjs',
                    'tailwind.config.mjs',
                    'tailwind.config.ts',
                    'postcss.config.js',
                    'postcss.config.cjs',
                    'postcss.config.mjs',
                    'postcss.config.ts'
                  )(fname) or vim.fs.dirname(vim.fs.find('package.json', { path = fname, upward = true })[1]) or
                  vim.fs.dirname(
                    vim.fs.find('node_modules', { path = fname, upward = true })[1]
                  ) or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
            end,
          })
        end,
        ["svelte"] = function()
          local lspconfig = require("lspconfig")
          local util = require("lspconfig.util")
          lspconfig.sqlls.setup({
            cmd = { 'svelteserver', '--stdio' },
            filetypes = { 'svelte' },
            root_dir = util.root_pattern('package.json', '.git'),
          })
        end,
      }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
      }, {
        { name = 'buffer' },
      })
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end,
}
