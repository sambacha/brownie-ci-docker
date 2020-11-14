# Pyownie

![Continuous Integration](https://github.com/sambacha/brownie-ci-docker/workflows/Continuous%20Integration/badge.svg)

![pipeline](https://github.com/sambacha/brownie-ci-docker/workflows/pipeline/badge.svg)


ethereum brownie as a CI service

### Supported tags and respective `Dockerfile` links

#{range $_, $v := .Versions}

#### #{$v.Version}

`#{range $_, $b := $v.Builds}`

 * `#{$b.Tag}`#{range $_, $t := $b.Base.AdditionalTags}, `#{$t}`#{end} [(#{$b.Base.Base}/Dockerfile)](https://github.com/solidity-ci/docker-kotlin/blob/master/#{$b.Base.Base}/Dockerfile)
#{end}#{end}

#### Env

`GITHUB_SHA`

```bash
GIT_COMMIT=$(git log -1 --format=%h)
```

```bash
$ git log -1 --format=%h
3d4d52f
```

```bash
git_hash=$(git rev-parse --short "$GITHUB_SHA")
git_branch=${GITHUB_REF##*/}
```

### 
Docker image push is only supported with a tag of the format :owner/:repo_name/:image_name.

Please add an image name to "sambacha/brownie-ci-docker" 
tag. e.g. "sambacha/brownie-ci-docker/<image_name>"
    #
     



### What is Solidity

Solidity is a contract-oriented, high-level language for implementing smart contracts. It was influenced by C++, Python and JavaScript and is designed to target the Ethereum Virtual Machine (EVM).

Solidity is statically typed, supports inheritance, libraries and complex user-defined types among other features.


