# Zomavan

A little app, helping us look briefly at the quaint restaurants, in the quiet suburb of Abbotsford, Victoria.

## Environment Setup

Zomavan uses Carthage to manage its dependencies.

One method of installing Carthage is to use [Brew][brew].

```
$ brew install carthage
```

With Carthage installed, prepare the dependencies. This will pull and build Zomavan's dependencies on your local machine (as they are not committed to the repository).

```
$ carthage bootstrap --no-use-binaries --platform iphoneos
```

<!-- LINKS -->

[brew]: https://brew.sh
