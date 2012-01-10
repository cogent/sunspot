module Sunspot
  module Rails
    class StubSessionProxy
      attr_reader :original_session

      def initialize(original_session)
        @original_session = original_session
        @connectionless_session = ConnectionlessSession.new
      end

      def index(*objects)
      end

      def index!(*objects)
      end

      def remove(*objects)
      end

      def remove!(*objects)
      end

      def remove_by_id(clazz, id)
      end

      def remove_by_id!(clazz, id)
      end

      def remove_all(clazz = nil)
      end

      def remove_all!(clazz = nil)
      end

      def dirty?
        false
      end

      def delete_dirty?
        false
      end

      def commit_if_dirty
      end

      def commit_if_delete_dirty
      end

      def commit
      end

      def new_search(*types, &block)
        @connectionless_session.new_search(*types, &block).extend(SearchStub)
      end

      def search(*types, &block)
        # No need to execute, right!
        new_search(*types, &block)
      end

      def new_more_like_this(*args, &block)
        @connectionless_session.new_more_like_this(*args, &block).extend(SearchStub)
      end

      class ConnectionlessSession < Sunspot::Session

        def connection
          nil
        end

      end

      module SearchStub

        def results
          PaginatedCollection.new
        end

        def hits(options = {})
          PaginatedCollection.new
        end

        def total
          0
        end

        def facet(name)
        end

        def dynamic_facet(name)
        end

        def execute
          self
        end
      end

      class PaginatedCollection < Array

        def total_count
          0
        end
        alias :total_entries :total_count

        def current_page
          1
        end

        def per_page
          30
        end
        alias :limit_value :per_page

        def total_pages
          1
        end
        alias :num_pages :total_pages

        def first_page?
          true
        end

        def last_page?
          true
        end

        def previous_page
          nil
        end

        def next_page
          nil
        end

        def out_of_bounds?
          false
        end

        def offset
          0
        end

      end

    end
  end
end
