class TravisController < ActionController::Base
  def callback
    payload = params["payload"]
    branch = payload["branch"]
    author_name = payload["author_name"]

    client = Octokit::Client.new(:login => Rails.configuration.user, :password => Rails.configuration.password)
    pull_requests = client.pull_requests(Rails.configuration.ref)

    number = nil
    pull_requests.each do |pull_request|
      now_state = pull_request["state"]
      base = pull_request["base"]
      head = pull_request["head"]
      if base["ref"] != "gh-page" || now_state != "open"
        return
      end
      if branch == head["ref"]
        number = pull_request["number"]
      end
    end

    if data["status_message"] == "Broken"
      client.update_pull_request(Rails.configuration.ref, number, "bye", "low score", "closed")
    elsif data["status_message"] == "Passed"
      client.merge_pull_request(Rails.configuration.ref, number)
    end
    render json: {text: "success", number: number, branch: branch}
  end
end
