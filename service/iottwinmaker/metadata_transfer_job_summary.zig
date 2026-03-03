const MetadataTransferJobProgress = @import("metadata_transfer_job_progress.zig").MetadataTransferJobProgress;
const MetadataTransferJobStatus = @import("metadata_transfer_job_status.zig").MetadataTransferJobStatus;

/// The metadata transfer job summary.
pub const MetadataTransferJobSummary = struct {
    /// The metadata transfer job summary ARN.
    arn: []const u8,

    /// The metadata transfer job summary creation DateTime object.
    creation_date_time: i64,

    /// The metadata transfer job summary Id.
    metadata_transfer_job_id: []const u8,

    /// The metadata transfer job summary progess.
    progress: ?MetadataTransferJobProgress = null,

    /// The metadata transfer job summary status.
    status: MetadataTransferJobStatus,

    /// The metadata transfer job summary update DateTime object
    update_date_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .metadata_transfer_job_id = "metadataTransferJobId",
        .progress = "progress",
        .status = "status",
        .update_date_time = "updateDateTime",
    };
};
