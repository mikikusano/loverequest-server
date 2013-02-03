class TravisController < ActionController::Base
  def callback
    payload = params["payload"]
    branch = payload["branch"]
    author_name = payload["author_name"]


    client = current_user.octokit
    pull_requests = client.pull_requests(Rails.configuration.ref)

    number = nil
    pull_requests.each do |pull_request|
      now_state = pull_request["state"]
      base = pull_request["base"]
      head = pull_request["head"]
      if base["ref"] != "gh-pages" || now_state != "open"
        next
      end
      if branch == head["ref"]
        number = pull_request["number"]
      end
    end

    if number.nil?
      render json: {text: "fail"}
      return
    end

    if payload["status_message"] == "Broken"
      client.add_comment(Rails.configuration.ref, number, "bye")
      client.update_pull_request(Rails.configuration.ref, number, nil, nil, "closed")
    elsif payload["status_message"] == "Passed"
      client.merge_pull_request(Rails.configuration.ref, number)
    end
    render json: {text: "success", number: number, branch: branch}
  end
end
