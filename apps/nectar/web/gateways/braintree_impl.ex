defmodule Nectar.Billing.Gateways.BraintreeImpl do
  use Commerce.Billing.Gateways.Base

  alias Braintree.ClientToken
  alias Braintree.Transaction

  def authorize(amount, nonce, _options) do
    Transaction.sale(%{amount: amount, payment_method_nonce: nonce})
    |> respond
  end

  def generate_client_token do
    ClientToken.generate()
  end

  defp respond({:error, %Braintree.ErrorResponse{} = error}) do
    IO.puts inspect(error)
    {:error, "please check the card details"}
  end

  defp respond({:ok, %Braintree.Transaction{}}) do
    {:ok, "transaction successful"}
  end

end
