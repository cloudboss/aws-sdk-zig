/// A summary of an invalidation request.
pub const InvalidationSummary = struct {
    /// The time that an invalidation request was created.
    create_time: i64,

    /// The unique ID for an invalidation request.
    id: []const u8,

    /// The status of an invalidation request.
    status: []const u8,
};
