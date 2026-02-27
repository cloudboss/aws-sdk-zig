const VectorEnrichmentJobErrorType = @import("vector_enrichment_job_error_type.zig").VectorEnrichmentJobErrorType;

/// VectorEnrichmentJob error details in response from GetVectorEnrichmentJob.
pub const VectorEnrichmentJobErrorDetails = struct {
    /// A message that you define and then is processed and rendered by
    /// the Vector Enrichment job when the error occurs.
    error_message: ?[]const u8,

    /// The type of error generated during the Vector Enrichment job.
    error_type: ?VectorEnrichmentJobErrorType,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .error_type = "ErrorType",
    };
};
