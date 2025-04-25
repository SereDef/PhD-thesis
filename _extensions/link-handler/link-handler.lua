
-- Register the 'external link' shortcode
return {
  ['extlink'] = function(args, kwargs, meta)

    -- Debug: Print the args to the console
    print("Arg1:", pandoc.utils.stringify(args[1]))
    print("Arg2:", pandoc.utils.stringify(args[2]))

     -- Parse arguments
    local var_name = type(args[1]) == "string" and args[1] or pandoc.utils.stringify(args[1])
    local link_text = args[2] and (type(args[2]) == "string" and args[2] or pandoc.utils.stringify(args[2])) or var_name

    print("Variable Name:", var_name)
    print("Link Text:", link_text)

    -- Get the variable value from document or project metadata
    local var_value = meta[var_name] 
    
    -- Convert the variable value to a plain string
    var_value = var_value and pandoc.utils.stringify(var_value)

    -- Escape LaTeX special characters
    local function escape_latex(text)
      return text:gsub("[%%&$#_{}~^\\]", "\\%1")
    end

    print("Variable Value:", var_value)

    -- Generate the link based on the output format
    if FORMAT == "latex" then
      return pandoc.RawInline('latex', 
        '\\href{' .. escape_latex(var_value) .. '}{' .. link_text .. '}'
      )
    else
      return pandoc.RawInline('html',
        '<a href="' .. var_value .. '">' .. link_text .. '</a>'
      )
      end
    end
}