Fabricator(:agency) do
  subdomain {'yourvilla'}
  title {'Your Villa'}
  teaser {Faker::Lorem.paragraph(sentence_count = 4)}
  skype {'andrew.wizedlux'}
  facebook_url {'http://facebook.com/'}
  email {'admin@realto.be'}
  phone {'+79244667828'}
end

Fabricator(:yourvilla, :from => :agency) do
  subdomain {'yourvilla'}
  title {'Your Villa'}
end

Fabricator(:myagency, :from => :agency) do
  subdomain {'myagency'}
  title {'My Agency'}
end