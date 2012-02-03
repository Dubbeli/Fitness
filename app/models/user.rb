class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :authentications_attributes, :terms_and_conditions_accepted

   authenticates_with_sorcery! do |config|
     config.authentications_class = Authentication
   end

   validates_confirmation_of :password
   validates_presence_of :password, :on => :create
   validates :terms_and_conditions_accepted, :acceptance => true
   validates :email, :presence => true, 
                     :length => {:minimum => 3, :maximum => 254},
                     :uniqueness => true,
                     :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}

   has_many :authentications, :dependent => :destroy
   accepts_nested_attributes_for :authentications

   def pending?
     activation_state == "pending"    
   end

   def activated?
     activation_state == "active"    
   end
end
