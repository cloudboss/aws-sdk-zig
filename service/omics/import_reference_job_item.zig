const ReferenceImportJobStatus = @import("reference_import_job_status.zig").ReferenceImportJobStatus;

/// An import reference job.
pub const ImportReferenceJobItem = struct {
    /// When the job completed.
    completion_time: ?i64,

    /// When the job was created.
    creation_time: i64,

    /// The job's ID.
    id: []const u8,

    /// The job's reference store ID.
    reference_store_id: []const u8,

    /// The job's service role ARN.
    role_arn: []const u8,

    /// The job's status.
    status: ReferenceImportJobStatus,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .creation_time = "creationTime",
        .id = "id",
        .reference_store_id = "referenceStoreId",
        .role_arn = "roleArn",
        .status = "status",
    };
};
