set -o errexit

bundle isntall
bundle exec rake assets:precompile
bundle exec rake assets:clean
budnle exec rake db:migrate