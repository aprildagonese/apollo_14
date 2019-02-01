require "rails_helper"

describe 'astronauts index' do
  it "user can see all astronauts" do
    armstrong = Astronaut.create(name: "Neil Armstrong", age: 37, job: "Commander")
    roosa = Astronaut.create(name: "Stuart Roosa", age: 19, job: "Engineer")

    visit astronauts_path

    within "#astronaut-#{armstrong.id}" do
      expect(page).to have_content("Name: #{armstrong.name}")
      expect(page).to have_content("Age: #{armstrong.age}")
      expect(page).to have_content("Job: #{armstrong.job}")
    end

    within "#astronaut-#{roosa.id}" do
      expect(page).to have_content("Name: #{roosa.name}")
      expect(page).to have_content("Age: #{roosa.age}")
      expect(page).to have_content("Job: #{roosa.job}")
    end
  end

  it "user sees average astronaut age" do
    armstrong = Astronaut.create(name: "Neil Armstrong", age: 37, job: "Commander")
    roosa = Astronaut.create(name: "Stuart Roosa", age: 29, job: "Engineer")
    mitchell = Astronaut.create(name: "Edgar Mitchell", age: 32, job: "Pilot")

    expected = ((37 + 29 + 32)/3).round

    visit astronauts_path

    expect(page).to have_content("Average Astronaut Age: #{expected}")
  end

  it "user sees all astronaut missions" do
    armstrong = Astronaut.create(name: "Neil Armstrong", age: 37, job: "Commander")
    roosa = Astronaut.create(name: "Stuart Roosa", age: 29, job: "Engineer")
    apollo = Mission.create(title: "Apollo 13", time_in_space: 130)
    capricorn = Mission.create(title: "Capricorn 4", time_in_space: 40)
    gemini = Mission.create(title: "Gemini 7", time_in_space: 70)
    armstrong.missions << apollo
    armstrong.missions << gemini
    roosa.missions << gemini
    roosa.missions << capricorn

    armstrong_expected = "Apollo 13 Gemini 7"
    roosa_expected = "Capricorn 4 Gemini 7"

    visit astronauts_path

    within "#astronaut-#{armstrong.id}" do
      expect(page).to have_content("Missions: #{armstrong_expected}")
    end

    within "#astronaut-#{roosa.id}" do
      expect(page).to have_content("Missions: #{roosa_expected}")
    end
  end

end
