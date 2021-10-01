class Course < ApplicationRecord

  extend FriendlyId 
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
=begin
  friendly_id :generated_slug, use: :slugged
    def generated_slug
      require 'securerandom'
      @random_slug ||= persisted? ? friendly_id : SecureRandom.hex(4)
    end
=end

  validates :title, :short_description, :language, :level, 
  :price, presence: true
  validates :description, presence: true, length: {minimum:5}

  has_rich_text :description

  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :enrollments

  LANGUAGES = [:"English", :"Spanish", :"Russian"]
  LEVELS = [:"Beginner", :"Intermediate", :"Advanced"]

  def self.languages 
    LANGUAGES.map { |language| [language, language] } 
  end

  def self.levels 
    LEVELS.map { |level| [level, level] }
  end

  def to_s 
    title
  end

  def bought(user)
    self.enrollments.where(user_id: [user.id], course_id: [self.id]).empty?
  end



 
end
