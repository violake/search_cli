require 'rspec'
require 'data_query/json_query'

RSpec.describe JsonQuery do
  let(:data) do
    [
      { id: 1, name: 'John Doe', email: 'john@example.com' },
      { id: 2, name: 'Jane Smith', email: 'jane@example.com' },
      { id: 3, name: 'Alice Johnson', email: 'john@example.com' },
      { id: 4, name: 'Bob Brown', email: 'bob@example.com' }
    ]
  end

  let(:json_query) { JsonQuery.new(data) }

  describe '#find_all' do
    it 'returns item with fuzzy query for email (case insensitive)' do
      results = json_query.find_all(:email, 'john')
      expect(results).to eq([
                              { id: 1, name: 'John Doe', email: 'john@example.com' },
                              { id: 3, name: 'Alice Johnson', email: 'john@example.com' }
                            ])
    end

    it 'returns item with fuzzy query for name (case insensitive)' do
      results = json_query.find_all(:name, 'john')
      expect(results).to eq([
                              { id: 1, name: 'John Doe', email: 'john@example.com' },
                              { id: 3, name: 'Alice Johnson', email: 'john@example.com' }
                            ])
    end

    it 'returns empty if no match' do
      results = json_query.find_all(:email, 'nonexistent')
      expect(results).to eq([])
    end
  end

  describe '#find_duplicate_data' do
    it 'returns duplicate items' do
      duplicates = json_query.find_duplicate_data(:email)
      expect(duplicates).to eq({
                                 'john@example.com' => [
                                   { id: 1, name: 'John Doe', email: 'john@example.com' },
                                   { id: 3, name: 'Alice Johnson', email: 'john@example.com' }
                                 ]
                               })
    end

    it 'return empty hash if no match' do
      duplicates = json_query.find_duplicate_data(:name)
      expect(duplicates).to eq({})
    end
  end
end
