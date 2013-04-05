require "spec_helper"

describe ContactMailer do
  describe "user" do
    let(:mail) { ContactMailer.user }

    it "renders the headers" do
      mail.subject.should eq("User")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "staff" do
    let(:mail) { ContactMailer.staff }

    it "renders the headers" do
      mail.subject.should eq("Staff")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
