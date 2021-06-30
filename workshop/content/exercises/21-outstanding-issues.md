This completes the tour so far on exploring how the Carvel tools can be used
to enable the ability of an application to be installed to a Kubernetes
cluster running in a disconnected environment. We aren't done yet and the
workshop will be added to later to explore further how Carvel could be use
to improve the deployment experience for Educates.

Topics which will be covered later will include:

* Using the upcoming package bundling and installation APIs provided by
  ``kapp-controller`` from the Carvel tools.

* Exploration of how bundles could be used to package up Educates workshops,
  including the workshop content, custom workshop base images, or images
  required by steps executed as part of the workshop instructions.

Educates itself also needs be modified to support running all types of
workshops in a disconnected environment. Right now it wouldn't be possible to
run a workshop in a disconnected environment which enabled the ability to run
``docker`` or which required an image registry for workshop sessions.

The problem here is that although Educates exposes details about the training
portal and workshop base images through the configuration, internally it still
has references to the container images for docker in docker, and the docker
image registry hardwired. These also need to be extracted out and configured
via the config map to enable full ability to use Educates in a disconnected
environment.
