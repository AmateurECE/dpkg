# Building packages

Two forms:

```bash
# Second form. Builds without a source package
cd <package>-<version> && dpkg-buildpackage --no-sign -A
```

The following packages are meant to be built with the second form:

```
ssh-agent-service
```
