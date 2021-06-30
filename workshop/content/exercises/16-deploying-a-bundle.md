With the bundle now being hosted on the image registry, the image registry
acts as the distribution mechanism for the resources and configuration
required for deploying the application.

In this case the container images specific to the application are still hosted
elsewhere, but more often than not they would be hosted on the same image
registry.

In order to now install the application using the configuration bundle, rather
than the normal sort of situation where you may download a tarball with
configuration from a web site, check out a git repository, or even deploy
using a single resource file pulled from a web site, with a configuration
bundle you first need to copy the bundle from the image registry to your local
file system.

So imagining for a moment that we didn't already have the configuration
locally already, to download the configuration bundle run:

```terminal:execute
command: imgpkg pull -b {{registry_host}}/educates-copy:21.05.10.1 -o educates-public
```

In this case we are naming the download directory ``educates-public``. The
``-public`` suffix is to highlight that this bundle is still dependent on you
being connected to the public internet where the container images the
application requires are hosted.

To see the contents of the directory created run:

```terminal:execute
command: tree educates-public
```

You will see that the structure and the files in it are the same as what were
in the original ``packages/educates/bundle`` directory the configuration
bundle was created from.

Before we can deploy Educates using the download bundle, we first need to
delete the existing deployment. This can be done by running:

```terminal:execute
command: kapp delete -a educates -y
```

You will see here one of the other benefits of using ``kapp``. Because
``kapp`` tracks what resources it created, it is able to delete the
application without needing to have access to the original configuration
files, albeit this was possible in this case as it was self contained and
didn't require a separate step to create the namespace it used as a separate
step.

Once the original Educates deployment has to deleted, re-deploy it again,
this time using the command:

```terminal:execute
command: |
  ytt -f educates-copy/config -v ingressDomain={{ingress_domain}} \
    kbld -f educates-copy/kbld-bundle.yml -f educates-copy/.imgpkg/images.yml -f - | \
    kapp deploy -a educates -f - -y
```
