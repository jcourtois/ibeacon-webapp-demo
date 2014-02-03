FactoryGirl.define do
  factory :visit do

    factory :dairy_visit do
      enter_time DateTime.parse('Mon, 03 Feb 2014 18:32:00 UTC +00:00')
      exit_time DateTime.parse('Mon, 03 Feb 2014 18:46:23 UTC +00:00')

      association :customer
      association :product_area, name: 'Dairy'
    end

    factory :bakery_visit do
      enter_time DateTime.parse('Mon, 03 Feb 2014 18:46:30 UTC +00:00')
      exit_time DateTime.parse('Mon, 03 Feb 2014 18:58:02 UTC +00:00')

      association :customer
      association :product_area, name: 'Bakery'
    end

  end
end
