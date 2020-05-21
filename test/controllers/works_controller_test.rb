require "test_helper"

describe WorksController do
  describe "index" do
    it "responds with success when there are works saved" do
     
      work = works(:winnie_the_pooh)

      get(works_path)
     
      must_respond_with :success
    end

    it "responds with success when there are no works saved" do
     
      Work.delete_all

      get(works_path)
     
      must_respond_with :success
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
