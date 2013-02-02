class TravisController < ActionController::Base
  def callback
    puts params.to_json
    #client = Octokit::Client.new(:login => Rails.configuration.user, :password => Rails.configuration.password)
  end
end
