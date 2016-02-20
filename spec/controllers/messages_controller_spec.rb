require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'returns http success' do
      post :create, message: { data: '....' }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    before { allow(Message).to receive(:find) { double }}

    it 'returns http success' do
      get :show, uuid: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    let(:message) { double }
    before { allow(Message).to receive(:find_by!) { message }}
    before { allow(message).to receive(:destroy) { message }}

    it 'returns http success' do
      delete :destroy, uuid: 1
      expect(response).to have_http_status(:success)
    end
  end

end
