const BatchStatus = @import("batch_status.zig").BatchStatus;

/// A summary of a batch returned by `ListBatch`.
pub const BatchListItem = struct {
    /// The timestamp when the batch was created.
    created_at: ?i64 = null,

    /// The batch identifier.
    id: ?[]const u8 = null,

    /// The batch name.
    name: ?[]const u8 = null,

    /// The current batch status.
    status: ?BatchStatus = null,

    /// The total number of runs in the batch.
    total_runs: ?i32 = null,

    /// The identifier of the workflow used for the batch.
    workflow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .id = "id",
        .name = "name",
        .status = "status",
        .total_runs = "totalRuns",
        .workflow_id = "workflowId",
    };
};
