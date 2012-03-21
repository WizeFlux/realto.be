# encoding: utf-8

# {
#     'Kitchen' => 'Кухня',
#     'Bedrooms' => 'Спальни',
#     'Bathrooms' => 'Ванные комнаты',
#     'Tv' => 'ТВ',
#     'Jacuzzi' => 'Джакузи',
#     'Airport' => 'Аэропорт',
#     'Bar' => 'Бар',
#     'Boat' => 'Яхта',
#     'Buildings area' => 'Площадь зданий',
#     'Land area' => 'Площадь участка',
#     'Butler' => 'Батлер',
#     'Pets' => 'Домашние животные',
#     'Children' => 'Дети',
#     'Cleaner' => 'Уборка',
#     'Driver' => 'Водитель',
#     'Fast track' => 'Фаст-трэк',
#     'Food delivery' => 'Доставка еды',
#     'Gym' => 'Тренажёрный зал',
#     'Land line' => 'Телефон',
#     'Laundry' => 'Прачечная',
#     'Parking' => 'Парковка',
#     'Restorant' => 'Ресторан',
#     'Safety box' => 'Сейф',
#     'Spa' => 'Спа',
# }.each do |en, ru|
#     Feature.create({
#         :title_translations => {'en' => en, 'ru' => ru},
#         :description_translations => {'en' => en, 'ru' => ru},
#         :searchable => false
#     })
# end
# 
# {
#     'Transfer' => 'Трансфер',
#     'Swimming pool' => 'Бассейн',
#     'Wi-fi' => 'Вай-Фай',
#     'Breakfast' => 'Завтрак',
#     'Nice view' => 'Хороший вид',
#     'Garden' => 'Сад',
#     'Security' => 'Охрана',
#     'Beach' => 'Рядом с пляжем'
# }.each do |en, ru|
#     Feature.create({
#         :title_translations => {'en' => en, 'ru' => ru},
#         :description_translations => {'en' => en, 'ru' => ru},
#         :searchable => true
#     })
# end
# 
# admin  = Fabricate(:person)
# myagency = Fabricate(:myagency, :owner => admin)

# 70.times do
#     estate = Fabricate(:estate, :agency => myagency)
# end

myagency = Agency.find('yourvilla')
connection = Mongo::Connection.new.db("realto")

estates = connection.collections[6].find.to_a
inclusions = connection.collections[4].find.to_a
specs = connection.collections[7].find.to_a

estates.each do |estate|
    e = Estate.create({
        :agency => myagency,
        :title_translations => estate['title'],
        :teaser_translations => estate['teaser'],
        :slug => estate['title']['en'],
        :bedrooms => estate['bedrooms'],
        :adults_max => estate['max_adults'],
        :childs_max => estate['max_childs']
    })

    if estate['seasons']
        estate['seasons'].each do |season|
            e.pricelist.seasons.create({
                :start => season['start'],
                :finish => season['finish'],
                :title_translations => season['name']
            })
        end
    end

    if estate['bonus_days']
        estate['bonus_days'].each do |bd|
            e.pricelist.leasespans.create({
                :from => bd['min'],
                :to => bd['max']
            })
        end
    end

    if estate['services']
        estate['services'].each do |s|
            e.pricelist.choices.create({
                :title_translations => s['description'],
                :price => ((s['price'] != 0) ? s['price'] : nil)
            })
        end
    end

    
    specs.each do |spec|
        if spec['estate_id'] == estate['_id']
            feature = Feature.where(:title => spec['feature_title']['en']).first
            e.booklet.tags.create({
                :text_translations => spec['text'],
                :feature_id => (feature ? feature.id : Feature.first.id)
            })
        end
    end

    en_text = ''
    ru_text = ''
    
    inclusions.each do |inclusion|
        if inclusion['inclusionable_id'] == estate['_id']
            if inclusion['_type'] == 'Paragraph'
                en_text += ("\n\np. " + inclusion['content']['en']) if inclusion['content']['en']
                ru_text += ("\n\np. " + inclusion['content']['ru']) if inclusion['content']['ru']
            end
            if inclusion['_type'] == 'Title'
                en_text += ("\n\nh3. " + inclusion['content']['en']) if inclusion['content']['en']
                ru_text += ("\n\nh3. " + inclusion['content']['ru']) if inclusion['content']['ru']
            end
        end
    end
    
    I18n.locale = :ru
    e.booklet.content = ru_text

    I18n.locale = :en
    e.booklet.content = en_text
    
    e.booklet.save
    e.save
end