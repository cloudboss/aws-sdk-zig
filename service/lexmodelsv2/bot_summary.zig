const BotStatus = @import("bot_status.zig").BotStatus;
const BotType = @import("bot_type.zig").BotType;

/// Summary information about a bot returned by the
/// [ListBots](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_ListBots.html) operation.
pub const BotSummary = struct {
    /// The unique identifier assigned to the bot. Use this ID to get
    /// detailed information about the bot with the
    /// [DescribeBot](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_DescribeBot.html) operation.
    bot_id: ?[]const u8 = null,

    /// The name of the bot.
    bot_name: ?[]const u8 = null,

    /// The current status of the bot. When the status is
    /// `Available` the bot is ready for use.
    bot_status: ?BotStatus = null,

    /// The type of the bot.
    bot_type: ?BotType = null,

    /// The description of the bot.
    description: ?[]const u8 = null,

    /// The date and time that the bot was last updated.
    last_updated_date_time: ?i64 = null,

    /// The latest numerical version in use for the bot.
    latest_bot_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_name = "botName",
        .bot_status = "botStatus",
        .bot_type = "botType",
        .description = "description",
        .last_updated_date_time = "lastUpdatedDateTime",
        .latest_bot_version = "latestBotVersion",
    };
};
