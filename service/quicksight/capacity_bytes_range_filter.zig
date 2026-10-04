/// A filter that matches users by total capacity range in bytes.
pub const CapacityBytesRangeFilter = struct {
    /// The maximum capacity in bytes (inclusive). At least one of minBytes or
    /// maxBytes is required.
    max_bytes: ?i64 = null,

    /// The minimum capacity in bytes (inclusive). At least one of minBytes or
    /// maxBytes is required.
    min_bytes: ?i64 = null,

    pub const json_field_names = .{
        .max_bytes = "maxBytes",
        .min_bytes = "minBytes",
    };
};
