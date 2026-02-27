/// A count of documents that meets a specific aggregation criteria.
pub const Bucket = struct {
    /// The number of documents that have the value counted for the particular
    /// bucket.
    count: i32 = 0,

    /// The value counted for the particular bucket.
    key_value: ?[]const u8,

    pub const json_field_names = .{
        .count = "count",
        .key_value = "keyValue",
    };
};
