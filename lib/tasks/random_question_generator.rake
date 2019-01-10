namespace :random_question_generator do

  desc "Generate 10 questions with 10 answers each"
  task questions_and_answers: :environment do

    10.times do
      question = Question.create(title: Faker::Lorem.sentence(10), description: Faker::Lorem.sentence(30))
      10.times do
        question.answers.create(body: Faker::Company.bs)
      end
    end
  end
end
