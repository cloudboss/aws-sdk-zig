/// The configuration for the Model package.
pub const ModelPackageConfig = struct {
    /// The Amazon Resource Name (ARN) of the model package group of output model
    /// package.
    model_package_group_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the source model package used for
    /// continued fine-tuning and custom model evaluation.
    source_model_package_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_package_group_arn = "ModelPackageGroupArn",
        .source_model_package_arn = "SourceModelPackageArn",
    };
};
