# Readme for jenv

This is jenv's configuration directory which enables the use of multiple versions of Java.

## How to use

Enable the export plugin

```shell
$ jenv enable-plugin export
```

Add the Java runtime environment to jenv.

```shell
$ jenv add /Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home/
$ jenv add /Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home/
...
```

Set global default Java runtime.

```shell
$ jenv global 21
```

