BankAccount = {
  account_number = 0,
  holder_name = '',
  balance = 0.0
}

function BankAccount:deposit(amount)
  self.balance = self.balance + amount
end

function BankAccount:withdraw(amount)
  self.balance = self.balance - amount
end

function BankAccount:new(table)
  table = table or {}
  setmetatable(table, self)
  self.__index = self
  return table
end

------------------------------------
-- Create a table
------------------------------------

johns_account = BankAccount:new({
  account_number = 12345,
  holder_name = 'John Coltrane',
  balance = 0.0
})

print('New account object...')
print(johns_account.balance)

johns_account:deposit(400.00)

print(johns_account.balance)

johns_account:withdraw(50.00)

print(johns_account.balance)