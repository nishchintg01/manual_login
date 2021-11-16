class User < ApplicationRecord
    attr_accessor :password
    has_one_attached :image, :dependent => :destroy

    validates :first_name, :last_name, :email, :mobile, :date_of_birth, :password, presence: true
    validates :email, length: {minimum: 4}, uniqueness: true, format: { :with => /[a-z0-9]+[@][a-z]+[.][a-z]+{2,4}/, :message => "is not valid" }
    validates :password, length: { minimum: 6, maximum: 32 }


    # Callbacks
    before_save :encrypt_password

    def encrypt_password
        self.hashed_password = password_digest(password)
    end

    def password_digest(pass)
        return Digest::SHA1.hexdigest(pass)
    end

    def self.authenticate(email, pass)
        begin
            user = User.find_by_email(email)
            if user.hashed_password == user.password_digest(pass)
                return user
            end
        rescue => exception
            return 
        end
    end
end
