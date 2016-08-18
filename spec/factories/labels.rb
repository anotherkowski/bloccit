FactoryGirl.define do
   factory :label do
    #  name RandomData.random_word
     name {RandomData.random_word}
   end
 end
