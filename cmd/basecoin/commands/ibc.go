package commands

import "github.com/dexpa/basecoin/plugins/ibc"

// returns a new IBC plugin to be registered with Basecoin
func NewIBCPlugin() *ibc.IBCPlugin {
	return ibc.New()
}
