package main

import (
	"context"
	"fmt"
	"os"
)

func printMessage(session disgord.Session, evt *disgord.MessageCreate) {
	msg := evt.Message
	fmt.Println(msg.Author.String() + ": " + msg.Content) // Anders#7248{435358734985}: Hello there
}
func main() {
	client := disgord.New(disgord.Config{
		BotToken: os.Getenv("BOT_TOKEN"),
		// You can inject any logger that implements disgord.Logger interface (eg. logrus)
		// Disgord provides a simple logger to get you started. Nothing is logged if nil.
		Logger: disgord.DefaultLogger(false), // debug=false
	})
	// connect, and stay connected until a system interrupt takes place
	defer client.StayConnectedUntilInterrupted(context.Background())

	// create a handler and bind it to new message events
	// handlers/listener are run in sequence if you register more than one
	// so you should not need to worry about locking your objects unless you do any
	// parallel computing with said objects
	client.On(disgord.EvtMessageCreate, printMessage)
}
