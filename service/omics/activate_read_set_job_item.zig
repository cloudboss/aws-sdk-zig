const ReadSetActivationJobStatus = @import("read_set_activation_job_status.zig").ReadSetActivationJobStatus;

/// A read set activation job.
pub const ActivateReadSetJobItem = struct {
    /// When the job completed.
    completion_time: ?i64 = null,

    /// When the job was created.
    creation_time: i64,

    /// The job's ID.
    id: []const u8,

    /// The job's sequence store ID.
    sequence_store_id: []const u8,

    /// The job's status.
    status: ReadSetActivationJobStatus,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .creation_time = "creationTime",
        .id = "id",
        .sequence_store_id = "sequenceStoreId",
        .status = "status",
    };
};
