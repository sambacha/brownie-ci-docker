# Brownie 

ethereum brownie as a CI service

### Supported tags and respective `Dockerfile` links

#{range $_, $v := .Versions}

#### #{$v.Version}

`#{range $_, $b := $v.Builds}`

 * `#{$b.Tag}`#{range $_, $t := $b.Base.AdditionalTags}, `#{$t}`#{end} [(#{$b.Base.Base}/Dockerfile)](https://github.com/solidity-ci/docker-kotlin/blob/master/#{$b.Base.Base}/Dockerfile)
#{end}#{end}

### What is Solidity

Solidity is a contract-oriented, high-level language for implementing smart contracts. It was influenced by C++, Python and JavaScript and is designed to target the Ethereum Virtual Machine (EVM).

Solidity is statically typed, supports inheritance, libraries and complex user-defined types among other features.


