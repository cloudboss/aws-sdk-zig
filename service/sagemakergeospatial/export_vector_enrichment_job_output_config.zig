const VectorEnrichmentJobS3Data = @import("vector_enrichment_job_s3_data.zig").VectorEnrichmentJobS3Data;

/// An object containing information about the output file.
pub const ExportVectorEnrichmentJobOutputConfig = struct {
    /// The input structure for Amazon S3 data; representing the Amazon S3 location
    /// of the input data objects.
    s3_data: VectorEnrichmentJobS3Data,

    pub const json_field_names = .{
        .s3_data = "S3Data",
    };
};
