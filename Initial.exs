defmodule Expense do
  defstruct [:name, :category, :amount]
end

defmodule ExpenseTracker do
  def new do
    []
  end

  def add_expense(expenses, name, category, amount) do
    [%Expense{name: name, category: category, amount: amount} | expenses]
  end

  def total(expenses) do
    Enum.reduce(expenses, 0, fn expense, total ->
      total + expense.amount
    end)
  end

  def average(expenses) do
    if expenses == [] do
      0
    else
      total(expenses) / length(expenses)
    end
  end

  def print_report(expenses) do
    expenses
    |> Enum.reverse()
    |> Enum.each(fn expense ->
      IO.puts(
        "#{expense.name} | #{expense.category} | $#{:erlang.float_to_binary(expense.amount, decimals: 2)}"
      )
    end)

    IO.puts("================")
    IO.puts("Total: $#{:erlang.float_to_binary(total(expenses), decimals: 2)}")
    IO.puts("Average: $#{:erlang.float_to_binary(average(expenses), decimals: 2)}")
  end
end

expenses = ExpenseTracker.new()

expenses = ExpenseTracker.add_expense(expenses, "Rent", "Housing", 1200.00)
expenses = ExpenseTracker.add_expense(expenses, "Groceries", "Food", 350.75)
expenses = ExpenseTracker.add_expense(expenses, "Transport", "Travel", 180.50)
expenses = ExpenseTracker.add_expense(expenses, "Internet", "Utilities", 65.99)

IO.puts("Expense Report")
IO.puts("==============")

ExpenseTracker.print_report(expenses)