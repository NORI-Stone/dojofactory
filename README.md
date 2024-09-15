# Dojo Factory

## Overview
武道等の流派を管理するDAO.
館長、支部長、指導員が登録でき、流派ごとに昇級制度を持つ。
入門生の過去の別道場での履歴を参照して引き継ぐことができる。
支部の管理や除名なども行うことができる。

# Deploy
`forge script script/deployment/Deploy.s.sol --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> --broadcast`

# 展望
支部未満の単位が自発的に活動場所を広げられる等

---

# Meta Contract Template
Welcome to the Meta Contract Template! This template is your fast track to smart contract development, offering a pre-configured setup with the [Meta Contract](https://github.com/metacontract/mc) framework and essential tools like the [ERC-7201 Storage Location Calculator](https://github.com/metacontract/erc7201). It's designed for developers looking to leverage advanced features and best practices right from the start.

## Quick Start
Ensure you have [Foundry](https://github.com/foundry-rs/foundry) installed, then initialize your project with:
```sh
$ forge init <Your Project Name> -t metacontract/template
```
This command sets up your environment with all the benefits of the meta contract framework, streamlining your development process.

## Features
- Pre-integrated with meta contract for optimal smart contract development with highly flexible upgradeability & maintainability.
- Includes ERC-7201 Storage Location Calculator for calculating storage locations based on ERC-7201 names for enhanced efficiency.
- Ready-to-use project structure for immediate development start.

For detailed documentation and further guidance, visit [Meta Contract Book](https://mc-book.ecdysis.xyz/).

Start building your decentralized applications with meta contract today and enjoy a seamless development experience!
