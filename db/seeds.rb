# seeds.rb

# Create Users
user1 =
  User.create!(
    provider: 'email',
    uid: 'user1@example.com',
    email: 'user1@example.com',
    first_name: 'Jonatan',
    last_name: 'Leandoer',
    status: 'active',
    department: 'WebDev',
    studies: 'Computer Science',
    is_admin: false,
    balance: 25.0,
    username: 'Jonatan Leandoer'
  )

user2 =
  User.create!(
    provider: 'email',
    uid: 'user2@example.com',
    email: 'user2@example.com',
    first_name: 'Benjamin',
    last_name: 'Reichwald',
    status: 'active',
    department: 'Marketing',
    studies: 'Business Administration',
    is_admin: false,
    balance: 333,
    username: 'Benjamin Reichwald'
  )

# Create Bets
bet1 =
  Bet.create!(
    owner_id: user1.id,
    title: 'Notenschnitt GML',
    description: 'Ist der Notenschnitt unter 3.0 in GML?',
    minimum_fee: 4.0,
    public: true,
    winning_condition: 'Wenn der Notenschnitt < 3.0 ist.'
  )

bet2 =
  Bet.create!(
    owner_id: user2.id,
    title: 'Regnet an Weinachten',
    description: 'Wird es zu Weinachten regenen?',
    minimum_fee: 2.0,
    public: true,
    winning_condition: 'Wenn es zu weinachten regnet.'
  )

# Create Participations
participation1 =
  Participation.create!(
    bet_id: bet1.id,
    owner_id: user2.id,
    fee: 15,
    message: 'Niemals',
    anonymous: false,
    outcome: false
  )

participation2 =
  Participation.create!(
    bet_id: bet2.id,
    owner_id: user1.id,
    fee: 25,
    message: 'Ich hoffe schon.',
    anonymous: false,
    outcome: true
  )
