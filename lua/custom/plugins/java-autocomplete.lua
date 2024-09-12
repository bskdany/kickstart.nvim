return {
  {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' }, -- Only load for Java files
    config = function()
      -- Ensure that the nvim-jdtls plugin is loaded
      local jdtls = require 'jdtls'

      -- Define your configuration
      local config = {
        cmd = { '/home/dany/apps/jdt-language-server-1.39.0-202408291433/bin/jdtls' },
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
      }

      -- Start or attach the JDT LS to the current buffer
      jdtls.start_or_attach(config)
    end,
  },
}
