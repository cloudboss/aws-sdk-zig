/// Updates a blocked phrases configuration in your Amazon Q Business
/// application.
pub const BlockedPhrasesConfigurationUpdate = struct {
    /// Creates or updates a blocked phrases configuration in your Amazon Q Business
    /// application.
    blocked_phrases_to_create_or_update: ?[]const []const u8,

    /// Deletes a blocked phrases configuration in your Amazon Q Business
    /// application.
    blocked_phrases_to_delete: ?[]const []const u8,

    /// The configured custom message displayed to your end user when they use
    /// blocked phrase during chat.
    system_message_override: ?[]const u8,

    pub const json_field_names = .{
        .blocked_phrases_to_create_or_update = "blockedPhrasesToCreateOrUpdate",
        .blocked_phrases_to_delete = "blockedPhrasesToDelete",
        .system_message_override = "systemMessageOverride",
    };
};
