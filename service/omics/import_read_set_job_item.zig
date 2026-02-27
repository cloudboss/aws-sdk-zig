const ReadSetImportJobStatus = @import("read_set_import_job_status.zig").ReadSetImportJobStatus;

/// An import read set job.
pub const ImportReadSetJobItem = struct {
    /// When the job completed.
    completion_time: ?i64,

    /// When the job was created.
    creation_time: i64,

    /// The job's ID.
    id: []const u8,

    /// The job's service role ARN.
    role_arn: []const u8,

    /// The job's sequence store ID.
    sequence_store_id: []const u8,

    /// The job's status.
    status: ReadSetImportJobStatus,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .creation_time = "creationTime",
        .id = "id",
        .role_arn = "roleArn",
        .sequence_store_id = "sequenceStoreId",
        .status = "status",
    };
};
