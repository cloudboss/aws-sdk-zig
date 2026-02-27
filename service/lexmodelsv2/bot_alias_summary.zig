const BotAliasStatus = @import("bot_alias_status.zig").BotAliasStatus;

/// Summary information about bot aliases returned from the
/// [ListBotAliases](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_ListBotAliases.html) operation.
pub const BotAliasSummary = struct {
    /// The unique identifier assigned to the bot alias. You can use this ID
    /// to get detailed information about the alias using the
    /// [DescribeBotAlias](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_DescribeBotAlias.html) operation.
    bot_alias_id: ?[]const u8,

    /// The name of the bot alias.
    bot_alias_name: ?[]const u8,

    /// The current state of the bot alias. If the status is
    /// `Available`, the alias is ready for use.
    bot_alias_status: ?BotAliasStatus,

    /// The version of the bot that the bot alias references.
    bot_version: ?[]const u8,

    /// A timestamp of the date and time that the bot alias was
    /// created.
    creation_date_time: ?i64,

    /// The description of the bot alias.
    description: ?[]const u8,

    /// A timestamp of the date and time that the bot alias was last
    /// updated.
    last_updated_date_time: ?i64,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_alias_name = "botAliasName",
        .bot_alias_status = "botAliasStatus",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .last_updated_date_time = "lastUpdatedDateTime",
    };
};
