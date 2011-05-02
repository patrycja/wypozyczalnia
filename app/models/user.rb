class User < ActiveRecord::Base
  has_many :rents
  has_many :cars, :through => :rents
  has_many :reservations
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :imie, :nazwisko, :adres, :admin, :recepcja, :klient
  
  after_destroy :ensure_an_admin_remains
  
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
end
