class User < ApplicationRecord
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	before_create :set_id
  	devise :database_authenticatable, :registerable,
  			:recoverable, :rememberable, :validatable

  	has_many :projects, dependent: :destroy
  	has_many :recipes, dependent: :destroy


  	validates :nickname, 	presence: true
  	validates :birth_date, 	presence: true
  	validates :height, 		presence: true
  	validates :sex, 		presence: true

  	attachment :profile_image

  	enum sex:{
		男性:     	0,
		女性:     	1,
		その他:  	2
	}

	private
	def set_id
		# id未設定、または、すでに同じidのレコードが存在する場合はループに入る
		while self.id.blank? || User.find_by(id: self.id).present? do
			# ランダムな20文字をidに設定し、whileの条件検証に戻る
			self.id = SecureRandom.alphanumeric(10)
		end
	end

end
