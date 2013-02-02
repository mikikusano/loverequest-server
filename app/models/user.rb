class User
  # Available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # :database_authenticatable, :registerable,
  # :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :github_id, :github_name, :github_token, :image_url

end
