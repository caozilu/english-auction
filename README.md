# English Auction Smart Contract

这是一个基于以太坊的英式拍卖智能合约项目。该项目实现了一个完整的 NFT 拍卖系统，包括 NFT 合约和拍卖合约。

## 项目概述

项目包含两个主要合约：

1. `MyNFT.sol`: 一个基于 OpenZeppelin ERC721 标准的 NFT 合约
2. `EnglishAuction.sol`: 英式拍卖合约，用于管理 NFT 的拍卖流程

## 功能特性

- NFT 铸造和管理
- 完整的拍卖流程（开始、投标、结束）
- 支持提现未中标的投标金额
- 事件追踪（开始、投标、结束、提现）
- 所有权验证
- 自动化的 NFT 转移

## 项目设置和运行指南

### 前置条件

1. 安装 Foundry（如果还没有安装）

   ```shell
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

2. 克隆项目并安装依赖

   ```shell
   git clone <repository-url>
   cd english-auction-1
   forge install
   ```

### 合约部署流程

1. 编译合约

   ```shell
   forge build
   ```

2. 部署 NFT 合约

   ```shell
   forge script script/EnglishAuction.s.sol:DeployMyNFT --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast
   ```

3. 铸造 NFT

   ```shell
   cast send <NFT_CONTRACT_ADDRESS> "safeMint(address,uint256)" <RECIPIENT_ADDRESS> <TOKEN_ID> --rpc-url <your_rpc_url> --private-key <your_private_key>
   ```

4. 部署拍卖合约

   ```shell
   forge script script/EnglishAuction.s.sol:DeployEnglishAuction --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast
   ```

### 合约交互指南

1. 开始拍卖（仅限 NFT 所有者）

   ```shell
   cast send <AUCTION_CONTRACT_ADDRESS> "start(uint256,uint256)" <OPENING_BID> <DURATION> --rpc-url <your_rpc_url> --private-key <your_private_key>
   ```

2. 参与竞拍

   ```shell
   cast send <AUCTION_CONTRACT_ADDRESS> "bid()" --value <BID_AMOUNT> --rpc-url <your_rpc_url> --private-key <your_private_key>
   ```

3. 结束拍卖（仅限拍卖创建者）

   ```shell
   cast send <AUCTION_CONTRACT_ADDRESS> "end()" --rpc-url <your_rpc_url> --private-key <your_private_key>
   ```

4. 提现未中标的投标金额

   ```shell
   cast send <AUCTION_CONTRACT_ADDRESS> "withdraw()" --rpc-url <your_rpc_url> --private-key <your_private_key>
   ```

### 查询拍卖状态

1. 查询当前最高出价

   ```shell
   cast call <AUCTION_CONTRACT_ADDRESS> "highestBid()" --rpc-url <your_rpc_url>
   ```

2. 查询最高出价者

   ```shell
   cast call <AUCTION_CONTRACT_ADDRESS> "highestBidder()" --rpc-url <your_rpc_url>
   ```

3. 查询拍卖结束时间

   ```shell
   cast call <AUCTION_CONTRACT_ADDRESS> "endTime()" --rpc-url <your_rpc_url>
   ```

## 注意事项

1. 确保在开始拍卖前，NFT 所有者已经授权拍卖合约操作 NFT
2. 投标金额必须大于当前最高出价
3. 拍卖结束后，最高出价者将自动获得 NFT，拍卖创建者将收到最高出价金额
4. 未中标的参与者需要手动调用 withdraw 函数来提取他们的投标金额
