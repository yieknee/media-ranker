require "test_helper"

describe Work do
  describe 'validations' do
    before do
      @work = Work.create!(title:'test work')
      @invalid_work = Work.new(category: 'movie')
    end

    it 'is valid when title is present' do
      result = @work.valid?
      expect(result).must_equal true
    end

    it 'is invalid when title is not present' do
      result = @invalid_work.valid?
      @work.title = nil
      expect(result).must_equal false
      expect(@work.valid?).must_equal false
    end

    it 'will not allow you to create a work in the same category with the same title' do
      expect(Work.create(title:'test work').valid?).must_equal false
    end
  end
end
