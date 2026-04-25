/// The output configuration for an AI recommendation job.
pub const AIRecommendationOutputConfig = struct {
    /// The name or Amazon Resource Name (ARN) of the model package group where the
    /// optimized model is registered as a new model package version.
    model_package_group_identifier: ?[]const u8 = null,

    /// The Amazon S3 URI where recommendation results are stored.
    s3_output_location: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_package_group_identifier = "ModelPackageGroupIdentifier",
        .s3_output_location = "S3OutputLocation",
    };
};
