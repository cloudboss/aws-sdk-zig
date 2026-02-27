/// The retention settings that determine how long to retain conversation
/// messages for an Amazon Chime Enterprise account.
pub const ConversationRetentionSettings = struct {
    /// The number of days for which to retain conversation messages.
    retention_days: ?i32,

    pub const json_field_names = .{
        .retention_days = "RetentionDays",
    };
};
