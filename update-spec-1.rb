#!/usr/bin/env ruby

basis = `ls spec-1-parts/*.md | sort | xargs cat`

lines = basis.split("\n")

prev_line=""
toc=[]
for line in lines[2..-1] do
  if line =~ /========/
    toc.push prev_line
  end
  if line =~ /^#\# (.+)/
    toc.push "- #{$1}"
  end  
  prev_line=line
end

toc_text = toc.map{ |r|
 if r[0] == "-"
   r = r[2..-1]
   urla = "#" + r.downcase.gsub(" ","-")
    "   - [#{r}](#{urla})"
 else
    urla = "#" + r.downcase.gsub(" ","-")
    " * [#{r}](#{urla})"
 end
}.join("\n")

lines.insert( 2, toc_text )

File.open( "spec-1.md","w") { |f| lines.each {|line| f.puts line} }