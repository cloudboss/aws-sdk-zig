/// Specifies the location of an identified issue within the bot configuration.
pub const IssueLocation = struct {
    /// The locale identifier where the issue was found.
    bot_locale: ?[]const u8 = null,

    /// The intent identifier where the issue was found, if applicable.
    intent_id: ?[]const u8 = null,

    /// The slot identifier where the issue was found, if applicable.
    slot_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_locale = "botLocale",
        .intent_id = "intentId",
        .slot_id = "slotId",
    };
};
