gem 'activerecord', '>~ 3.8'
gem 'sqlite3'

template 'activerecord/models.rb', 'models.rb'
template 'activerecord/migrate', 'migrate'

chmod 'migrate', 0755
