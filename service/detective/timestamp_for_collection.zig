/// Details on when data collection began for a source package.
pub const TimestampForCollection = struct {
    /// The data and time when data collection began for a source package. The value
    /// is an
    /// ISO8601 formatted string. For example, `2021-08-18T16:35:56.284Z`.
    timestamp: ?i64,

    pub const json_field_names = .{
        .timestamp = "Timestamp",
    };
};
