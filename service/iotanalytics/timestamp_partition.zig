/// A partition dimension defined by a timestamp attribute.
pub const TimestampPartition = struct {
    /// The attribute name of the partition defined by a timestamp.
    attribute_name: []const u8,

    /// The timestamp format of a partition defined by a timestamp. The default
    /// format is seconds
    /// since epoch (January 1, 1970 at midnight UTC time).
    timestamp_format: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_name = "attributeName",
        .timestamp_format = "timestampFormat",
    };
};
