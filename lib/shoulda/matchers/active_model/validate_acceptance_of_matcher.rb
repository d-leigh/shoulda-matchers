module Shoulda
  module Matchers
    module ActiveModel
      # The `validate_acceptance_of` matcher tests usage of the
      # `validates_acceptance_of` validation.
      #
      #     class Registration
      #       include ActiveModel::Model
      #       attr_accessor :eula
      #
      #       validates_acceptance_of :eula
      #     end
      #
      #     # RSpec
      #     RSpec.describe Registration, type: :model do
      #       it { should validate_acceptance_of(:eula) }
      #     end
      #
      #     # Minitest (Shoulda)
      #     class RegistrationTest < ActiveSupport::TestCase
      #       should validate_acceptance_of(:eula)
      #     end
      #
      # #### Qualifiers
      #
      # ##### on
      #
      # Use `on` if your validation applies only under a certain context.
      #
      #     class Registration
      #       include ActiveModel::Model
      #       attr_accessor :terms_of_service
      #
      #       validates_acceptance_of :terms_of_service, on: :create
      #     end
      #
      #     # RSpec
      #     RSpec.describe Registration, type: :model do
      #       it do
      #         should validate_acceptance_of(:terms_of_service).
      #           on(:create)
      #       end
      #     end
      #
      #     # Minitest (Shoulda)
      #     class RegistrationTest < ActiveSupport::TestCase
      #       should validate_acceptance_of(:terms_of_service).on(:create)
      #     end
      #
      # ##### with_message
      #
      # Use `with_message` if you are using a custom validation message.
      #
      #     class Registration
      #       include ActiveModel::Model
      #       attr_accessor :terms_of_service
      #
      #       validates_acceptance_of :terms_of_service,
      #         message: 'You must accept the terms of service'
      #     end
      #
      #     # RSpec
      #     RSpec.describe Registration, type: :model do
      #       it do
      #         should validate_acceptance_of(:terms_of_service).
      #           with_message('You must accept the terms of service')
      #       end
      #     end
      #
      #     # Minitest (Shoulda)
      #     class RegistrationTest < ActiveSupport::TestCase
      #       should validate_acceptance_of(:terms_of_service).
      #         with_message('You must accept the terms of service')
      #     end
      #
      # @return [ValidateAcceptanceOfMatcher]
      #
      def validate_acceptance_of(attr)
        ValidateAcceptanceOfMatcher.new(attr)
      end

      # @private
      class ValidateAcceptanceOfMatcher < ValidationMatcher
        def initialize(attribute)
          super
          @expected_message = :accepted
        end

        def simple_description
          "validate acceptance of :#{attribute}"
        end

        protected

        def add_submatchers
          add_submatcher_disallowing(false, expected_message)
        end

        private

        attr_reader :expected_message
      end
    end
  end
end
