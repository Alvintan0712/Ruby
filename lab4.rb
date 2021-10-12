keys = gets.strip().split()
values = gets.strip().split()

Hmap = Hash.new()
for key, value in keys.zip(values)
	Hmap[key] = value
	# puts "#{key} #{value}"
end
puts Hmap