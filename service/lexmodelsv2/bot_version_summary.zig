const BotStatus = @import("bot_status.zig").BotStatus;

/// Summary information about a bot version returned by the
/// [ListBotVersions](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_ListBotVersions.html) operation.
pub const BotVersionSummary = struct {
    /// The name of the bot associated with the version.
    bot_name: ?[]const u8,

    /// The status of the bot. When the status is available, the version of
    /// the bot is ready for use.
    bot_status: ?BotStatus,

    /// The numeric version of the bot, or `DRAFT` to indicate
    /// that this is the version of the bot that can be updated..
    bot_version: ?[]const u8,

    /// A timestamp of the date and time that the version was
    /// created.
    creation_date_time: ?i64,

    /// The description of the version.
    description: ?[]const u8,

    pub const json_field_names = .{
        .bot_name = "botName",
        .bot_status = "botStatus",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .description = "description",
    };
};
