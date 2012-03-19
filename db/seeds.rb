# encoding: utf-8

{
    'Kitchen' => 'Кухня',
    'Bedrooms' => 'Спальни',
    'Bathrooms' => 'Ванные комнаты',
    'Tv' => 'ТВ',
    'Jacuzzi' => 'Джакузи',
    'Airport' => 'Аэропорт',
    'Bar' => 'Бар',
    'Boat' => 'Яхта',
    'Buildings area' => 'Площадь зданий',
    'Land area' => 'Площадь участка',
    'Butler' => 'Батлер',
    'Pets' => 'Домашние животные',
    'Children' => 'Дети',
    'Cleaner' => 'Уборка',
    'Driver' => 'Водитель',
    'Fast track' => 'Фаст-трэк',
    'Food delivery' => 'Доставка еды',
    'Gym' => 'Тренажёрный зал',
    'Land line' => 'Телефон',
    'Laundry' => 'Прачечная',
    'Parking' => 'Парковка',
    'Restorant' => 'Ресторан',
    'Safety box' => 'Сейф',
    'Spa' => 'Спа',
}.each do |en, ru|
    Feature.create({
        :title_translations => {'en' => en, 'ru' => ru},
        :description_translations => {'en' => en, 'ru' => ru},
        :searchable => false
    })
end

{
    'Transfer' => 'Трансфер',
    'Swimming pool' => 'Бассейн',
    'Wi-fi' => 'Вай-Фай',
    'Breakfast' => 'Завтрак',
    'Nice view' => 'Хороший вид',
    'Garden' => 'Сад',
    'Security' => 'Охрана',
    'Beach' => 'Рядом с пляжем'
}.each do |en, ru|
    Feature.create({
        :title_translations => {'en' => en, 'ru' => ru},
        :description_translations => {'en' => en, 'ru' => ru},
        :searchable => true
    })
end

admin  = Fabricate(:person)
myagency = Fabricate(:myagency, :owner => admin)

70.times do
    estate = Fabricate(:estate, :agency => myagency)
end
