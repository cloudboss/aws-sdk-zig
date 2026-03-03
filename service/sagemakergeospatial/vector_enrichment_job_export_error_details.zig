const VectorEnrichmentJobExportErrorType = @import("vector_enrichment_job_export_error_type.zig").VectorEnrichmentJobExportErrorType;

/// VectorEnrichmentJob export error details in response from
/// GetVectorEnrichmentJob.
pub const VectorEnrichmentJobExportErrorDetails = struct {
    /// The message providing details about the errors generated during the Vector
    /// Enrichment job.
    message: ?[]const u8 = null,

    /// The output error details for an Export operation on a Vector Enrichment job.
    @"type": ?VectorEnrichmentJobExportErrorType = null,

    pub const json_field_names = .{
        .message = "Message",
        .@"type" = "Type",
    };
};
