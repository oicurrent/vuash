require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  context 'HTML' do
    describe 'GET #new' do
      it 'returns HTTP success' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST #create' do
      it 'returns HTTP success' do
        post :create, message: { data: '....' }
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET #show' do
      before { allow(Message).to receive(:find) { double }}

      it 'returns HTTP success' do
        get :show, id: 1
        expect(response).to have_http_status(:success)
      end
    end

    describe 'DELETE #destroy' do
      before { allow(Message).to receive(:destroy) { double }}

      it 'returns HTTP success' do
        delete :destroy, id: 1
        expect(response).to have_http_status(:success)
      end
    end
  end

  context 'JSON' do
    describe 'POST #create' do
      it 'returns HTTP success' do
        post :create, message: { data: '....' }, format: :json
        body = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(body['id'].size > 0).to be true
      end
    end

    describe 'DELETE #destroy' do
      it 'returns raw data' do
        m = Message.create(data: '...')
        delete :destroy, id: m.id, format: :json
        body = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(body['data'].size > 0).to be true
      end

      it "returns error when message doesn't exist" do
        delete :destroy, id: 'INEXISTENT', format: :json
        expect(response.body).to be_empty
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
