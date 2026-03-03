/// The details of the retention settings for a channel.
pub const ChannelRetentionSettings = struct {
    /// The time in days to retain the messages in a channel.
    retention_days: ?i32 = null,

    pub const json_field_names = .{
        .retention_days = "RetentionDays",
    };
};
