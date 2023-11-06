class TransactionsController < ApplicationController
  before_action :transaction_type, only: [:new, :create]

  def index
    @transactions = Transaction.includes(:manager).all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(create_params)

    if @transaction.save
      redirect_to @transaction
    else
      render :new
    end
  end

  private

  def transaction_type
    @transaction_type = params[:type]
  end

  def create_params
    params.require(:transaction).permit(:first_name, :last_name, :from_amount, :from_currency, :to_currency)
  end
end
