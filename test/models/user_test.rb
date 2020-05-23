require "test_helper"

describe User do
  before do
    @user = users(:user1)
    @invalid_user = User.new(username: nil)
  end

  describe 'validations' do

    it 'is valid when username is present' do
      result = @user.valid?
      expect(result).must_equal true
    end

    it 'is invalid when username is not present' do
      result = @invalid_user.valid?
      @user.username = nil
      expect(result).must_equal false
      expect(@user.valid?).must_equal false
    end

  end

  describe 'relationships' do
    before do
      @user_votes = @user.votes
      @user_works = @user.works
    end
    it 'relates to votes' do
      
      expect(@user_votes.count).must_equal 0
      vote = Vote.create(work_id: works(:movie1).id, user_id: @user.id)
      expect(@user_votes.count).must_equal 1
    end

    it 'relates to works' do

      expect(@user_works.count).must_equal 0
      vote = Vote.create(work_id: works(:movie1).id, user_id: @user.id)
      expect(@user_works.count).must_equal 1
    end

  end
end
