Fabricator(:person) do
  name {Faker::Name.name}
  password {'123'}
  email {'fear.ru@gmail.com'}
end