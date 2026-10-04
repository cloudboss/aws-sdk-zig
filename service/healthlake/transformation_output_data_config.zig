const DataTransformationS3Configuration = @import("data_transformation_s3_configuration.zig").DataTransformationS3Configuration;

/// The Amazon S3 output location and encryption configuration for a
/// transformation job.
pub const TransformationOutputDataConfig = struct {
    /// The Amazon S3 output location and Amazon Web Services Key Management Service
    /// (Amazon Web Services KMS) encryption configuration.
    s3_configuration: DataTransformationS3Configuration,

    pub const json_field_names = .{
        .s3_configuration = "S3Configuration",
    };
};
