require_relative 'algorithm'
require_relative 'enigma'

handle = File.open(ARGV[0], "r")

encrypted = handle.read

handle.close

decrypt = Enigma.new.decrypt(encrypted, ARGV[2], ARGV[3])

writer = File.open(ARGV[1], "w")

writer.write(decrypt[:decryption])

writer.close

puts "Created '#{ARGV[1]}' with the key #{decrypt[:key]} and date #{decrypt[:date]}"
