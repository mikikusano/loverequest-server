class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    omniauth = request.env['omniauth.auth']
    if omniauth.present?
      user = User.find_by_github_id(omniauth['uid'])
      unless user
        info = omniauth['info']
        credentials = omniauth['credentials']
        user = User.new(
          name: info['name'],
          github_id: omniauth['uid'],
          github_name: info['nickname'],
          github_token: credentials['token'],
          image_url: info['image']
        )
        user.save!
        binding.pry
      end
      sign_in(:user, user)
      redirect_to new_question_path
    else
      redirect_to root_path
    end
  end
end
