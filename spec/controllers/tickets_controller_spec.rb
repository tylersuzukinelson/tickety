require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  let(:ticket) { create(:ticket) }
  let(:ticket_1) { create(:ticket) }

  describe "#index" do
    it "assigns a tickets instance" do
      get :index
      expect(assigns(:tickets)).to eq([ticket, ticket_1])
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#create" do
    context "with valid request" do
      def valid_request
        post :create, { ticket: {
            title: 'New ticket',
            body: 'This is the body'
          } }
      end
      it "creates a new ticket record in the database" do
        expect{ valid_request }.to change{ Ticket.count }.by(1)
      end
      it "redirects to the show page" do
        valid_request
        expect(response).to redirect_to(ticket_path(Ticket.last))
      end
    end
    context "with invalid request" do
      def invalid_request
          post :create, { ticket: {
            title: '',
            body: ''
          } }
      end
      it "doesn't create a new ticket record" do
        expect{ invalid_request }.to change{ Ticket.count }.by(0)
      end
      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#new" do
    before {
      get :new
    }
    it "assigns a new ticket instance" do
      expect(assigns(:ticket)).to be_a_new(Ticket)
    end
    it "renders the new template" do
      expect(response).to render_template(:new)
    end
  end

  describe "#edit" do
    before {
      get :edit, id: ticket.id
    }
    it "assigns a ticket instance as per the passed id" do
      expect(assigns(:ticket)).to eq(ticket)
    end
    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end
  end

  describe "#show" do
    before {
      get :show, id: ticket.id
    }
    it "assigns a ticket instance as per the passed id" do
      expect(assigns(:ticket)).to eq(ticket)
    end
    it "renders the show template" do
      expect(response).to render_template(:show)
    end
  end

  describe "#update" do
    context "with valid request" do
      before do
        patch :update, id: ticket.id, ticket: {
            title: 'New ticket2',
            body: 'This is the body2'
          }
      end
      it "changes the title of the ticket in the database" do
        ticket.reload
        expect(ticket.title).to eq('New ticket2')
      end
      it "redirects to the show page" do
        expect(response).to redirect_to(ticket_path(ticket))
      end
    end
    context "with invalid request" do
      before do
        patch :update, id: ticket.id, ticket: {
            title: '',
            body: ''
          }
      end
      it "doesn't change the title of the ticket in the database" do
        ticket.reload
        expect(ticket.title).not_to eq('')
      end
      it "renders the edit page" do
        expect(response).to render_template(:edit)
      end
      it "sets a flash alert message" do
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#destroy" do
    let!(:ticket) { create(:ticket) }
    def destroy_request
      delete :destroy, id: ticket.id
    end
    it "deletes the ticket from the database" do
      expect{ destroy_request }.to change{ Ticket.count }.by(-1)
    end
    it "redirects to the index page" do
      destroy_request
      expect(response).to redirect_to(tickets_path)
    end
  end

end
