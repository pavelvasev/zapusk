#!/usr/bin/env ruby

basis = `ls spec-1-parts/*.md | sort | xargs cat`

lines = basis.split("\n")

prev_line=""
toc=[]
for line in lines[2..-1] do
  if line =~ /========/
    toc.push prev_line
  end
  prev_line=line
end

toc_text = toc.map{ |r|
  urla = "#" + r.downcase.gsub(" ","-")
 " * [#{r}](#{urla})"
}.join("\n")

lines.insert( 2, toc_text )

File.open( "spec-1.md","w") { |f| lines.each {|line| f.puts line} }