class PriceRange < ActiveHash::Base
  self.data = [
      {id: 300, name: '300 ~ 1,000'},
      {id: 1000, name: '1,000 ~ 5,000'},
      {id: 5000, name: '5,000 ~ 10,000'},
      {id: 10000, name: '10,000 ~ 30,000'},
      {id: 30000, name: '30,000 ~ 50,000'},
      {id: 50000, name: '50,000 ~'}
  ]
end