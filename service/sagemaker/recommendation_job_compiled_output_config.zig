/// Provides information about the output configuration for the compiled model.
pub const RecommendationJobCompiledOutputConfig = struct {
    /// Identifies the Amazon S3 bucket where you want SageMaker to store the
    /// compiled model artifacts.
    s3_output_uri: ?[]const u8,

    pub const json_field_names = .{
        .s3_output_uri = "S3OutputUri",
    };
};
