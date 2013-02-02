if Rails.env.development?
  envfile = Rails.root.join(".local_env")

  if envfile.exist?
    envfile.open("r").each do |line|
      key, val = line.split("=", 2)
      ENV[key] = val
    end
  end
