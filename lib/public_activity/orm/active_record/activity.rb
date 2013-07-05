module PublicActivity
  module ORM
    module ActiveRecord
      # The ActiveRecord model containing
      # details about recorded activity.
      class Activity < ::ActiveRecord::Base
        include Renderable

        # Define polymorphic association to the parent
        belongs_to :trackable, :polymorphic => true
        # Define ownership to a resource responsible for this activity
        belongs_to :owner, :polymorphic => true
        # Define ownership to a resource targeted by this activity
        belongs_to :recipient, :polymorphic => true
        # Serialize parameters Hash
        serialize :parameters, Hash

        geocoded_by :ip_address, :latitude => :lat, :longitude => :lng
        after_validation :geocode

        # should recipient and owner be accessible?
        attr_accessible :key, :owner, :parameters, :recipient, :trackable, :ip_address, :lat, :lng
      end
    end
  end
end
