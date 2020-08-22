class User < ApplicationRecord
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	before_create :set_optional_id
  	devise :database_authenticatable, :registerable,
  			:recoverable, :rememberable, :validatable

  	has_many :projects, dependent: :destroy
  	has_many :recipes, dependent: :destroy


    validates :optional_id,  presence: true, uniqueness: true
    validates :nickname,  presence: true

  	attachment :profile_image

  def age
    d1=self.birth_date.strftime("%Y%m%d").to_i
    d2=Date.today.strftime("%Y%m%d").to_i
    return (d2 - d1) / 10000
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
