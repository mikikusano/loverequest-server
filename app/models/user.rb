class User
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :remember_me

end
