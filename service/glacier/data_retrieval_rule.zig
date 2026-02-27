/// Data retrieval policy rule.
pub const DataRetrievalRule = struct {
    /// The maximum number of bytes that can be retrieved in an hour.
    ///
    /// This field is required only if the value of the Strategy field is
    /// `BytesPerHour`. Your PUT operation will be rejected if the Strategy field is
    /// not set to `BytesPerHour` and you set this field.
    bytes_per_hour: ?i64,

    /// The type of data retrieval policy to set.
    ///
    /// Valid values: BytesPerHour|FreeTier|None
    strategy: ?[]const u8,

    pub const json_field_names = .{
        .bytes_per_hour = "BytesPerHour",
        .strategy = "Strategy",
    };
};
