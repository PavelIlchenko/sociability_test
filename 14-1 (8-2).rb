name = ARGV[0]

if (Gem.win_platform? && ARGV[0])
  name = name.dup
             .force_encoding("IBM866")
             .encode("IBM866", "cp1251")
             .encode("UTF-8")
end

if name == nil
  name = "Unknown"
end

puts "Приветствуем Вас #{name}, предлагаем Вам пройти тест:"

current_path = File.dirname(__FILE__)
file_path_questions = current_path + '/data/' + 'questions.txt'
file_path_results = current_path + '/data/' + 'results.txt'

answers_points = 0

if File.exist?(file_path_questions)
  f = File.new(file_path_questions, 'r:UTF-8')
  questions = f.readlines
  f.close
else
  puts "Файл не найден"
end

if File.exist?(file_path_results)
  f = File.new(file_path_results, 'r:UTF-8')
  results = f.readlines
  f.close
else
  puts "Файл не найден"
end

for item in questions do
  puts item
  puts "Введите номер ответа: 1. Да. 2. Иногда. 3. Нет"
  answer = STDIN.gets.chomp
  while answer != "1" && answer != "2" && answer != "3" do
    puts "Вы ввели некорректный ответ, выберите 1, 2 или 3:"
    answer = STDIN.gets.chomp
  end
  if answer == "1"
    answers_points +=2
  elsif answer == "2"
    answers_points +=1
  end
end

puts "#{name}, Вы прошли тест, Ваш результат #{answers_points}. Вот, что это значит:"

if answers_points > 29
  puts results[0]
elsif answers_points >= 25 && answers_points <= 29
  puts results[1]
elsif answers_points >= 19 && answers_points <= 24
  puts results[2]
elsif answers_points >= 14 && answers_points <= 18
  puts results[3]
elsif answers_points >= 9 && answers_points <= 13
  puts results[4]
elsif answers_points >= 4 && answers_points <= 8
  puts results[5]
elsif answers_points <= 3
  puts results[6]
end
puts "Спасибо, #{name}, за участие в тестировании!"