# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Review.destroy_all
Shelter.destroy_all
# Application.destroy_all
Pet.destroy_all
# PetApplication.destroy_all


shelter_1 = Shelter.create(name: "Abby's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")
shelter_2 = Shelter.create(name: "Alex's Shelter", address: "345 Georgia Street", city: "Denver", state: "CO", zip: "80223")
shelter_3 = Shelter.create(name: "Aaron's Shelter", address: "678 California Street", city: "Denver", state: "CO", zip: "80234")
shelter_4 = Shelter.create(name: "The Pound", address: "123 Main Street", city: "Denver", state: "CO", zip: "80210")
shelter_5 = Shelter.create(name: "The Dog Palace", address: "456 Main Street", city: "Denver", state: "CO", zip: "80210")

pet_1 = shelter_1.pets.create(
  image: 'https://www.dogster.com/wp-content/uploads/2018/12/german-shepard-dog-face.jpg',
  name: "Penny",
  age: 2,
  sex: "F",
  description: "Very nice dog",
  adopted?: "Adoptable"
)
pet_2 = shelter_1.pets.create(
  image: 'https://www.vivamunehealth.com/wp-content/uploads/gsd21024x512-1024x512.jpg',
  name: "Grumpy",
  age: 7,
  sex: "M",
  description: "Very funny dog",
  adopted?: "Adoptable"
)

pet_3 = shelter_1.pets.create(
  image: 'https://static.wixstatic.com/media/102d01_e52cf7ca257d4e458f37a0a47d6daa8a~mv2.jpg/v1/fill/w_640,h_276,al_c,q_80,usm_0.66_1.00_0.01/102d01_e52cf7ca257d4e458f37a0a47d6daa8a~mv2.webp',
  name: "Hanz",
  age: 3,
  sex: "M",
  description: "Very outgoing dog",
  adopted?: "Adoptable"
)

pet_4 = shelter_2.pets.create(
  image: 'https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg',
  name: "Rosie",
  age: 3,
  sex: "F",
  description: "Very shy dog",
  adopted?: "Adoptable"
)
pet_5 = shelter_2.pets.create(
  image: 'https://www.anythinggermanshepherd.com/wp-content/uploads/2019/10/How-Often-Do-German-Shepherd-Puppies-Poop.jpg',
  name: "Petunia",
  age: 1,
  sex: "F",
  description: "Very shy dog",
  adopted?: "Adoptable"
)
pet_6 = shelter_2.pets.create(
  image: 'https://vetstreet.brightspotcdn.com/dims4/default/daea1bb/2147483647/thumbnail/645x380/quality/90/?url=https%3A%2F%2Fvetstreet-brightspot.s3.amazonaws.com%2F98%2F5c%2Fa89605db40e5bfd72ff6d0e41ae2%2Fgerman-shepherd-ap-aozjlq-645.jpg',
  name: "Doug",
  age: 3,
  sex: "M",
  description: "Very fun dog",
  adopted?: "Adoptable"
)
pet_7 = shelter_3.pets.create(
  image: 'https://www.aspcapetinsurance.com/media/2316/facts-about-german-shepherds.jpg',
  name: "Hank",
  age: 4,
  sex: "M",
  description: "Very outgoing dog",
  adopted?: "Adoptable"
)
pet_8 = shelter_3.pets.create(
  image: 'https://thehappypuppysite.com/wp-content/uploads/2018/12/German-Shepherd-Dog-Breed-Information-Center-HP-long.jpg',
  name: "Lily",
  age: 3,
  sex: "F",
  description: "Very shy dog",
  adopted?: "Adoptable"
)
pet_9 = shelter_3.pets.create(
  image: 'https://media1.popsugar-assets.com/files/thumbor/QYcQ17h-c7xh-evZHmaGSGI1l-U/0x159:2003x2162/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2019/08/07/875/n/24155406/9ffb00255d4b2e079b0b23.01360060_/i/Cute-Pictures-German-Shepherd-Puppies.jpg',
  name: "Harvey",
  age: 1,
  sex: "M",
  description: "Very confused dog",
  adopted?: "Adoptable"
)
pet_10 = shelter_4.pets.create(
  image: 'https://firehouseleander.com/wp-content/uploads/2018/04/german-shepherd-3404340_1920-min.jpg',
  name: "Gertrude",
  age: 4,
  sex: "F",
  description: "Very lazy dog",
  adopted?: "Adoptable"
)
pet_11 = shelter_4.pets.create(
  image: 'https://static.wixstatic.com/media/55d44f_2c1994a4df674c569f690e6dcbcfcfdc~mv2.jpg/v1/fill/w_1088,h_960,al_c,q_85/55d44f_2c1994a4df674c569f690e6dcbcfcfdc~mv2.webp',
  name: "Gretta",
  age: 3,
  sex: "F",
  description: "Very fluffy dog",
  adopted?: "Adoptable"
)
pet_12 = shelter_4.pets.create(
  image: 'https://www.mwdtsa.org/wp-content/uploads/mwdtsa-kenneltalk-blog-gsd-photo-20180417.jpg',
  name: "Steve",
  age: 2,
  sex: "M",
  description: "Very focused dog",
  adopted?: "Adoptable"
)

pet_13 = shelter_5.pets.create(
  image: 'https://cdn.shortpixel.ai/spai/w_977+q_lossless+ret_img+to_webp/https://www.k9ofmine.com/wp-content/uploads/2017/02/german-shepherd-dog-food-1150x700.jpg',
  name: "Alfred",
  age: 1,
  sex: "M",
  description: "Very tired dog",
  adopted?: "Adoptable"
)
pet_14 = shelter_5.pets.create(
  image: 'https://www.petplace.com/static/41bf50fae23f24d5b7225070ad9260dd/842a8/german-shep.jpg',
  name: "Ella",
  age: 3,
  sex: "F",
  description: "Very happy dog",
  adopted?: "Adoptable"
)
pet_15 = shelter_5.pets.create(
  image: 'https://thehappypuppysite.com/wp-content/uploads/2019/02/German-Shepherd-Temperament-long.jpg',
  name: "Beatrice",
  age: 2,
  sex: "F",
  description: "Very focused dog",
  adopted?: "Adoptable"
)

# shelters.each do |shelter|
#   pets = FactoryBot.create_list(:random_pet, 15, shelter: shelter)
#   FactoryBot.create_list(:random_review, 10, shelter: shelter)
#   apps = FactoryBot.create_list(:random_application, 2)
#   apps.each do |app|
#     app.pets << pets[rand(0..7)]
#     app.pets << pets[rand(8..14)]
#   end
# end
