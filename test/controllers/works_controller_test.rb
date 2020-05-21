require "test_helper"

describe WorksController do
  before do
    @work = Work.create(title:'Where the Wild Things Are', creator: 'Maurice Sendak')
  end
  
  describe "index" do
    it "responds with success when there are works saved" do

      get(works_path)
     
      must_respond_with :success
    end

    it "responds with success when there are no works saved" do
     
      Work.delete_all

      get(works_path)
     
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid work" do

      get(work_path(@work.id))
      must_respond_with :success
    end

    it "responds with 404 with an invalid work id" do
      get(work_path(00000000))
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get(new_work_path)
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new work with valid information accurately, and redirect" do
      expect{post(works_path, params: {work:{title: 'Test'}})}.must_differ 'Work.count', 1
      must_respond_with :redirect
    end

    it "does not create a work if the form data violates work validations, and responds with rendering new form again" do
      expect{post(works_path, params: {work:{catergory:'book'}})}.wont_change 'Work.count'
      must_respond_with :bad_request
    end
  end
end
