# jether - Control Center for Ethereum based blockchain

jether is a simple dialog tool for a set of shell commands I usually can't remember because because these ethereum and geth commands are long as hell and also fail silently. 


This tool is optimized for mac.

## What you need

### Tools
- dialog (`brew install dialog`   )
- go-ethereum (`brew install ethereum` or [https://github.com/ethereum/go-ethereum/wiki/Installation-Instructions-for-Mac]())

### Applications

- Ethereum Wallet [https://github.com/ethereum/mist/releases]()
- Mist [https://github.com/ethereum/mist/releases]()

## Download current Version:

| Filename  | Version  | Date  |
|---|:-:|:-:|
| [jether_1.0.zip](https://github.com/Decksname/jether/blob/master/releases/jether_1.0.zip)  | 1.0  | 18. Nov 2017  |



## Setup

This tool has two configuration files:

- default_jethereum.cfg: contains gobal configuration for accessing the blockchain.
- personal_jethereum.cfg: contains your personal settings, make sure to adjust them to your needs and local settings

#### Configuration Parameters

| Parameter  | Desription  |
|---|---|
| DATADIR  | This path to your data directory. The place where you want to store your blockchain  | 
| IPC | Path to the IPC (Inter-process Communications) pipe of your node. This is needed to connect other tools like Mist to your node.   Usually it's /geth.ipc in your datadir| 
| ACCOUNT   | The account you want to mine with.  |   
| THREADSFORMINING | The number of threads you want to use for mining. |
|OWNPORT | For your own port you can use any port **EXCEPT** 30303 or 30304|
|APP_ETHEREUMWALLET| Path to your Ethereum Wallet application. This will be the same on most mac systems. It is required to start the application and make it connect to your private network and not the mainnet |
|APP_MIST|Path to your Ethereum Wallet application. This will be the same on most mac systems. It is required to start the application and make it connect to your private network and not the mainnet|


## Run

`./jether.sh`
