const IngestionS3InputConfiguration = @import("ingestion_s3_input_configuration.zig").IngestionS3InputConfiguration;

/// Specifies configuration information for the input data for the data
/// ingestion job,
/// including input data S3 location.
pub const IngestionInputConfiguration = struct {
    /// The location information for the S3 bucket used for input data for the data
    /// ingestion.
    s3_input_configuration: IngestionS3InputConfiguration,

    pub const json_field_names = .{
        .s3_input_configuration = "S3InputConfiguration",
    };
};
