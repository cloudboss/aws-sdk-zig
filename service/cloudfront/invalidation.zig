const InvalidationBatch = @import("invalidation_batch.zig").InvalidationBatch;

/// An invalidation.
pub const Invalidation = struct {
    /// The date and time the invalidation request was first made.
    create_time: i64,

    /// The identifier for the invalidation request. For example: `IDFDVBD632BHDS5`.
    id: []const u8,

    /// The current invalidation information for the batch request.
    invalidation_batch: InvalidationBatch,

    /// The status of the invalidation request. When the invalidation batch is
    /// finished, the status is `Completed`.
    status: []const u8,
};
