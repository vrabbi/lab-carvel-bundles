load("@ytt:data", "data")

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
