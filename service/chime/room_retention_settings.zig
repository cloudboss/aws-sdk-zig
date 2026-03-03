/// The retention settings that determine how long to retain chat-room messages
/// for an Amazon Chime Enterprise account.
pub const RoomRetentionSettings = struct {
    /// The number of days for which to retain chat-room messages.
    retention_days: ?i32 = null,

    pub const json_field_names = .{
        .retention_days = "RetentionDays",
    };
};
