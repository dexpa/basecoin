package commands

import (
	"github.com/spf13/cobra"

	lc "github.com/tendermint/light-client"
	lcmd "github.com/tendermint/light-client/commands"
	"fmt"
	"github.com/tendermint/tendermint/rpc/client"
)

var AccountSubscribeCmd = &cobra.Command{
	Use:   "subscribe",
	Short: "Get block updates, with proof",
	RunE:  lcmd.RequireInit(createAccountSubscribtion),
}

func createAccountSubscribtion(cmd *cobra.Command, args []string) error {
	//Events-based code. Don't work.
	/*
	c:= client.NewHTTP(viper.GetString("node"), "/websocket")
	status, err := c.Status()
	if err != nil {
		return err
	}
	// listen for a new block; ensure height increases by 1
	var firstBlockHeight int
	firstBlockHeight = status.LatestBlockHeight
	fmt.Printf("Started subscription at %d", firstBlockHeight)
	for {
			evtTyp := types.EventStringNewBlock()
			evt, err := client.WaitForOneEvent(c, evtTyp, 1*time.Second)
			if err != nil {
				return err
			}

			blockEvent, _ := evt.Unwrap().(types.EventDataNewBlock)

			block := blockEvent.Block
			fmt.Println(block)
		}
	*/

	//stupid but it works and this is what Tendermint developers did at 0.10 version
	c := lcmd.GetNode()
	status, err := c.Status()
	if err != nil {
		return err
	}
	h := status.LatestBlockHeight

	client.WaitForHeight(c, h + 1, nil)
	commit, err := c.Commit(h)
	result := lc.CheckpointFromResult(commit)
	fmt.Println(result.Header)
	fmt.Println(commit)
	fmt.Println(commit.Header)
	/*
	fmt.Printf("Started subscription at %d", h)
	waiter := client.DefaultWaitStrategy
	delta := 1
	for {
		s, err := c.Status()
		if err != nil {
			return err
		}
		last := s.LatestBlockHeight
		if h != last { delta = 1 } else { delta +=1 }
		// wait for the time, or abort early
		if err := waiter(delta); err != nil {
			return err
		}
		h = last
		fmt.Printf("Chain now at height %d\n", h)
	}
	*/
	return nil
}
