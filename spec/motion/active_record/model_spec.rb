describe "Active Record - Model" do

  DATABASE_NAME = 'Database'


  class Person < NSManagedObject
  #   has_many :cars
  #   validates_presence_of [:name, :surname]
  end

  class Car < NSManagedObject
  #   belongs_to :person
  end
  
  before do
    @unique_name = 'efAEWFEWAfiuhwefb'
    @unique_surname = 'ewjfew3aWxcEWfse'
  end


  describe "creation" do
    
    before do
      @cars = [Car.new, Car.new, Car.new]
      @name = "John"
      @surname = "Doe"
      @age = 22
      @person = Person.create(name: @name, surname: @surname, age: @age, cars: @cars)
    end

    it "should set the attributes from create arguments" do
      @person.name.should.equal @name
      @person.surname.should.equal @surname
      @person.age.should.equal @age
      @person.cars.class.should.equal Array
      @person.cars.size.should.equal 3
      @person.cars.each { |car| car.class.should.equal Car }
    end

    it "doesn't create the object in database until it's saved" do
      numbah = Person.all.size
      Person.create
      Person.new
      Person.all.size.shoud.equal numbah
    end

  end

  describe "finders" do
    
    it "handles both strings and hash arguments" do
      finders = -> {
        Person.all
        Person.find("name == 'John' AND surname == 'Doe'")
        Person.where("name == 'John' AND surname == 'Doe'")

        Person.find(name: 'John', surname: 'Doe')
        Person.where(name: 'John', surname: 'Doe')
      }
      finders.should.not.raise NoMethodError
    end

  end

  describe "saving / deleting" do
  
    it "saves the object to the database" do
      person = Person.create(name: @unique_name, surname: @unique_surname)
      person.save

      Person.find(name: @unique_name, surname: @unique_surname).should.not.equal nil
      Person.where(name: @unique_name, surname: @unique_surname).should.not.equal nil
    end

    it "removes the object from the database" do
      person = Person.find(name: @unique_name, surname: @unique_surname)
      person.should.not equal nil
      person.delete
      Person.find(name: @unique_name, surname: @unique_surname).should.equal nil
      Person.where(name: @unique_name, surname: @unique_surname).should.equal nil
    end

  end

  # BELOW ARE THE COMMENTED OUT SPECS THAT WERE WRITTEN FOR OUR CUSTOM AR IMPLEMENTATION.
  # FOR NOW WE'LL BE USING CORE DATA.

  # describe "attributes" do
    
  #   before do
  #     @person = Person.create(name: @unique_name, surname: @unique_surname, is_member: true, age: 22)
  #   end

  #   after do
  #     @person.delete
  #   end

  #   it "updates the modified attributes in database when saved" do
  #     @person.name.should.equal @unique_name
  #     @person.name = 'marin'
  #     @person.name.should.equal 'marin'
  #     @person.save

  #     modified_person = Person.find(surname: @unique_surname)
  #     modified_person.name.should.equal 'marin'
  #   end

  #   it "knows how to handle booleans" do
  #     @person.is_member.should.equal true
  #     @person.is_member = false
  #     @person.is_member.should.equal false

  #     @person.save
  #     Person.find(surname: @unique_surname).is_member.should.equal false
  #   end

  #   it "knows how to handle numbers" do
  #     @person.age.should.equal 22
  #     @person.age = 33
  #     @person.age.should.equal 33

  #     @person.save
  #     Person.find(surname: @unique_surname).age.should.equal 33
  #   end

  # end

  # describe "relationships" do

  # end

  # describe "validators" do

  #   class SampleModel < BW::Model
  #     validates_presence_of :name
  #     validates_uniqueness_of :model_id

  #     # Take a look at the Rails validations page:
  #     # http://guides.rubyonrails.org/active_record_validations_callbacks.html
  #     # What do you think about them?

  #   end
    

  # end

end