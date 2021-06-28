When customizing resources for an application you aren't limited to just
modifying existing resources using overlays, you can also add additional
resources.

In this example using Educates a number of additional resources are added.

```terminal:execute
command: tree packages/educates/bundle/config/resources
```

Some of these are always created, such as the configuration for the Educates
operator:

```editor:open-file
file: ~/exercises/packages/educates/bundle/config/resources/system-profile.yaml
```

but others are only optionally added based on configuration supplied through
the data input values.

For the Educates example, this occurs for optional certificates used with
secure ingress, and image registry pull secrets when needing to deploy images
from a private registry.

Additional resources aren't restricted to those directly used by the
application being deployed, and can also include separate resources which can
improve on the usability of the application.

An example of that for Educates is a daemon set which pre-pulls workshop
images to nodes in the cluster in order to speed up workshop session start
times the first time a node in the cluster is used for a workshop session.

```editor:open-file
file: ~/exercises/packages/educates/bundle/config/resources/image-puller.yaml
```
