package commands

import (
	"github.com/spf13/cobra"

	lcmd "github.com/tendermint/light-client/commands"
	"github.com/tendermint/tendermint/rpc/client"
	"fmt"
)

var AccountSubscribeCmd = &cobra.Command{
	Use:   "subscribe",
	Short: "Get block updates, with proof",
	RunE:  lcmd.RequireInit(createAccountSubscribtion),
}

func createAccountSubscribtion(cmd *cobra.Command, args []string) error {
	c := lcmd.GetNode()

	status, err := c.Status()
	h := status.LatestBlockHeight + 1

	for {
		err = client.WaitForHeight(c, h, nil)
		if err != nil {
			return err
		}
		fmt.Printf("Chain now at height %d\n", h)
		h = h + 1
	}

	return nil
}
