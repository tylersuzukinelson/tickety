class TicketsController < ApplicationController

  before_action :get_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @tickets = Ticket.all
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new ticket_params
    @ticket.user = current_user
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket }
        format.js { render }
      else
        format.html {
          flash[:alert] = get_errors
          render :new
        }
        format.js { render }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @ticket.update ticket_params
        format.html { redirect_to @ticket }
        format.js { render }
      else
        format.html {
          flash[:alert] = get_errors
          render :edit
        }
        format.js { render }
      end
    end
  end

  def destroy
    if @ticket.destroy
      redirect_to tickets_path
    else
      flash[:alert] = get_errors
      redirect_to @ticket
    end
  end

  private

  def get_ticket
    @ticket = Ticket.find params[:id]
  end

  def ticket_params
    params.require(:ticket).permit(:title, :body, :resolved_by)
  end

  def get_errors
    @ticket.errors.full_messages.join('; ')
  end

end
