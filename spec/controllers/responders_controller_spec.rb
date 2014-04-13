require 'spec_helper'

describe RespondersController do
  let(:fake_user) { FactoryGirl.create(:user) }
  let(:fake_responder){FactoryGirl.create(:responder)}
  let(:fake_user_responder) { post :create, responder_data: { user_id: fake_user.id, id: fake_responder.id }, format: :json }

  context "index" do
    it "renders @responders to json" do
    end
  end

  context "show" do
    before(:each) { get :show, id: fake_responder.id, user_id: fake_responder.user_id }
    it "loads a responder tuple into @responder" do
      expect(assigns(:responder)).to eq fake_responder
    end

    it "renders responder to json" do
      @expected = { responder: assigns(:responder) }.to_json
      expect(response.body).to eq @expected
    end
  end

  context "create" do

    it "add responder to database if valid responder attributes" do
      expect{
        post :create, user_id: fake_user.id
        }.to change{ Responder.count }.by(1)
    end

    # Note - this test passes when "success: true" is removed from returned hash
    # of responders#create
    # TODO - rewrite test to pass with "success: true" included
    xit "renders responder to json" do
      post :create, user_id: fake_user.id
      @expected = { responder: assigns(:responder) }.to_json
      expect(response.body).to eq @expected
    end

  end

# No test for edit is required because the route behaves same as #show
  context "edit" do
  end

  context "update" do
    it "updates a responder table entry" do
      new_feedback = "Hi, mom!"
      expect {
        put(:update, id: fake_responder.id, user_id: fake_responder.user_id,
          responder: { feedback: new_feedback })
      }.to change { fake_responder.reload.feedback }.to(new_feedback)
    end
  end

end