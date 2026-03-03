const ReadSetExportJobStatus = @import("read_set_export_job_status.zig").ReadSetExportJobStatus;

/// Details about a read set export job.
pub const ExportReadSetJobDetail = struct {
    /// When the job completed.
    completion_time: ?i64 = null,

    /// When the job was created.
    creation_time: i64,

    /// The job's destination in Amazon S3.
    destination: []const u8,

    /// The job's ID.
    id: []const u8,

    /// The job's sequence store ID.
    sequence_store_id: []const u8,

    /// The job's status.
    status: ReadSetExportJobStatus,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .creation_time = "creationTime",
        .destination = "destination",
        .id = "id",
        .sequence_store_id = "sequenceStoreId",
        .status = "status",
    };
};
