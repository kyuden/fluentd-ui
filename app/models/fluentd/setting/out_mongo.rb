class Fluentd
  module Setting
    class OutMongo
      include Common

      KEYS = [
        :match,
        :host, :port, :database, :collection, :capped, :capped_size, :capped_max, :user, :password, :tag_mapped,
        :buffer_type, :buffer_queue_limit, :buffer_chunk_limit, :flush_interval,  :retry_wait, :retry_limit, :max_retry_wait, :num_threads,
      ].freeze

      attr_accessor(*KEYS)

      flags :capped, :tag_mapped

      validates :match, presence: true
      validates :host, presence: true
      validates :port, presence: true
      validates :database, presence: true
      validate :validate_capped
      validate :validate_collection

      def validate_capped
        return true if capped.blank?
        errors.add(:capped_size, :blank) if capped_size.blank?
      end

      def validate_collection
        if tag_mapped.blank? && collection.blank?
          errors.add(:collection, :blank) 
        end
      end
    end
  end
end
