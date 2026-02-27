const ProcessingFeatureStoreOutput = @import("processing_feature_store_output.zig").ProcessingFeatureStoreOutput;
const ProcessingS3Output = @import("processing_s3_output.zig").ProcessingS3Output;

/// Describes the results of a processing job. The processing output must
/// specify exactly one of either `S3Output` or `FeatureStoreOutput` types.
pub const ProcessingOutput = struct {
    /// When `True`, output operations such as data upload are managed natively by
    /// the processing job application. When `False` (default), output operations
    /// are managed by Amazon SageMaker.
    app_managed: ?bool,

    /// Configuration for processing job outputs in Amazon SageMaker Feature Store.
    /// This processing output type is only supported when `AppManaged` is
    /// specified.
    feature_store_output: ?ProcessingFeatureStoreOutput,

    /// The name for the processing job output.
    output_name: []const u8,

    /// Configuration for processing job outputs in Amazon S3.
    s3_output: ?ProcessingS3Output,

    pub const json_field_names = .{
        .app_managed = "AppManaged",
        .feature_store_output = "FeatureStoreOutput",
        .output_name = "OutputName",
        .s3_output = "S3Output",
    };
};
