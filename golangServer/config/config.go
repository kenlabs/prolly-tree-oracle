package config

import (
	"Oracle.com/golangServer/Oracle"
	"crypto/ecdsa"
	"github.com/RangerMauve/ipld-prolly-indexer/indexer"
	"github.com/ethereum/go-ethereum/ethclient"
)

const (
	URL                   = "ws://127.0.0.1:8545"
	OracleOwnerPrivateKey = "0xa1c02aed7d70e580c62576f066ce6708aa01546a3490339aeb7193e5cede8b6d"
	ContractAddress       = "0x56276E65381E3BcD879B1f049663C65e5bBD0769"
	ChainID               = 1337
	SaveDataPath          = "golangServer/savedDatas/"
)

var (
	Client *ethclient.Client

	PrivateKey *ecdsa.PrivateKey

	OracleContract *Oracle.Oracle

	Dbs map[string]*indexer.Database //mapping dbName address to db

	GasLimit uint64 = 300000
)
