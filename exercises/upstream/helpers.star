load("@ytt:data", "data")

def image_reference(name):
    for item in data.values.imageVersions:
      if item.name == name:
        return item.image
      end
    end
end
