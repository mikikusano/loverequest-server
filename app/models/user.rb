# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  github_id           :string(255)
#  github_name         :string(255)
#  github_token        :string(255)
#  image_url           :string(255)
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0)
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :string(255)
#  last_sign_in_ip     :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class User < ActiveRecord::Base
  # Available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # :database_authenticatable, :registerable,
  # :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :github_id, :github_name, :github_token, :image_url

  def octokit
    return @octokit unless @octokit.nil?
    @octokit = Octokit::Client.new(login: github_name, oauth_token: github_token)
    return @octokit
  end

  # return repo
  def fork_loverequest
    octokit.fork("wantedly/loverequest")
  end

  # return repo
  def loverequest
    octokit.repository(github_name + "/loverequest")
  end

  # return blob
  def current_check_spec_file
    octokit.contents(loverequest, ref: "master", path: "spec/check_spec.rb")
  end

  # return blob
  def create_blob(content)
    octokit.create_blob(loverequest, content)
  end

  def current_spec_tree
    parent_contents = current_tree
    parent_contents.tree.each do |blob_or_tree|
      return blob_or_tree if blob_or_tree.path == "spec"
    end
    nil
  end

  def create_spec_blob_and_get_tree(content, file_name)
    new_trees = []
    blob = create_blob(content)
    new_trees.push({ path: file_name, mode: 100644, type: "blob", sha: blob })
    octokit.create_tree(loverequest, new_trees, base_tree: master_tree.sha)
  end

  def create_spec_blob_and_commit(content, file_name, message)
    tree = create_spec_blob_and_get_tree(content, file_name)
    octokit.create_commit(loverequest, message, tree.sha, master_commit.sha)
  end

  def create_spec_blob_and_commit_master(content, file_name, message)
    commit = create_spec_blob_and_commit(content, file_name, message)
    octokit.update_ref(loverequest, "heads/master", commit.sha)
  end

  def master_tree
    octokit.tree(loverequest, "master")
  end

  def master_commit
    octokit.commit(loverequest, "master")
  end

  def loverequest
    github_name + "/loverequest"
  end
end
