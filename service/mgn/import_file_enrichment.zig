const Checksum = @import("checksum.zig").Checksum;
const EnrichmentTargetS3Configuration = @import("enrichment_target_s3_configuration.zig").EnrichmentTargetS3Configuration;
const ImportFileEnrichmentStatus = @import("import_file_enrichment_status.zig").ImportFileEnrichmentStatus;

/// Details about an import file enrichment job.
pub const ImportFileEnrichment = struct {
    /// The checksum of the enriched file for integrity verification.
    checksum: ?Checksum = null,

    /// The timestamp when the enrichment job was created.
    created_at: ?i64 = null,

    /// The timestamp when the enrichment job completed or failed.
    ended_at: ?i64 = null,

    /// The unique identifier of the import file enrichment job.
    job_id: ?[]const u8 = null,

    /// The target S3 configuration for the enriched import file.
    s_3_bucket_target: ?EnrichmentTargetS3Configuration = null,

    /// The current status of the import file enrichment job.
    status: ?ImportFileEnrichmentStatus = null,

    /// Detailed status information about the enrichment job.
    status_details: ?[]const u8 = null,

    pub const json_field_names = .{
        .checksum = "checksum",
        .created_at = "createdAt",
        .ended_at = "endedAt",
        .job_id = "jobID",
        .s_3_bucket_target = "s3BucketTarget",
        .status = "status",
        .status_details = "statusDetails",
    };
};
