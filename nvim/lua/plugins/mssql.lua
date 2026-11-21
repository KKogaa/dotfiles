return {
  "Kurren123/mssql.nvim",
  opts = {
    keymap_prefix = "<leader>d",
    max_rows = 50,
    max_column_width = 50,
  },
  config = function(_, opts)
    local mssql = require("mssql")

    -- connections.json carries a fixed Entra ID token (written by
    -- ~/.local/bin/mssql-p2p-token) that expires after ~1h. Re-run the script
    -- before connecting whenever it is expired or about to expire. Wrapped
    -- before setup() so the plugin's keymaps pick up the wrapped functions.
    local function ensure_token()
      local file = vim.fn.stdpath("data") .. "/mssql.nvim/connections.json"
      local ok, conns = pcall(function()
        return vim.json.decode(table.concat(vim.fn.readfile(file), "\n"))
      end)
      local _, first = next(ok and conns or {})
      if first and tonumber(first.expiresOn) and first.expiresOn > os.time() + 300 then
        return true
      end
      vim.notify("mssql: refreshing Entra ID token...")
      local out = vim.system({ vim.fn.expand("~/.local/bin/mssql-p2p-token") }, { text = true }):wait()
      if out.code ~= 0 then
        vim.notify("mssql: token refresh failed (az login?)\n" .. vim.trim(out.stderr or ""), vim.log.levels.ERROR)
        return false
      end
      vim.notify(vim.trim(out.stdout))
      return true
    end

    for _, name in ipairs({ "connect", "new_default_query", "execute_query" }) do
      local orig = mssql[name]
      mssql[name] = function(...)
        if ensure_token() then
          return orig(...)
        end
      end
    end

    mssql.setup(opts)
    vim.keymap.set("n", "<leader>o", function()
      mssql.connect()
    end, { desc = "MSSQL connect" })

    -- Always Encrypted: STS asks the client for a Key Vault access token via
    -- account/securityTokenRequest (VS Code answers with the signed-in account).
    -- Fetch it with az cli instead.
    vim.lsp.handlers["account/securityTokenRequest"] = function(err, params)
      if err then
        return nil, err
      end
      local resource = (params and (params.resource or params.Resource))
        or "https://vault.azure.net"
      local out = vim.system({
        "az", "account", "get-access-token",
        "--resource", resource,
        "--query", "accessToken",
        "-o", "tsv",
      }, { text = true }):wait()
      local token = out.stdout and vim.trim(out.stdout) or ""
      if out.code ~= 0 or token == "" then
        return nil, {
          code = 1,
          message = "az token request failed: "
            .. vim.trim(out.stderr or "unknown error"),
        }
      end
      return { token = token, accountKey = "" }
    end
  end,
}
