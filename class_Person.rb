require "faker"
require "csv"
require "date"

class Person
	attr_accessor :first_name, :last_name, :email, :phone, :created_at
	def initialize(first_name, last_name, email, phone, created_at)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@phone = phone
		@created_at = created_at
	end
end

def crea_personas(num)
	arr = []
	num.times do
		arr << Person.new("Isabel", "Diaz", "isabeldiazmi@gmail.com", "5520463984", "21-oct-2015")
	end
	arr
end

class PersonWriter
	def initialize(nombre, lista_personas)
		@nombre = nombre
		@lista_personas = lista_personas
	end

	def create_csv
		CSV.open("personas.csv", "wb") do |row|
			@lista_personas.each do |persona|
				row << [persona.first_name, persona.last_name, persona.email, persona.phone, persona.created_at]
			end
		end
	end
end

# people = crea_personas(3)
# person_writer = PersonWriter.new("people.csv", people)
# person_writer.create_csv

class ArrayPerson
	def self.number_of_person(num)
		@people_in_array = Array.new(num) {self.create_fake_person}
	end

	def self.create_fake_person #self -> (metodo de clase) para no tener que generar una instancia nueva y utilizar lo de adentro
		@person = Person.new(Faker::Name.first_name, Faker::Name.last_name, Faker::Internet.email, Faker::PhoneNumber.phone_number, Time.now)
	end
end

people = ArrayPerson.number_of_person(12)
person_writer = PersonWriter.new("personas.csv", people)
person_writer.create_csv

class PersonParser
	def initialize(file)
		@file = file
		@people_array = []
	end

	def people
		CSV.foreach(@file) do |row|
			@people_array << Person.new(row[0],row[1],row[2],row[3],DateTime.parse(row[4]))
		end
		@people_array
	end
end

parser = PersonParser.new('personas.csv')
people = parser.people
10.times do |x|
	p people[x]
end

