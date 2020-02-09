module Main

using Revise

using Discord

function main()
    c = Client("DISCORD_TOKEN"; prefix = ">")

    function reply_bot_ping(c::Client, m::Message)
        bot_ping = heartbeat_ping(c)
        reply(c, m, "My ping is $bot_ping.")
    end

    function

    add_handler!(c, compile=true, MessageCreate, (_, e) -> println("Received message: $(e.message.content)"))
    add_command!(c, compile=true, :echo; pattern=r"^echo (.+)", help="Echos what you typed in") do c, msg, noprefix
        reply(c, msg, noprefix)
    end
    add_command!(c, compile=true, :ping, reply_bot_ping; help="Shows the ping from the bot to Discord servers")
    add_help!(c; pattern=r"^help(?: (.+))?", help="Show this help message", nohelp="No help provided", nocmd="Command not found",)

    open(c)
    return c
end

end

if abspath(PROGRAM_FILE) == @__FILE__
    c = Main.main()
    wait(c)
end
