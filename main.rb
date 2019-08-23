$keystore_path = ARGV[0]
$dictionary_path = ARGV[1] ? ARGV[1] : 'dictionary.txt'

puts 'Starting...'

if $keystore_path.nil?
  puts "The keystore path was not specified!!"
  abort
end

file=File.open($dictionary_path).read
file.gsub!(/\r\n?/, "\n")
file.each_line do |line|
 puts "Trying word >> #{line}"
 output = system "keytool -list -keystore #{$keystore_path} -storepass #{line}"
 if output && output != false
   result = "Found >> #{line}"
   puts result
   File.open('result.txt', 'w') { |file| 
     file.write(result)
   }
   abort
 end
end
