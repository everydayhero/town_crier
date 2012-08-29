module TownCrier
  module Lint
    module Tests
      def test_responds_to_publish
        assert model.respond_to?(:publish), "Must respond to #publish"
      end
    end
  end
end
