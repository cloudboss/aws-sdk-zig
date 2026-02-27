/// Provides information about the number of resources used.
pub const AcquiredLimit = struct {
    /// The number of limit resources used.
    count: i32,

    /// The unique identifier of the limit.
    limit_id: []const u8,

    pub const json_field_names = .{
        .count = "count",
        .limit_id = "limitId",
    };
};
