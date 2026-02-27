/// The current state of a timer.
pub const Timer = struct {
    /// The name of the timer.
    name: []const u8,

    /// The expiration time for the timer.
    timestamp: i64,

    pub const json_field_names = .{
        .name = "name",
        .timestamp = "timestamp",
    };
};
