module SimpleUid
  extend ActiveSupport::Concern

  class_methods do
    def by_uid(uid_with_name)
      by_uid!(uid_with_name)
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def by_uid!(uid_with_name)
      find_by!(uid: uid_with_name&.split('-')&.first)
    end
  end

  included do
    validates :uid, presence: true

    before_validation :generate_uid
  end

  def generate_uid
    self[:uid] ||= SecureRandom.hex(6)
  end
end
