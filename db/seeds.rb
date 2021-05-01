alice = User.create(
  full_name: 'Alice',
  phone: '01'
)

bob = User.create(
  full_name: 'Bob',
  phone: '02'
)

Loan.create(
  lender: alice,
  borrower: bob,
  title: 'Ravage'
)
