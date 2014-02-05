FactoryGirl.define do
  factory :visit do
    factory :dairy_entry_visit do
      enter_time DateTime.parse('Mon, 03 Feb 2014 18:32:00 UTC +00:00')

      association :customer
      association :product_area, name: 'Dairy'
    end

    factory :wine_cellar_entry_visit do
      enter_time DateTime.parse('Mon, 03 Feb 2014 11:32:00 UTC +00:00')

      association :customer
      association :product_area, name: 'Wine Cellar'
    end

    factory :bakery_complete_visit do
      enter_time DateTime.parse('Mon, 03 Feb 2014 18:46:30 UTC +00:00')
      exit_time DateTime.parse('Mon, 03 Feb 2014 18:58:02 UTC +00:00')

      association :customer
      association :product_area, name: 'Bakery'
    end

    association :customer
    association :product_area
  end
end
