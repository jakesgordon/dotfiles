" YAML front matter
syntax match Comment /\%^---\_.\{-}---$/ contains=@Spell

" Match the Octopress Backtick Code Block line
syntax match Statement /^```.*$/
