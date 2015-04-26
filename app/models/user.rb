class User < ActiveRecord::Base
  authenticates_with_sorcery!

  as_enum :rank, bronze: 0, silver: 1, gold: 2, platinum: 3, diamond: 4, challenger: 5
  as_enum :role, adc: 0, support: 1, mid: 2, top: 3, jungle: 4
end