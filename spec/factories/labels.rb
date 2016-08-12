FactoryGirl.define do
   factory :label do
    #  name RandomData.random_word
     sequence(:name){|n| "#{RandomData.random_word}#{n}"}
   end
 end
