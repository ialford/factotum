class DirectoryOrganizationalUnit < ActiveRecord::Base

  belongs_to :department, :class_name => "DirectoryDepartment"
  belongs_to :university_committee, :class_name => "DirectoryUniversityCommittee"
  belongs_to :library_committee, :class_name => "DirectoryLibraryCommittee"

  has_many :children_units, :class_name => DirectoryOrganizationalUnit, :foreign_key => "parent_organizational_unit_id"
  belongs_to :parent_unit, :class_name => DirectoryOrganizationalUnit

  has_many :contact_informations, as: :contactable
  has_many :employee_units, :class_name => "DirectoryEmployeeUnit"

  validates :name, presence: true 
  validates :type, presence: true 
  validates_uniqueness_of :name


  def self.sorted
    self.order(:name)
  end


  def descendents
    children_units.sorted.map do |ch|
      [ch] + ch.descendents
    end.flatten
  end


  def self_and_descendents
    [self] + descendents
  end


end