Deploying containerized applications to Kubernetes clusters which are
disconnected from the public internet can be a challenge.

The main challenge is that deployment resources for applications are typically
hardwired to pull container images from image registries on the public
internet. In a disconnected environment this will not be possible.

In order to deploy such an application it is necessary to first copy all
required container images for the application to an image registry hosted
within the network of the disconnected environment. The deployment resources
then need to be modified to pull images from the internal image registry
instead. If the internal image registry requires authentication, the
deployment resources will also need to be modified to include image pull
secrets holding the login credentials for the image registry, and deployments
setup to use the image pull secrets.

These steps may be further complicated if the application is a Kubernetes
operator which creates resources for deploying other applications, as details
of the images used may be packaged up as part of the container image for
the operator and not readily accessible.

To explore some of these issues this workshop will explore what would be
required to allow the Educates operator to be deployed in a disconnected
environment.
