class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	before_create :set_optional_id
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :validatable

	has_many :recipes, dependent: :destroy

  attribute :active_factor, :float, default: 1.2
  attribute :fat_intake_ratio, :float, default: 20


  validates :optional_id,  presence: true, uniqueness: true
  validates :nickname,  presence: true

	attachment :profile_image

  def lean_body_mass
    self.current_weight * (1 - self.current_body_fat/100)
  end

  def basal_metabolic_rate
    370 + 21.6 * self.lean_body_mass
  end

  def maintenance_calorie
    self.basal_metabolic_rate * self.active_factor
  end

  def calculate_dairy_target_calorie
    self.maintenance_calorie - 1000 * self.weekly_target_weight
  end

	private
	def set_optional_id
		# id未設定、または、すでに同じidのレコードが存在する場合はループに入る
		while self.optional_id.blank? || User.find_by(optional_id: self.optional_id).present? do
			# ランダムな10文字をidに設定し、whileの条件検証に戻る
			self.optional_id = SecureRandom.alphanumeric(10)
		end
	end

end
