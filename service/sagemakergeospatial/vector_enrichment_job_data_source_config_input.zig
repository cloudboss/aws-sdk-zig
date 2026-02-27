const VectorEnrichmentJobS3Data = @import("vector_enrichment_job_s3_data.zig").VectorEnrichmentJobS3Data;

/// The input structure for the data source that represents the storage type of
/// the input data objects.
pub const VectorEnrichmentJobDataSourceConfigInput = union(enum) {
    /// The input structure for the Amazon S3 data that represents the Amazon S3
    /// location of the input data objects.
    s3_data: ?VectorEnrichmentJobS3Data,

    pub const json_field_names = .{
        .s3_data = "S3Data",
    };
};
