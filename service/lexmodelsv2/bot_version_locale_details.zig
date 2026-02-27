/// The version of a bot used for a bot locale.
pub const BotVersionLocaleDetails = struct {
    /// The version of a bot used for a bot locale.
    source_bot_version: []const u8,

    pub const json_field_names = .{
        .source_bot_version = "sourceBotVersion",
    };
};
