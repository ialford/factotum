class WorldCatOCLC
  WORLDCAT_API_KEY = "wLC2QOx0b8Ucc9xgpu3Bxgbi93yS54E1TygoY363fB40vqKw2pwt9fwhblZty7Go1HGFfkJcgEZPfcy4"
  
  EXCLUDED_DESCRIPTION_FIELDS = [506, 530, 540, 546]
  
  FIELD_MAP = {
    :creator => { :fields => [100, 110, 111, 700, 710, 711, 720], :subfields => ['a'] },
    :subject => { :fields => [600, 610, 611, 630, 650, 653] },
    :description => { :fields => (500..599).reject{|i| EXCLUDED_DESCRIPTION_FIELDS.include?(i)} },
    :coverage => { :fields => [651, 752] },
    :rights => { :fields => [506, 540] },
    :relation => { :fields => [760..787], :subfields => ['o','t'] }
  }
  
  attr_accessor :title, :author, :isbn, :creator, :subject, :description, :publisher, :date, :type, :format, :identifier, :source, :language, :relation, :coverage, :rights
  
  
  def initialize(values)
    if values[:oclc].present?
      @record = self.class.client.single_record(:oclc => values[:oclc])
    elsif values[:isbn].present?
      @record = self.class.client.single_record(:isbn => values[:isbn])
    else
      raise WorldCat::WorldCatError.new, "Record does not exist"
    end
    self.map_dublin_core
  end
  
  def self.client
    @client ||= WorldCat.new(WORLDCAT_API_KEY)
  end
  
  def self.test
    self.new(43628981)
  end
  
  protected
    
    def record
      @record
    end
    
    def map_dublin_core
      self.title = marc_value('245','a').to_s.gsub(/ \/$/,'')
      
      FIELD_MAP.each do |key, options|
        if self.send(key).blank?
          self.send("#{key}=", [])
        end
        options[:fields].each do |field|
          value = marc_value(field, *options[:subfields])
          if value.present?
            self.send(key).push(value)
          end
        end
        self.send(key).flatten!
        self.send(key).compact!
      end
      
      statement = marc_value('245','c')
      if statement.present?
        self.author = [statement]
      else
        self.author = self.creator
      end
      
      self.publisher = marc_value('260','a','b')
      if self.publisher.is_a?(Array)
        self.publisher = self.publisher.join(' ')
      end
      self.date = marc_value('260','c')
      self.type = marc_value('655') 
      self.format = marc_value('856','q')
      self.identifier = marc_value('856','u') 
      self.source = marc_value('786','o','t') 
      self.language = marc_value('546')
      
      self.relation = []
      if value = marc_value('530')
        self.relation << value
      end
      
      true
    end
    
    def marc_value(field, *subfields)
      datafield = record[field.to_s]
      return if datafield.nil?
      subfields.compact!
      if subfields.blank?
        values = datafield.subfields.collect{|s| s.value}
        if values.size == 1
          values.first
        else
          values
        end
      else
        values = []
        subfields.each do |subfield|
          values << datafield[subfield]
        end
        if subfields.size == 1
          values.first
        else
          values
        end
      end
    end
end