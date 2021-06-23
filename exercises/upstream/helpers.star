load("@ytt:data", "data")
load("@ytt:base64", "base64")
load("@ytt:json", "json")

def image_reference(name):
    for item in data.values.imageVersions:
      if item.name == name:
        return item.image
      end
    end
end

def image_pull_policy(image):
  tag = image.split(":")
  always = len(tag) <= 1 or tag[-1] in ["latest", "main", "master", "develop"]
  return always and "Always" or "IfNotPresent"
end

def docker_config_json(hostname, username, password):
  return json.encode({
    "auths": {
      hostname: {
        "auth": base64.encode("{}:{}".format(username, password))
      }
    }
  })
end
