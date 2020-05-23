require "test_helper"

describe Vote do
  before do
    @work = works(:movie1)
    @user = users(:user3)
    @vote = Vote.create(work_id: @work.id, user_id: @user.id)
    @invalid_vote = Vote.new(work_id: nil)
  end

  describe 'validations' do

    it 'is valid when user_id and work_id are present' do
      result = @vote.valid?
      expect(result).must_equal true
    end

    it 'is invalid when votename is not present' do
      result = @invalid_vote.valid?
      @vote.user_id = nil
      expect(result).must_equal false
      expect(@vote.valid?).must_equal false
    end

  end

  describe 'relationships' do
    before do
      @vote_user = @vote.user
      @vote_work = @vote.work
    end
    it 'relates to user' do
      expect(@vote_user).must_equal @user
    end

    it 'relates to work' do
      expect(@vote_work).must_equal @work
    end

  end
end
