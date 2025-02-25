require_relative 'algorithm'
require_relative 'enigma'

handle = File.open(ARGV[0], "r")

message = handle.read

handle.close

encrypted = Enigma.new.encrypt(message)

writer = File.open(ARGV[1], "w")

writer.write(encrypted[:encryption])

writer.close

puts "Created '#{ARGV[1]}' with the key #{encrypted[:key]} and date #{encrypted[:date]}"
