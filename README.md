# Foundry Starter Kit
based on <https://docs.dcipher.network/quickstart/randomness/#3-create-a-randomness-consumer-contract>

## TODO
- remove examples which come with plain `forge init`
- add the command to `forge init` this as the template
- adapt deployment facilities
- testing is a TODO too
- check other things to adapt into this

## Getting Started

### Requirements

Please install the following:

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you've done it right if you can run `git --version`
- [Foundry / Foundryup](https://github.com/gakonst/foundry)
  - This will install `forge`, `cast`, and `anvil`
  - You can test you've installed them right by running `forge --version` and get an output like: `forge 0.2.0 (f016135 2022-07-04T00:15:02.930499Z)`
  - To get the latest of each, just run `foundryup`

### Quickstart

```sh
git clone https://github.com/skaunov/foundry-vrf-kit
cd foundry-vrf-kit
```

### Install dependencies as follows:

Run `forge install` to install dependencies. [Foundry uses git submodules](https://book.getfoundry.sh/projects/dependencies) as its dependency management system.

> ⚠️  when running `forge install`, you may see an error message if you have uncomitted changes in your repo.  Read the message carefully - it may inform you that you can add the `--no-commit` flag to each of these `install` commands if your workspace has uncommitted changes.

You can update dependencies by running `forge update`.

### TODO Testing
To check that everything is compiling and working as intended after cloning and installing dependencies, run `forge test`. All tests should pass.
