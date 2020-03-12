module Bot

using Revise

using Discord

function bot()
    c = Client("BOT_KEY"; prefix = ">")

    function reply_bot_ping(c, m::Message)
        bot_ping = heartbeat_ping(c)
        reply(c, m, "My ping is $bot_ping.")
    end
    function reply_bot_info(c, m::Message)
        bot_guilds = get_guild(c)
        bot_members =
        reply(c, m, "\`\`\` Bot Version: 1.0.0
        \n Using: Discord.jl
        \n Current Guilds = $bot_guilds
        \n Current Members = $bot_members
        \`\`\`")
    end

    add_handler!(c, compile=true, MessageCreate, (_, e) -> println("Received message: $(e.message.content)"))
    add_command!(c, compile=true, :echo; pattern=r"^echo (.+)", help="Echos what you typed in") do c, msg, noprefix
        reply(c, msg, noprefix)
    end
    add_command!(c, compile=true, :roll; pattern=r"^roll (.+)", help="Rolls a dice with the number of sides given") do c, msg, value
        println("Number recieved: $value")
        isnum = isa(value, Number)
        println("Is num: $isnum")
        roll_num = int(rand(int32(0):int32(value)))
        reply(c, msg, "You got $roll_num.")
        # if isa(value, Number)
        #     println("Is number")
        #     roll_num = int(rand(int32(0):int32(value)))
        #     reply(c, msg, "You got $roll_num.")
        # else
        #     println("Not number")
        #     reply(c, msg, "Please enter a number!")
        # end
    end
    add_command!(c, compile=true, :botinfo, reply_bot_info; help = "Shows the stats of the bot")
    add_command!(c, compile=true, :ping, reply_bot_ping; help="Shows the ping from the bot to Discord servers")
    add_help!(c; pattern=r"^help(?: (.+))?", help="Show this help message", nohelp="No help provided", nocmd="Command not found")

    open(c)
    return c
end

end

if abspath(PROGRAM_FILE) == @__FILE__
    c = Bot.bot()
    wait(c)
end
