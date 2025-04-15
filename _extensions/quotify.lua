-- Convert divs with class "quotify" to the custom LaTeX environment
function Div(el)
  if el.classes:includes("quotify") then
    -- Convert the content of the div to LaTeX
    local content = pandoc.write(pandoc.Pandoc(el.content), "latex")
    -- Replace <br> or raw line breaks with \newline for LaTeX...?
    -- Wrap the content in the "quotify" LaTeX environment
    return pandoc.RawBlock("latex", "\\begin{quotify}\n" .. content .. "\n\\end{quotify}")
  end
end