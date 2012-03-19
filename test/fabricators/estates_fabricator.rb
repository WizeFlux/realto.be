# encoding: utf-8

Fabricator(:estate) do
    title_translations {{
        'en' => (['Estate ', 'Apparts ', 'House ', 'Homestay '].sample + Faker::Name.first_name),
        'ru' => (['Объект ', 'Аппартаменты ', 'Дом ', 'Хоум-стэй '].sample + Faker::Name.first_name)
    }}
    
    teaser {Faker::Lorem.paragraph(sentence_count = 10)[1..[150, 200, 150].sample]}
    
    slug {['Estate ', 'Apparts ', 'House ', 'Homestay '].sample + Faker::Name.first_name}
    bedrooms {rand(10) + 1}
    max_adults {rand(10) + 1}
    max_childs {rand(10) + 1}
end