require "spec_helper"
require "rails_finder/app"

module RailsFinder
  describe App do
    it "knows path basname" do
      with_dir do |dir|
        path = File.join(dir, "awesome_app")
        Dir.mkdir(path)
        App.new(path).basename.should == "awesome_app"
      end
    end

    it "reports Rails version from Gemfile" do
      subject = App.new(stub)
      subject.stub(gemfile: stub(exists?: true, rails_version: "3.2.11"))
      subject.stub(envfile: stub(exists?: true, rails_version: "n/a"))
      subject.rails_version.should == "3.2.11"
    end

    it "reports Rails version from environment file" do
      subject = App.new(stub)
      subject.stub(gemfile: stub(exists?: false, rails_version: "n/a"))
      subject.stub(envfile: stub(exists?: true, rails_version: "2.3.16"))
      subject.rails_version.should == "2.3.16"
    end

    it "reports n/a when no Rails version is found" do
      subject = App.new(stub)
      subject.stub(gemfile: stub(exists?: false))
      subject.stub(envfile: stub(exists?: false))
      subject.rails_version.should == "n/a"
    end
  end
end
