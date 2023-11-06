require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should get show" do
    transaction = transactions(:one)

    get transaction_url(transaction.id)
    assert_response :success
  end

  test "should get new" do
    Transaction::AVAILABLE_TRANSACTION_TYPES.each do |type|
      get new_transaction_url(type)
      assert_response :success
    end
  end

  test "should create small transaction" do
    assert_difference('Transaction.count') do
      post transactions_url, params: { transaction: {from_currency: 'USD', to_currency: 'AUD', from_amount: 50 }, type: 'small' }
    end

    assert_redirected_to transaction_url(Transaction.last)
  end

  test "should not create small transaction" do
    assert_no_difference('Transaction.count') do
      post transactions_url, params: { transaction: {from_currency: 'USD', to_currency: 'AUD', from_amount: 101 }, type: 'small' }
    end

    assert_response :success
  end

  test "should create large transaction" do
    assert_difference('Transaction.count') do
      post transactions_url, params: {
        transaction: {
            first_name: 'First',
            last_name: 'Last',
            from_currency: 'USD',
            to_currency: 'AUD',
            from_amount: 500
        }, type: 'large'
      }
    end

    assert_redirected_to transaction_url(Transaction.last)
  end

  test "should not create large transaction without names" do
    assert_no_difference('Transaction.count') do
      post transactions_url, params: {
        transaction: {
          from_currency: 'USD',
          to_currency: 'AUD',
          from_amount: 500
        }, type: 'large'
      }
    end

    assert_response :success
  end

  test "should not create large transaction with wrong amount" do
    assert_no_difference('Transaction.count') do
      post transactions_url, params: {
        transaction: {
            first_name: 'First',
            last_name: 'Last',
            from_currency: 'USD',
            to_currency: 'AUD',
            from_amount: [99, 1001].sample
        }, type: 'large'
      }
    end

    assert_response :success
  end

end
