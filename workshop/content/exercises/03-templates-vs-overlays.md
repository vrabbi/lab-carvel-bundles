The two main ways that deployment resources are usually provided for deploying
applications to Kubernetes is as raw Kubernetes resources, or as Helm charts.

If using Helm it is an "all or nothing" approach.

That is, you have to buy in completely to the Helm way of doing things and
the resources have to be constructed from the ground up as templates specific
to the Helm templating tool.

In the case of raw Kubernetes resources, they are just that, unmodified
Kubernetes resources which you can feed directory to Kubernetes using the
``kubectl apply`` command.

In the case of the Educates package we are using as the subject of this
workshop, it provides a set of raw resources which can be used as is to deploy
a development version of the Educates operator, but also provides
configuration resources for Kustomize, which uses overlays and resource
generators, to create a final customized set of deployment resources for a
production deployment.

For this workshop we will be using the Carvel ``ytt`` tool. This tool embodies
both the template features of Helm charts, and the abilities of Kustomize to
modify an existing set of raw Kubernetes resources using overlays.

Because the ``ytt`` tool allows us to customize through overlays an existing
set of deployment resources for an application, without needing to modify the
originals, it makes it much easier to keep aligned with the upstream version
of the deployment resources for the application we want to customize.

The ``ytt`` tool will not be the only Carvel tool we will be using and this
is an important point one needs to understand about Carvel. That is, it is a
set of tools where each is designed to perform a specific task.

Much like how you can chain basic UNIX tools together, the Carvel tools can be
composed together to achieve a range of different end goals. The philosophy
around the tools and how they are used is therefore much different to single
purpose tools such as Helm and Kustomize. 
